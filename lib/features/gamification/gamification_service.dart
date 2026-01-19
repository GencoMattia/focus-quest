import 'package:drift/drift.dart';
import 'package:focus_quest/core/database/app_database.dart';
import 'package:focus_quest/features/tasks/domain/task_repository.dart';

class GamificationService {
  final TaskRepository _repository;

  GamificationService(this._repository);

  // Calculate Streak: consecutive days with at least one completed task
  // Calculate Streak from provided list
  int calculateStreak(List<Task> tasks) {
    final completed = tasks
        .where((t) => t.status == 'completed')
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt)); // Descending

    if (completed.isEmpty) return 0;

    int streak = 0;
    DateTime? lastDate;

    for (final task in completed) {
      final date = DateTime(task.updatedAt.year, task.updatedAt.month, task.updatedAt.day);
      
      if (lastDate == null) {
        // Must be today or yesterday to count active streak
        final today = DateTime.now();
        final yesterday = today.subtract(const Duration(days: 1));
        final resetDate = DateTime(today.year, today.month, today.day);
        final yesterdayDate = DateTime(yesterday.year, yesterday.month, yesterday.day);

        if (date == resetDate || date == yesterdayDate) {
          streak = 1;
          lastDate = date;
        } else {
          // If the last task was before yesterday, streak is broken (0), 
          // unless we want to show "highest streak" or similar. 
          // But "Current Streak" is 0.
          return 0; 
        }
      } else {
        final diff = lastDate.difference(date).inDays;
        if (diff == 1) {
          streak++;
          lastDate = date;
        } else if (diff > 1) {
          break; // Gap found
        }
      }
    }
    return streak;
  }

  // Old method kept for backward compatibility if needed, but redirects to new logic
  Future<int> getCurrentStreak() async {
    final tasks = await _repository.getAllTasks();
    return calculateStreak(tasks);
  }

  List<String> calculateBadges(List<Task> tasks) {
    final completedCount = tasks.where((t) => t.status == 'completed').length;
    final badges = <String>[];

    if (completedCount >= 1) badges.add('Primo Passo 🌱');
    if (completedCount >= 5) badges.add('Costanza 🌊');
    if (completedCount >= 10) badges.add('Focus Master 🧘');
    
    // Check for "early bird" (completed before 9 AM)
    final hasEarlyBird = tasks.any((t) => t.status == 'completed' && t.updatedAt.hour < 9);
    if (hasEarlyBird) badges.add('Mattiniero ☀️');

    return badges;
  }

  Future<List<String>> getBadges() async {
    final tasks = await _repository.getAllTasks();
    return calculateBadges(tasks);
  }
}
