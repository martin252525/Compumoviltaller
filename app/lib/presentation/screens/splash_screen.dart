import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/providers/auth_providers.dart';
import '../../main.dart';
import '../../screens/login_screen.dart';
import 'votes_list_screen.dart';

/// Pantalla de inicio que verifica el estado de autenticación
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    // Esperar 2 segundos para mostrar el splash
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Verificar si Firebase está disponible
    final firebaseAvailable = ref.read(firebaseAvailableProvider);
    
    if (!firebaseAvailable) {
      // Si Firebase no está disponible, ir directamente a la lista
      // El usuario puede explorar sin autenticación
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const VotesListScreen(),
        ),
      );
      return;
    }

    // Verificar si hay sesión guardada
    final authService = ref.read(authServiceProvider);
    final hasToken = await authService.hasValidToken();

    if (!mounted) return;

    // Navegar según el estado
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            hasToken ? const VotesListScreen() : const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.how_to_vote,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              Text(
                'Sistema de Votación',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 48),
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

