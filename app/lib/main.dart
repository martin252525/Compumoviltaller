import 'package:app/data/services/vote_api_service.dart';
import 'package:app/presentation/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final _logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase de forma condicional
  // Si falla (ej: falta google-services.json), la app sigue funcionando
  // pero sin autenticación
  bool firebaseInitialized = false;
  try {
    await Firebase.initializeApp();
    firebaseInitialized = true;
    _logger.i("Firebase inicializado correctamente");
  } catch (e) {
    _logger.w("Firebase no pudo inicializarse: $e");
    _logger.w("La app funcionará sin autenticación. Para habilitar autenticación:");
    _logger.w("1. Crea un proyecto en Firebase Console");
    _logger.w("2. Descarga google-services.json");
    _logger.w("3. Colócalo en android/app/");
  }

  // Inicializar servicio de API
  VoteApiService.initialize();

  runApp(ProviderScope(
    overrides: [
      // Provider para indicar si Firebase está disponible
      firebaseAvailableProvider.overrideWithValue(firebaseInitialized),
    ],
    child: const MyApp(),
  ));
}

// Provider para saber si Firebase está disponible
final firebaseAvailableProvider = Provider<bool>((ref) => false);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Votación',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
