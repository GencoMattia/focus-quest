import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_quest/core/presentation/widgets/calm_button.dart';
import 'package:focus_quest/core/presentation/widgets/calm_card.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/features/auth/data/auth_repository.dart';
import 'package:focus_quest/features/auth/data/guest_mode_provider.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) return;
    
    setState(() => _isLoading = true);
    try {
      await ref.read(authRepositoryProvider).signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      // Router will handle redirect based on auth state
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmGrey,
      appBar: AppBar(title: const Text('Bentornatə! 🌿')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(Icons.spa, size: 64, color: AppColors.sageGreen),
              const SizedBox(height: 32),
              CalmCard(
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      SizedBox(
                        width: double.infinity,
                        child: CalmButton(
                          text: 'Accedi',
                          onPressed: _login,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => context.push('/signup'),
                child: const Text('Non hai un account? Registrati'),
              ),
              TextButton(
                onPressed: () {
                  // Enter Guest Mode
                  ref.read(guestModeProvider.notifier).enterGuestMode();
                  // Router redirect will happen automatically
                },
                child: const Text(
                  'Prova senza account (Offline)',
                  style: TextStyle(color: AppColors.textLight, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
