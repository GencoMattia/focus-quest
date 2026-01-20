import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:focus_quest/core/theme/app_theme.dart';
import 'package:focus_quest/core/theme/app_colors.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spaceLg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo with gradient background
                Container(
                  padding: const EdgeInsets.all(AppTheme.spaceLg),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryLight.withOpacity(0.3),
                        AppColors.secondaryLight.withOpacity(0.3),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.spa_rounded,
                    size: 80,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: AppTheme.spaceLg),
                
                // App name
                Text(
                  'Focus Quest',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: AppTheme.spaceSm),
                
                // Tagline
                Text(
                  'Ritrova il tuo ritmo. Senza ansia.',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.space2xl),
                
                // Features
                _buildFeatureItem(
                  context,
                  icon: Icons.bolt_outlined,
                  title: 'Avvio Rapido',
                  description: 'Dimmi quanto tempo hai, ti dirò cosa fare.',
                  color: AppColors.primary,
                ),
                const SizedBox(height: AppTheme.spaceMd),
                _buildFeatureItem(
                  context,
                  icon: Icons.cloud_off_outlined,
                  title: 'Offline First',
                  description: 'Sempre con te, anche senza internet.',
                  color: AppColors.secondary,
                ),
                const SizedBox(height: AppTheme.spaceMd),
                _buildFeatureItem(
                  context,
                  icon: Icons.favorite_outline,
                  title: 'Zero Giudizio',
                  description: 'Gamification gentile per motivarti.',
                  color: AppColors.accent,
                ),
                
                const SizedBox(height: AppTheme.space3xl),
                
                // CTA Buttons
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      context.push('/signup'); 
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppTheme.spaceMd + AppTheme.spaceXs,
                      ),
                    ),
                    child: const Text('Inizia il tuo viaggio'),
                  ),
                ),
                const SizedBox(height: AppTheme.spaceMd),
                TextButton(
                  onPressed: () {
                    context.push('/login');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('Hai già un account? '),
                      Text('Accedi', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spaceSm),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: AppTheme.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppTheme.spaceXs),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
