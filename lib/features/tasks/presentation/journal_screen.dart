import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_quest/core/theme/app_colors.dart';
import 'package:focus_quest/features/tasks/data/task_providers.dart';
import 'package:focus_quest/core/database/app_database.dart';
import 'package:focus_quest/core/presentation/widgets/calm_card.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskListProvider);
    
    return Scaffold(
      backgroundColor: AppColors.warmGrey,
      appBar: AppBar(
        title: const Text('Il tuo Percorso 📖'),
        centerTitle: true,
      ),
      body: tasksAsync.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.edit_note, size: 64, color: AppColors.textLight),
                  const SizedBox(height: 16),
                  Text(
                    'Il diario è vuoto.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textLight),
                  ),
                ],
              ),
            );
          }

          final activeTasks = tasks.where((t) => t.status != 'completed').toList();
          final completedTasks = tasks.where((t) => t.status == 'completed').toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (activeTasks.isNotEmpty) ...[
                const Text('Da fare', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                const SizedBox(height: 8),
                ...activeTasks.map((task) => _buildTaskItem(context, task)),
                const SizedBox(height: 24),
              ],
              
              if (completedTasks.isNotEmpty) ...[
                const Text('Completate', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                const SizedBox(height: 8),
                ...completedTasks.map((task) => _buildTaskItem(context, task, isCompleted: true)),
              ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Errore: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: AppColors.calmBlue,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => context.push('/create-task'),
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, Task task, {bool isCompleted = false}) {
    return CalmCard(
      color: isCompleted ? Colors.white.withOpacity(0.6) : Colors.white,
      onTap: () {
         // If active, go to execute. If completed, maybe show details?
         // For now, let's allow re-visiting active tasks
         if (!isCompleted) {
           context.push('/execute-task/${task.id}');
         }
      },
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.circle_outlined,
            color: isCompleted ? AppColors.sageGreen : AppColors.calmBlue,
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted ? AppColors.textLight : AppColors.textDark,
                  ),
                ),
                if (task.deadline != null)
                  Text(
                    'Scadenza: ${DateFormat('dd MMM').format(task.deadline!)}',
                    style: const TextStyle(fontSize: 12, color: AppColors.textLight),
                  ),
              ],
            ),
          ),
          if (task.urgency == 'high' && !isCompleted)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('Urgente', style: TextStyle(color: AppColors.error, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}
