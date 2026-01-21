import 'package:drift/drift.dart';
import 'package:focus_quest/core/database/app_database.dart';
import 'package:focus_quest/features/tasks/domain/task_repository.dart';

class LocalTaskRepository implements TaskRepository {
  final AppDatabase _db;

  LocalTaskRepository(this._db);

  @override
  Stream<List<Task>> watchAllTasks() {
    return _db.select(_db.tasks).watch();
  }

  @override
  Future<List<Task>> getAllTasks() {
    return _db.select(_db.tasks).get();
  }

  @override
  Future<Task?> getTaskById(String id) {
    return (_db.select(_db.tasks)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<void> createTask(TasksCompanion task) {
    return _db.into(_db.tasks).insert(task);
  }

  @override
  Future<void> updateTask(Task task) {
    return _db.update(_db.tasks).replace(task);
  }

  @override
  Future<void> deleteTask(String id) {
    return (_db.delete(_db.tasks)..where((t) => t.id.equals(id))).go();
  }

  @override
  Stream<List<Task>> watchUrgentTasks() {
    // Get all incomplete tasks and sort them by urgency and deadline
    return (_db.select(_db.tasks)
          ..where((t) => t.status.equals('todo') | t.status.equals('in_progress'))
          ..orderBy([
            // First, prioritize by urgency (high > medium > low)
            (t) => OrderingTerm(
              expression: t.urgency,
              mode: OrderingMode.desc,
            ),
            // Then by deadline (closest first, nulls last)
            (t) => OrderingTerm(
              expression: t.deadline,
              mode: OrderingMode.asc,
            ),
          ]))
        .watch()
        .map((tasks) {
          // Filter to show only high urgency OR tasks with deadline within 7 days
          final now = DateTime.now();
          final sevenDaysFromNow = now.add(const Duration(days: 7));
          
          return tasks.where((task) {
            final isHighUrgency = task.urgency == 'high';
            final hasUrgentDeadline = task.deadline != null && 
                task.deadline!.isBefore(sevenDaysFromNow);
            
            return isHighUrgency || hasUrgentDeadline;
          }).toList();
        });
  }

  @override
  Future<void> addEmotionalLog(EmotionalLogsCompanion log) {
    return _db.into(_db.emotionalLogs).insert(log);
  }

  @override
  Future<void> attachTaskImage(TaskImagesCompanion image) {
    return _db.into(_db.taskImages).insert(image);
  }

  @override
  Stream<List<TaskImage>> watchTaskImages(String taskId) {
    return (_db.select(_db.taskImages)..where((t) => t.taskId.equals(taskId))).watch();
  }

  @override
  Future<List<String>> getDistinctTaskTitles() async {
    final query = _db.selectOnly(_db.tasks, distinct: true)..addColumns([_db.tasks.title]);
    final results = await query.map((row) => row.read(_db.tasks.title)).get();
    return results.whereType<String>().toList();
  }

  @override
  @override
  Future<Map<String, double>?> getTaskCompletionStats(String title) async {
    // 1. Get completed tasks with this title
    final completedTasks = await (_db.select(_db.tasks)
      ..where((t) => t.title.equals(title) & t.status.equals('completed'))
    ).get();

    if (completedTasks.isEmpty) return null;

    int totalEstimated = 0;
    int totalActualSeconds = 0;
    int count = 0;

    for (final task in completedTasks) {
      totalEstimated += task.estimatedDuration ?? 0;
      
      // Calculate actual time from sessions
      final sessions = await (_db.select(_db.taskSessions)
        ..where((s) => s.taskId.equals(task.id))
      ).get();

      final taskSeconds = sessions.fold<int>(0, (sum, s) => sum + (s.durationSeconds ?? 0));
      totalActualSeconds += taskSeconds;
      count++;
    }

    if (count == 0) return null;

    final avgEst = totalEstimated / count;
    final avgActMinutes = (totalActualSeconds / 60) / count;

    return {
      'avgEstimated': avgEst,
      'avgActual': avgActMinutes,
    };
  }
}
