import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/core/theme/app_theme.dart';
import 'package:focus_quest/features/tasks/data/task_providers.dart';
import 'package:focus_quest/core/database/app_database.dart';
import 'package:focus_quest/core/presentation/widgets/calm_card.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  String _selectedFilter = 'all'; // all, active, completed

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(taskListProvider);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Modern app bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.surface,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Il tuo Diario'),
              titlePadding: const EdgeInsets.only(
                left: AppTheme.spaceMd,
                bottom: AppTheme.spaceMd,
              ),
              expandedTitleScale: 1.5,
            ),
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.filter_list),
                tooltip: 'Filtra',
                onSelected: (value) {
                  setState(() {
                    _selectedFilter = value;
                  });
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'all',
                    child: Text('Tutte'),
                  ),
                  const PopupMenuItem(
                    value: 'active',
                    child: Text('Da fare'),
                  ),
                  const PopupMenuItem(
                    value: 'completed',
                    child: Text('Completate'),
                  ),
                ],
              ),
            ],
          ),
          
          // Content
          tasksAsync.when(
            data: (tasks) => _buildContent(context, tasks),
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: AppTheme.spaceMd),
                    Text(
                      'Errore nel caricamento',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppTheme.spaceSm),
                    Text(
                      err.toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        onPressed: () => context.push('/create-task'),
        icon: const Icon(Icons.add),
        label: const Text('Nuova'),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<Task> allTasks) {
    // Apply filter
    List<Task> tasks;
    switch (_selectedFilter) {
      case 'active':
        tasks = allTasks.where((t) => t.status != 'completed').toList();
        break;
      case 'completed':
        tasks = allTasks.where((t) => t.status == 'completed').toList();
        break;
      default:
        tasks = allTasks;
    }

    if (tasks.isEmpty) {
      return SliverFillRemaining(
        child: _buildEmptyState(context),
      );
    }

    // Group tasks by status
    final activeTasks = tasks.where((t) => t.status != 'completed').toList();
    final completedTasks = tasks.where((t) => t.status == 'completed').toList();

    // Sort active tasks by urgency and deadline
    activeTasks.sort((a, b) {
      // High urgency first
      final urgencyOrder = {'high': 0, 'medium': 1, 'low': 2};
      final urgencyCompare = (urgencyOrder[a.urgency] ?? 3)
          .compareTo(urgencyOrder[b.urgency] ?? 3);
      if (urgencyCompare != 0) return urgencyCompare;

      // Then by deadline
      if (a.deadline != null && b.deadline != null) {
        return a.deadline!.compareTo(b.deadline!);
      }
      if (a.deadline != null) return -1;
      if (b.deadline != null) return 1;

      // Finally by creation date
      return b.createdAt.compareTo(a.createdAt);
    });

    // Sort completed tasks by completion date (most recent first)
    completedTasks.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    return SliverPadding(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          if (activeTasks.isNotEmpty && _selectedFilter != 'completed') ...[
            _buildSectionHeader(
              context,
              'Da fare',
              activeTasks.length,
              Icons.radio_button_unchecked,
              AppColors.primary,
            ),
            const SizedBox(height: AppTheme.spaceSm),
            ...activeTasks.map((task) => _buildTaskItem(context, task, false)),
            const SizedBox(height: AppTheme.spaceLg),
          ],
          
          if (completedTasks.isNotEmpty && _selectedFilter != 'active') ...[
            _buildSectionHeader(
              context,
              'Completate',
              completedTasks.length,
              Icons.check_circle,
              AppColors.success,
            ),
            const SizedBox(height: AppTheme.spaceSm),
            ...completedTasks.map((task) => _buildTaskItem(context, task, true)),
          ],
        ]),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    String title;
    String subtitle;
    IconData icon;

    switch (_selectedFilter) {
      case 'active':
        title = 'Nessuna attività da fare';
        subtitle = 'Ottimo! Hai completato tutto';
        icon = Icons.celebration_outlined;
        break;
      case 'completed':
        title = 'Nessuna attività completata';
        subtitle = 'Le attività completate appariranno qui';
        icon = Icons.check_circle_outline;
        break;
      default:
        title = 'Il diario è vuoto';
        subtitle = 'Inizia creando la tua prima attività';
        icon = Icons.edit_note_outlined;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spaceXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spaceLg),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 64,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppTheme.spaceLg),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spaceSm),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (_selectedFilter == 'all') ...[
              const SizedBox(height: AppTheme.spaceXl),
              FilledButton.icon(
                onPressed: () => context.push('/create-task'),
                icon: const Icon(Icons.add),
                label: const Text('Crea Attività'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    int count,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: AppTheme.spaceSm),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: AppTheme.spaceXs),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spaceSm,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          ),
          child: Text(
            '$count',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(BuildContext context, Task task, bool isCompleted) {
    return CalmCard(
      color: isCompleted
          ? AppColors.surface.withOpacity(0.6)
          : AppColors.surface,
      margin: const EdgeInsets.only(bottom: AppTheme.spaceSm),
      onTap: isCompleted
          ? null // Don't navigate for completed tasks
          : () => context.push('/execute-task/${task.id}'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status indicator
          Container(
            padding: const EdgeInsets.all(AppTheme.spaceXs),
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.successLight.withOpacity(0.3)
                  : _getUrgencyColor(task.urgency).withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: Icon(
              isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isCompleted
                  ? AppColors.success
                  : _getUrgencyColor(task.urgency),
              size: 20,
            ),
          ),
          const SizedBox(width: AppTheme.spaceMd),
          
          // Task info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted
                        ? AppColors.textSecondary
                        : AppColors.textPrimary,
                  ),
                ),
                if (task.description != null && task.description!.isNotEmpty) ...[
                  const SizedBox(height: AppTheme.spaceXs),
                  Text(
                    task.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: AppTheme.spaceSm),
                
                // Metadata chips
                Wrap(
                  spacing: AppTheme.spaceXs,
                  runSpacing: AppTheme.spaceXs,
                  children: [
                    _buildMetaChip(
                      context,
                      Icons.timer_outlined,
                      '${task.estimatedDuration} min',
                      AppColors.textTertiary,
                    ),
                    if (task.deadline != null)
                      _buildMetaChip(
                        context,
                        Icons.event_outlined,
                        _formatDate(task.deadline!),
                        _getDeadlineColor(task.deadline!),
                      ),
                    if (task.urgency == 'high' && !isCompleted)
                      _buildMetaChip(
                        context,
                        Icons.priority_high,
                        'Urgente',
                        AppColors.error,
                      ),
                  ],
                ),
              ],
            ),
          ),
          
          // Action indicator
          if (!isCompleted)
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textTertiary,
            ),
        ],
      ),
    );
  }

  Widget _buildMetaChip(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spaceXs,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusXs),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 2),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case 'high':
        return AppColors.error;
      case 'medium':
        return AppColors.warning;
      case 'low':
        return AppColors.success;
      default:
        return AppColors.textTertiary;
    }
  }

  Color _getDeadlineColor(DateTime deadline) {
    final now = DateTime.now();
    final diff = deadline.difference(now).inDays;
    
    if (diff < 0) return AppColors.error;
    if (diff == 0) return AppColors.error;
    if (diff <= 2) return AppColors.warning;
    return AppColors.textTertiary;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now).inDays;
    
    if (diff < 0) return 'Scaduto';
    if (diff == 0) return 'Oggi';
    if (diff == 1) return 'Domani';
    if (diff < 7) return 'In $diff gg';
    
    return DateFormat('dd/MM').format(date);
  }
}
