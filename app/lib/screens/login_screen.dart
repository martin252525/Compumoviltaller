import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/providers/auth_providers.dart';
import '../../main.dart';
import '../../presentation/screens/votes_list_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    // Verificar si Firebase está disponible
    final firebaseAvailable = ref.read(firebaseAvailableProvider);
    
    if (!firebaseAvailable) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Firebase no está configurado. Para habilitar autenticación:\n'
            '1. Crea un proyecto en Firebase Console\n'
            '2. Descarga google-services.json\n'
            '3. Colócalo en android/app/',
          ),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final success = await ref.read(authStateProvider.notifier).signInWithGoogle();

      if (!mounted) return;

      if (success) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const VotesListScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Inicio de sesión cancelado'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al iniciar sesión: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseAvailable = ref.watch(firebaseAvailableProvider);
    
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
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icono de votación
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.how_to_vote,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Título
                  Text(
                    'Sistema de Votación',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Subtítulo
                  Text(
                    'Inicia sesión para participar en las votaciones',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  // Advertencia si Firebase no está disponible
                  if (!firebaseAvailable)
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.warning, color: Colors.white),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Autenticación no disponible.\nFalta configuración de Firebase.',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Botón de Google Sign In
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _handleGoogleSignIn,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Image.asset(
                            'assets/google_logo.png',
                            height: 24,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.login),
                          ),
                    label: Text(
                      _isLoading ? 'Iniciando sesión...' : 'Iniciar sesión con Google',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Botón para explorar sin autenticación
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const VotesListScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Explorar sin iniciar sesión',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
