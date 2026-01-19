import 'package:focus_quest/core/database/app_database.dart';
import 'package:focus_quest/features/tasks/domain/task_repository.dart';

class QuickStartService {
  final TaskRepository _repository;

  QuickStartService(this._repository);

  /// Selects the best task based on available time (in minutes).
  /// Algorithm:
  /// 1. Filter by status 'todo'
  /// 2. Filter tasks where estimated_duration <= availableTime
  /// 3. Sort by Urgency (High > Medium > Low)
  /// 4. Sort by Deadline (Ascending)
  /// 5. Return the top one.
  Future<Task?> suggestTask(int availableMinutes) async {
    final allTasks = await _repository.getAllTasks();
    
    final candidates = allTasks.where((t) {
      if (t.status != 'todo') return false;
      final est = t.estimatedDuration ?? 0;
      return est > 0 && est <= availableMinutes;
    }).toList();

    if (candidates.isEmpty) return null;

    candidates.sort((a, b) {
      // 1. Urgency
      final urgencyScoreA = _urgencyScore(a.urgency);
      final urgencyScoreB = _urgencyScore(b.urgency);
      if (urgencyScoreA != urgencyScoreB) {
        return urgencyScoreB.compareTo(urgencyScoreA); // Descending
      }
      
      // 2. Deadline
      if (a.deadline != null && b.deadline != null) {
        return a.deadline!.compareTo(b.deadline!);
      } else if (a.deadline != null) {
        return -1; // a comes first
      } else if (b.deadline != null) {
        return 1;
      }

      return 0;
    });

    return candidates.first;
  }

  int _urgencyScore(String urgency) {
    switch (urgency) {
      case 'high': return 3;
      case 'medium': return 2;
      case 'low': return 1;
      default: return 0;
    }
  }
}
