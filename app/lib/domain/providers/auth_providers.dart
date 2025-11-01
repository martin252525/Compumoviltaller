import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../consts/app_const.dart';

final _logger = Logger();

/// Provider del servicio de autenticación
final authServiceProvider = Provider((ref) => AuthService());

/// Provider del estado del usuario actual
final currentUserProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

/// Servicio de autenticación con Firebase
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Usuario actual
  User? get currentUser => _firebaseAuth.currentUser;

  /// Stream de cambios de autenticación
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Verificar si hay un token válido
  Future<bool> hasValidToken() async {
    final token = await _storage.read(key: AppConst.idTokenLabel);
    return token != null && token.isNotEmpty && currentUser != null;
  }

  /// Obtener el token de ID del usuario actual
  Future<String?> getIdToken() async {
    try {
      final user = currentUser;
      if (user != null) {
        final token = await user.getIdToken();
        if (token != null) {
          await _storage.write(key: AppConst.idTokenLabel, value: token);
        }
        return token;
      }
      return await _storage.read(key: AppConst.idTokenLabel);
    } catch (e) {
      _logger.e("Error al obtener token", error: e);
      return null;
    }
  }

  /// Iniciar sesión con Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // El usuario canceló el inicio de sesión
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      // Guardar información del usuario
      if (userCredential.user != null) {
        final user = userCredential.user!;
        final token = await user.getIdToken();

        if (token != null) {
          await _storage.write(key: AppConst.idTokenLabel, value: token);
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConst.emailLabel, user.email ?? '');
        await prefs.setString(AppConst.nameLabel, user.displayName ?? '');
        await prefs.setString(AppConst.photoUrlLabel, user.photoURL ?? '');

        _logger.i("Inicio de sesión exitoso: ${user.email}");
      }

      return userCredential;
    } catch (e, stackTrace) {
      _logger.e("Error en inicio de sesión con Google",
          error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Cerrar sesión
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();

      // Limpiar datos guardados
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      await _storage.delete(key: AppConst.idTokenLabel);
      await _storage.deleteAll();

      _logger.i("Sesión cerrada exitosamente");
    } catch (e, stackTrace) {
      _logger.e("Error al cerrar sesión", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Obtener información del perfil del usuario
  Future<Map<String, String>> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'email': prefs.getString(AppConst.emailLabel) ?? '',
      'name': prefs.getString(AppConst.nameLabel) ?? '',
      'photoUrl': prefs.getString(AppConst.photoUrlLabel) ?? '',
    };
  }
}

/// Estado de autenticación
enum AuthState {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

/// Provider del estado de autenticación
final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier(ref.watch(authServiceProvider));
});

/// Notifier para el estado de autenticación
class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthStateNotifier(this._authService) : super(AuthState.initial) {
    _checkInitialAuth();
  }

  Future<void> _checkInitialAuth() async {
    final hasToken = await _authService.hasValidToken();
    state = hasToken ? AuthState.authenticated : AuthState.unauthenticated;
  }

  Future<bool> signInWithGoogle() async {
    state = AuthState.loading;
    try {
      final userCredential = await _authService.signInWithGoogle();
      if (userCredential != null) {
        state = AuthState.authenticated;
        return true;
      } else {
        state = AuthState.unauthenticated;
        return false;
      }
    } catch (e) {
      state = AuthState.error;
      _logger.e("Error en inicio de sesión", error: e);
      return false;
    }
  }

  Future<void> signOut() async {
    state = AuthState.loading;
    try {
      await _authService.signOut();
      state = AuthState.unauthenticated;
    } catch (e) {
      state = AuthState.error;
      _logger.e("Error al cerrar sesión", error: e);
    }
  }
}

