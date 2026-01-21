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
    // Only sync if supabase is initialized (checked implicitly inside service or could be checked here)
    // For now we just run it. Ideally this would be a provider too.
    try {
       // Quick and dirty manual instantiation for MVP, 
       // in real world use a provider for SyncService
       final db = ref.read(databaseProvider);
       await SyncService(db, Supabase.instance.client).syncPendingChanges();
    } catch (e) {
      // Ignore sync errors on startup
    }
  }

  void _suggestTask(int minutes) async {
    setState(() => _isLoadingSuggestion = true);
    
    // Artificial delay for UX "thinking" feel
    await Future.delayed(const Duration(milliseconds: 800));
    
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
          const SnackBar(content: Text('Nessuna task urgente per questo lasso di tempo. Rilassati! 🌿')),
        );
      }
    }
  }

  void _showSuggestionDialog(Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ecco cosa puoi fare!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            if (task.description != null) Text(task.description!),
            const SizedBox(height: 16),
            Chip(label: Text('${task.estimatedDuration} min')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Magari dopo')),
          ElevatedButton(
            onPressed: () {
              context.pop();
              context.push('/execute-task/${task.id}');
            },
            child: const Text('Inizia Ora 🚀'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Quest'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            onPressed: () {}, 
            tooltip: 'Cronologia',
          ),
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () {},
            tooltip: 'Impostazioni',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFocusCard(ref, context),
              const SizedBox(height: 20),
              _buildQuickStartCard(context),
              const SizedBox(height: 20),
              _buildCreateTaskButton(context),
              const SizedBox(height: 20),
              _buildGamificationRow(ref, context),
            ],
          ),
        ),
      ),
    );
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case 'high': return AppColors.urgencyHigh;
      case 'medium': return AppColors.urgencyMedium;
      case 'low': return AppColors.urgencyLow;
      default: return AppColors.textMedium;
    }
  }

  LinearGradient _getUrgencyGradient(String urgency) {
    switch (urgency) {
      case 'high': 
        return const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'medium': 
        return const LinearGradient(
          colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'low': 
        return AppColors.successGradient;
      default: 
        return AppColors.primaryGradient;
    }
  }

  Widget _buildGamificationRow(WidgetRef ref, BuildContext context) {
    final streakAsync = ref.watch(currentStreakProvider);
    final badgesAsync = ref.watch(earnedBadgesProvider);

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6B6B), Color(0xFFEE5A6F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF6B6B).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Icon(Icons.local_fire_department_rounded, 
                        color: Colors.white, size: 32),
                      const SizedBox(height: 12),
                      const Text('Streak', 
                        style: TextStyle(
                          color: Colors.white, 
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        )),
                      const SizedBox(height: 4),
                      streakAsync.when(
                        data: (val) => Text(
                          '$val giorni', 
                          style: const TextStyle(
                            fontSize: 24, 
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        loading: () => const SizedBox(
                          height: 24, 
                          width: 24, 
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                        error: (_,__) => const Text('-', 
                          style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.purpleGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.energeticPurple.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  badgesAsync.whenData((badges) {
                    showDialog(
                      context: context, 
                      builder: (_) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: const Text('I tuoi Traguardi 🏆'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: badges.isEmpty 
                            ? [const Text('Completa delle task per ottenere badge!')] 
                            : badges.map((b) => ListTile(
                                title: Text(b), 
                                leading: const Icon(Icons.star_rounded, color: Colors.amber),
                              )).toList(),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => context.pop(), 
                            child: const Text('Chiudi'),
                          ),
                        ],
                      )
                    );
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Icon(Icons.emoji_events_rounded, 
                        color: Colors.white, size: 32),
                      const SizedBox(height: 12),
                      const Text('Badge', 
                        style: TextStyle(
                          color: Colors.white, 
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        )),
                      const SizedBox(height: 4),
                      badgesAsync.when(
                        data: (val) => Text(
                          '${val.length}', 
                          style: const TextStyle(
                            fontSize: 24, 
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        loading: () => const SizedBox(
                          height: 24, 
                          width: 24, 
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                        error: (_,__) => const Text('-', 
                          style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
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
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Show empty state
          return Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE0E7FF), Color(0xFFF3F4F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Icon(Icons.check_circle_outline_rounded, 
                  size: 64, 
                  color: AppColors.vibrantGreen.withOpacity(0.6)),
                const SizedBox(height: 16),
                Text(
                  'Tutto sotto controllo! 🎉',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Nessuna task urgente al momento',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textMedium,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        
        // Take the first one (most urgent)
        final task = snapshot.data!.first;
        final urgencyGradient = _getUrgencyGradient(task.urgency);
        final urgencyColor = _getUrgencyColor(task.urgency);
        
        return Container(
          decoration: BoxDecoration(
            gradient: urgencyGradient,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: urgencyColor.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => context.push('/execute-task/${task.id}'),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.flash_on_rounded, 
                            color: Colors.white, 
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TASK URGENTE',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              if (task.deadline != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  'Scadenza: ${task.deadline!.day}/${task.deadline!.month}/${task.deadline!.year}',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            task.urgency.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    if (task.description != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        task.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 15,
                          height: 1.4,
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        if (task.estimatedDuration != null) ...[
                          Icon(Icons.timer_outlined, 
                            color: Colors.white.withOpacity(0.9), 
                            size: 18),
                          const SizedBox(width: 6),
                          Text(
                            '${task.estimatedDuration} min',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                        ],
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Inizia Ora',
                                style: TextStyle(
                                  color: urgencyColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(Icons.arrow_forward_rounded, 
                                color: urgencyColor, 
                                size: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCreateTaskButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.successGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.vibrantGreen.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push('/create-task'),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Aggiungi Nuova Attività',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStartCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.bolt_rounded, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Quanto tempo hai adesso?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            if (_isLoadingSuggestion)
              const CircularProgressIndicator(color: Colors.white)
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF667EEA),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
