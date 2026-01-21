import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_quest/core/theme/app_theme.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/features/tasks/data/task_providers.dart';
import 'package:focus_quest/core/providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:focus_quest/core/database/app_database.dart';
import 'package:focus_quest/core/sync_service.dart';
import 'package:focus_quest/features/gamification/gamification_providers.dart';
import 'package:focus_quest/core/presentation/widgets/calm_card.dart';
import 'package:focus_quest/core/presentation/widgets/animated_calm_card.dart';
import 'package:focus_quest/core/presentation/widgets/decorative_shapes.dart';
import 'package:focus_quest/core/presentation/widgets/animated_progress.dart';
import 'package:focus_quest/core/presentation/widgets/animated_list_item.dart';
import 'package:focus_quest/core/theme/app_animations.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  Task? _suggestedTask;
  bool _isLoadingSuggestion = false;

  @override
  void initState() {
    super.initState();
    // Trigger Sync on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncData();
    });
  }

  Future<void> _syncData() async {
    try {
      final db = ref.read(databaseProvider);
      await SyncService(db, Supabase.instance.client).syncPendingChanges();
    } catch (e) {
      // Ignore sync errors on startup
    }
  }

  void _suggestTask(int minutes) async {
    setState(() => _isLoadingSuggestion = true);
    
    // Artificial delay for UX "thinking" feel
    await Future.delayed(const Duration(milliseconds: 600));
    
    final task = await ref.read(quickStartServiceProvider).suggestTask(minutes);
    
    if (mounted) {
      setState(() {
        _suggestedTask = task;
        _isLoadingSuggestion = false;
      });
      
      if (task != null) {
        _showSuggestionDialog(task);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.spa, color: AppColors.textOnColor),
                const SizedBox(width: AppTheme.spaceSm),
                const Expanded(
                  child: Text('Nessuna task urgente. Rilassati! 🌿'),
                ),
              ],
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _showSuggestionDialog(Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spaceSm),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: const Icon(Icons.lightbulb_outline, color: AppColors.primary),
            ),
            const SizedBox(width: AppTheme.spaceSm),
            const Expanded(child: Text('Ecco cosa puoi fare!')),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spaceSm),
            if (task.description != null) ...[
              Text(
                task.description!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppTheme.spaceMd),
            ],
            Wrap(
              spacing: AppTheme.spaceSm,
              children: [
                Chip(
                  avatar: const Icon(Icons.timer_outlined, size: 16),
                  label: Text('${task.estimatedDuration} min'),
                ),
                if (task.urgency == 'high')
                  Chip(
                    backgroundColor: AppColors.errorLight,
                    label: const Text('Urgente'),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Magari dopo'),
          ),
          FilledButton.icon(
            onPressed: () {
              context.pop();
              context.push('/execute-task/${task.id}');
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Inizia Ora'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Decorative background
          const DecorativeShapes(animated: true),
          
          // Main content
          CustomScrollView(
            slivers: [
              // Modern app bar with gradient
              SliverAppBar(
                expandedHeight: 140,
                floating: false,
                pinned: true,
                backgroundColor: AppColors.surface,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryLight.withOpacity(0.3),
                        AppColors.surface,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: FlexibleSpaceBar(
                    title: ShaderMask(
                      shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                      child: Text(
                        'Focus Quest',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    titlePadding: const EdgeInsets.only(
                      left: AppTheme.spaceMd,
                      bottom: AppTheme.spaceMd,
                    ),
                    expandedTitleScale: 1.5,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                    tooltip: 'Notifiche',
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    onPressed: () {},
                    tooltip: 'Impostazioni',
                  ),
                ],
              ),
              
              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spaceMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Greeting section with animation
                      FadeIn(
                        duration: AppAnimations.normal,
                        child: _buildGreetingSection(context),
                      ),
                      const SizedBox(height: AppTheme.spaceLg),
                      
                      // Quick Start Card - Most prominent with animation
                      AnimatedCalmCard(
                        delay: AppAnimations.staggerDelay,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryLight.withOpacity(0.4),
                            AppColors.surface,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 2,
                        ),
                        child: _buildQuickStartContent(context),
                      ),
                      const SizedBox(height: AppTheme.spaceMd),
                      
                      // Priority Task Card (if available)
                      AnimatedCalmCard(
                        delay: AppAnimations.staggerDelay * 2,
                        child: _buildPriorityTaskCard(context),
                      ),
                      const SizedBox(height: AppTheme.spaceMd),
                      
                      // Gamification Stats with staggered animation
                      FadeIn(
                        delay: AppAnimations.staggerDelay * 3,
                        child: _buildGamificationSection(context),
                      ),
                      const SizedBox(height: AppTheme.spaceMd),
                      
                      // Quick Actions with animation
                      FadeIn(
                        delay: AppAnimations.staggerDelay * 4,
                        child: _buildQuickActions(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStartContent(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppTheme.spaceMd),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(Icons.bolt, size: 36, color: AppColors.surface),
        ),
        const SizedBox(height: AppTheme.spaceMd),
        Text(
          'Quick Start',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spaceXs),
        Text(
          'Quanto tempo hai adesso?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppTheme.spaceLg),
        if (_isLoadingSuggestion)
          Column(
            children: [
              const PulsingDots(size: 12),
              const SizedBox(height: AppTheme.spaceSm),
              Text(
                'Sto pensando...',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          )
        else
          Wrap(
            spacing: AppTheme.spaceSm,
            runSpacing: AppTheme.spaceSm,
            alignment: WrapAlignment.center,
            children: [
              _buildTimeButton(context, 15),
              _buildTimeButton(context, 30),
              _buildTimeButton(context, 60),
              _buildTimeButton(context, 90),
            ],
          ),
      ],
    );
  }

  Widget _buildTimeButton(BuildContext context, int minutes) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _suggestTask(minutes),
        child: AnimatedContainer(
          duration: AppAnimations.fast,
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spaceLg,
            vertical: AppTheme.spaceMd,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primaryDark,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.timer_outlined,
                color: AppColors.textOnColor,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spaceXs),
              Text(
                '$minutes min',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.textOnColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingSection(BuildContext context) {
    final hour = DateTime.now().hour;
    String greeting;
    IconData greetingIcon;
    
    if (hour < 12) {
      greeting = 'Buongiorno';
      greetingIcon = Icons.wb_sunny_outlined;
    } else if (hour < 18) {
      greeting = 'Buon pomeriggio';
      greetingIcon = Icons.wb_twilight_outlined;
    } else {
      greeting = 'Buonasera';
      greetingIcon = Icons.nights_stay_outlined;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(greetingIcon, color: AppColors.primary, size: 28),
            const SizedBox(width: AppTheme.spaceSm),
            Text(
              greeting,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spaceXs),
        Text(
          'Cosa vuoi fare oggi?',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStartCard(BuildContext context) {
    return CalmCard(
      color: AppColors.primaryLight.withOpacity(0.3),
      border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spaceSm),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.bolt, size: 32, color: AppColors.primary),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Text(
            'Quick Start',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spaceXs),
          Text(
            'Quanto tempo hai adesso?',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spaceLg),
          if (_isLoadingSuggestion)
            Column(
              children: [
                const SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
                const SizedBox(height: AppTheme.spaceSm),
                Text(
                  'Sto pensando...',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            )
          else
            Wrap(
              alignment: WrapAlignment.center,
              spacing: AppTheme.spaceSm,
              runSpacing: AppTheme.spaceSm,
              children: [
                _TimeOptionButton(
                  label: '15 min',
                  minutes: 15,
                  icon: Icons.timer_outlined,
                  onTap: () => _suggestTask(15),
                ),
                _TimeOptionButton(
                  label: '30 min',
                  minutes: 30,
                  icon: Icons.schedule_outlined,
                  onTap: () => _suggestTask(30),
                  isPrimary: true,
                ),
                _TimeOptionButton(
                  label: '1 ora+',
                  minutes: 60,
                  icon: Icons.access_time,
                  onTap: () => _suggestTask(60),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildPriorityTaskCard(BuildContext context) {
    final urgentTasksAsync = ref.watch(taskRepositoryProvider).watchUrgentTasks();

    return StreamBuilder<List<Task>>(
      stream: urgentTasksAsync,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }
        
        final task = snapshot.data!.first;
        
        return CalmCard(
          color: AppColors.errorLight.withOpacity(0.1),
          border: Border.all(color: AppColors.error.withOpacity(0.3), width: 2),
          onTap: () => context.push('/execute-task/${task.id}'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spaceXs),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                    ),
                    child: const Icon(
                      Icons.priority_high,
                      color: AppColors.textOnColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spaceSm),
                  Text(
                    'Priorità Alta',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spaceMd),
              Text(
                task.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (task.description != null) ...[
                const SizedBox(height: AppTheme.spaceXs),
                Text(
                  task.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              const SizedBox(height: AppTheme.spaceMd),
              Wrap(
                spacing: AppTheme.spaceSm,
                children: [
                  Chip(
                    avatar: const Icon(Icons.timer_outlined, size: 14),
                    label: Text('${task.estimatedDuration} min'),
                    visualDensity: VisualDensity.compact,
                  ),
                  if (task.deadline != null)
                    Chip(
                      avatar: const Icon(Icons.event_outlined, size: 14),
                      label: Text(_formatDate(task.deadline!)),
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGamificationSection(BuildContext context) {
    final streakAsync = ref.watch(currentStreakProvider);
    final badgesAsync = ref.watch(earnedBadgesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'I tuoi progressi',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Row(
          children: [
            Expanded(
              child: CalmCard(
                padding: const EdgeInsets.all(AppTheme.spaceMd),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spaceSm),
                      decoration: BoxDecoration(
                        color: AppColors.warningLight.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Text('🔥', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(height: AppTheme.spaceSm),
                    Text(
                      'Streak',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: AppTheme.spaceXs),
                    streakAsync.when(
                      data: (val) => Text(
                        '$val',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      loading: () => const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      error: (_, __) => const Text('-'),
                    ),
                    Text(
                      'giorni',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spaceSm),
            Expanded(
              child: CalmCard(
                padding: const EdgeInsets.all(AppTheme.spaceMd),
                onTap: () {
                  badgesAsync.whenData((badges) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Row(
                          children: [
                            const Icon(Icons.emoji_events, color: AppColors.warning),
                            const SizedBox(width: AppTheme.spaceSm),
                            const Text('I tuoi Traguardi'),
                          ],
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: badges.isEmpty
                              ? [
                                  const Icon(
                                    Icons.stars_outlined,
                                    size: 48,
                                    color: AppColors.textTertiary,
                                  ),
                                  const SizedBox(height: AppTheme.spaceSm),
                                  const Text(
                                    'Completa delle task per ottenere badge!',
                                    textAlign: TextAlign.center,
                                  ),
                                ]
                              : badges
                                  .map((b) => ListTile(
                                        leading: const Icon(
                                          Icons.star,
                                          color: AppColors.warning,
                                        ),
                                        title: Text(b),
                                      ))
                                  .toList(),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => context.pop(),
                            child: const Text('Chiudi'),
                          ),
                        ],
                      ),
                    );
                  });
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spaceSm),
                      decoration: BoxDecoration(
                        color: AppColors.warningLight.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Text('🏆', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(height: AppTheme.spaceSm),
                    Text(
                      'Badge',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: AppTheme.spaceXs),
                    badgesAsync.when(
                      data: (val) => Text(
                        '${val.length}',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      loading: () => const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      error: (_, __) => const Text('-'),
                    ),
                    Text(
                      'ottenuti',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Azioni rapide',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        CalmCard(
          onTap: () => context.push('/create-task'),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spaceSm),
                decoration: BoxDecoration(
                  color: AppColors.secondaryLight,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: const Icon(
                  Icons.add_task,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nuova Attività',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Aggiungi un nuovo compito',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        CalmCard(
          onTap: () => context.push('/journal'),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spaceSm),
                decoration: BoxDecoration(
                  color: AppColors.accentLight,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: const Icon(
                  Icons.book_outlined,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vedi tutte le attività',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Controlla il tuo diario',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now).inDays;
    
    if (diff == 0) return 'Oggi';
    if (diff == 1) return 'Domani';
    if (diff < 7) return 'In $diff giorni';
    
    return '${date.day}/${date.month}';
  }
}

class _TimeOptionButton extends StatelessWidget {
  final String label;
  final int minutes;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _TimeOptionButton({
    required this.label,
    required this.minutes,
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isPrimary ? AppColors.primary : AppColors.surface,
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spaceMd,
            vertical: AppTheme.spaceSm,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            border: Border.all(
              color: isPrimary ? AppColors.primary : AppColors.divider,
              width: isPrimary ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isPrimary ? AppColors.textOnColor : AppColors.textPrimary,
              ),
              const SizedBox(width: AppTheme.spaceXs),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isPrimary ? AppColors.textOnColor : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Quest'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {}, 
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildQuickStartCard(context),
            const SizedBox(height: 16),
            _buildFocusCard(ref, context), // New Focus Card
            const SizedBox(height: 16),
            _buildCreateTaskButton(context), // New Create Button
            const SizedBox(height: 16),
            _buildGamificationRow(ref, context),
          ],
        ),
      ),
    );
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case 'high': return Colors.redAccent;
      case 'medium': return Colors.orangeAccent;
      case 'low': return Colors.greenAccent;
      default: return Colors.grey;
    }
  }

  Widget _buildGamificationRow(WidgetRef ref, BuildContext context) {
    final streakAsync = ref.watch(currentStreakProvider);
    final badgesAsync = ref.watch(earnedBadgesProvider);

    return Row(
      children: [
        Expanded(
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                   const Text('🔥 Streak', style: TextStyle(fontWeight: FontWeight.bold)),
                   const SizedBox(height: 8),
                   streakAsync.when(
                     data: (val) => Text('$val giorni', style: const TextStyle(fontSize: 18, color: AppColors.calmBlue)),
                     loading: () => const SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
                     error: (_,__) => const Text('-'),
                   ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () {
               // Show badges dialog
               badgesAsync.whenData((badges) {
                 showDialog(
                   context: context, 
                   builder: (_) => AlertDialog(
                     title: const Text('I tuoi Traguardi 🏆'),
                     content: Column(
                       mainAxisSize: MainAxisSize.min,
                       children: badges.isEmpty 
                         ? [const Text('Completa delle task per ottenere badge!')] 
                         : badges.map((b) => ListTile(title: Text(b), leading: const Icon(Icons.star, color: Colors.amber))).toList(),
                     ),
                     actions: [TextButton(onPressed: () => context.pop(), child: const Text('Chiudi'))],
                   )
                 );
               });
            },
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                     const Text('🏆 Badge', style: TextStyle(fontWeight: FontWeight.bold)),
                     const SizedBox(height: 8),
                     badgesAsync.when(
                       data: (val) => Text('${val.length} ottenuti', style: const TextStyle(fontSize: 18, color: AppColors.calmBlue)),
                       loading: () => const SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
                       error: (_,__) => const Text('-'),
                     ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFocusCard(WidgetRef ref, BuildContext context) {
    final urgentTasksAsync = ref.watch(taskRepositoryProvider).watchUrgentTasks();

    return StreamBuilder<List<Task>>(
      stream: urgentTasksAsync,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) return const SizedBox.shrink();
        
        // Take the first one
        final task = snapshot.data!.first;
        
        return Card(
          color: AppColors.calmBlue.withOpacity(0.1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.calmBlue, width: 2)
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.priority_high, color: AppColors.calmBlue),
                    const SizedBox(width: 8),
                    Text('Priorità Alta', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.calmBlue, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  task.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                if (task.description != null) ...[
                  const SizedBox(height: 8),
                  Text(task.description!, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.calmBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => context.push('/execute-task/${task.id}'),
                    child: const Text('Focus Ora 🧘'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCreateTaskButton(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => context.push('/create-task'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(color: AppColors.sageGreen, shape: BoxShape.circle),
                child: const Icon(Icons.add, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Text(
                'Aggiungi Nuova Attività',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStartCard(BuildContext context) {
    return Card(
      color: AppColors.sageGreen.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.bolt, size: 48, color: AppColors.sageGreen),
            const SizedBox(height: 16),
            Text(
              'Quanto tempo hai adesso?',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 24),
            if (_isLoadingSuggestion)
              const CircularProgressIndicator()
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   // ... options
                  _TimeOptionButton(label: '15 min', minutes: 15, onTap: () => _suggestTask(15)),
                  _TimeOptionButton(label: '30 min', minutes: 30, onTap: () => _suggestTask(30)),
                  _TimeOptionButton(label: '1 h+', minutes: 60, onTap: () => _suggestTask(60)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _TimeOptionButton extends StatelessWidget {
  final String label;
  final int minutes;
  final VoidCallback onTap;

  const _TimeOptionButton({
    required this.label,
    required this.minutes,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.sageGreen),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(label),
    );
  }
}
