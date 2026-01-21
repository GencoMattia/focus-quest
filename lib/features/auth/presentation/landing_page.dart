import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:focus_quest/core/theme/app_theme.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/core/presentation/widgets/decorative_shapes.dart';
import 'package:focus_quest/core/presentation/widgets/animated_calm_card.dart';
import 'package:focus_quest/core/theme/app_animations.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.slow,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.easeOut),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.fastOutSlowIn),
    );
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background shapes
          const DecorativeShapes(animated: true),
          
          // Content with gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.subtleGradient.scale(0.7),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppTheme.spaceLg),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo with gradient background and animation
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: AppAnimations.verySlow,
                            curve: AppAnimations.elasticOut,
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Container(
                                  padding: const EdgeInsets.all(AppTheme.spaceLg),
                                  decoration: BoxDecoration(
                                    gradient: AppColors.heroGradient,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primary.withOpacity(0.3),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.spa_rounded,
                                    size: 80,
                                    color: AppColors.surface,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: AppTheme.spaceLg),
                          
                          // App name with animation
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: AppAnimations.slow,
                            curve: Curves.easeOut,
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: ShaderMask(
                                  shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                                  child: Text(
                                    'Focus Quest',
                                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
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
                          
                          // Features with staggered animation
                          AnimatedCalmCard(
                            delay: AppAnimations.staggerDelay,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryLight.withOpacity(0.3),
                                AppColors.surface,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            child: _buildFeatureContent(
                              context,
                              icon: Icons.bolt_outlined,
                              title: 'Avvio Rapido',
                              description: 'Dimmi quanto tempo hai, ti dirò cosa fare.',
                              color: AppColors.primary,
                            ),
                          ),
                          AnimatedCalmCard(
                            delay: AppAnimations.staggerDelay * 2,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.secondaryLight.withOpacity(0.3),
                                AppColors.surface,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            child: _buildFeatureContent(
                              context,
                              icon: Icons.cloud_off_outlined,
                              title: 'Offline First',
                              description: 'Sempre con te, anche senza internet.',
                              color: AppColors.secondary,
                            ),
                          ),
                          AnimatedCalmCard(
                            delay: AppAnimations.staggerDelay * 3,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.accentLight.withOpacity(0.3),
                                AppColors.surface,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            child: _buildFeatureContent(
                              context,
                              icon: Icons.favorite_outline,
                              title: 'Zero Giudizio',
                              description: 'Gamification gentile per motivarti.',
                              color: AppColors.accent,
                            ),
                          ),
                          
                          const SizedBox(height: AppTheme.space3xl),
                          
                          // CTA Buttons with animation
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: AppAnimations.slow,
                            curve: Curves.easeOut,
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, 20 * (1 - value)),
                                  child: child,
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: AppColors.primaryGradient,
                                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary.withOpacity(0.3),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () => context.push('/signup'),
                                        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: AppTheme.spaceMd + AppTheme.spaceXs,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Inizia il tuo viaggio',
                                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                              color: AppColors.textOnColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: AppTheme.spaceMd),
                                TextButton(
                                  onPressed: () => context.push('/login'),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Hai già un account? '),
                                      Text(
                                        'Accedi',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureContent(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppTheme.spaceMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.3),
                color.withOpacity(0.15),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 28),
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
    );
  }
}
