import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_quest/core/presentation/widgets/calm_button.dart';
import 'package:focus_quest/core/presentation/widgets/calm_card.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/features/auth/data/auth_repository.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _signup() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) return;
    
    setState(() => _isLoading = true);
    try {
      await ref.read(authRepositoryProvider).signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account creato! Benvenutə a bordo 🚀')),
        );
        // Router will handle redirect
      }
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
      appBar: AppBar(title: const Text('Unisciti a noi 🧘')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text(
                'Inizia il tuo viaggio verso una produttività più serena.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: AppColors.textLight),
              ),
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
                          text: 'Registrati',
                          type: CalmButtonType.secondary,
                          onPressed: _signup,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Hai già un account? Accedi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
