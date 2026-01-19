import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:focus_quest/core/theme/app_theme.dart';
import 'package:focus_quest/core/theme/app_colors.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmGrey,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo or Hero Image Placeholder
                const Icon(
                  Icons.spa_rounded,
                  size: 80,
                  color: AppColors.calmBlue,
                ),
                const SizedBox(height: 24),
                Text(
                  'Focus Quest',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 16),
                Text(
                  'Ritrova il tuo ritmo. Senza ansia.',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                
                // Functionality Highlights
                _buildFeatureItem(
                  context,
                  icon: Icons.timelapse,
                  title: 'Avvio Rapido',
                  description: 'Dimmi quanto tempo hai, ti dirò cosa fare.',
                ),
                _buildFeatureItem(
                  context,
                  icon: Icons.cloud_off,
                  title: 'Offline First',
                  description: 'Sempre con te, anche senza internet.',
                ),
                _buildFeatureItem(
                  context,
                  icon: Icons.favorite_border,
                  title: 'Zero Giudizio',
                  description: 'Gamification gentile per motivarti.',
                ),
                
                const SizedBox(height: 64),
                
                // CTA
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/signup'); 
                    },
                    child: const Text('Inizia il tuo viaggio'),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    context.push('/login');
                  },
                  child: const Text('Hai già un account? Accedi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, {required IconData icon, required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.lilac.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.calmBlue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
