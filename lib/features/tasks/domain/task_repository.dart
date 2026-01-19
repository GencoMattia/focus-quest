import 'package:focus_quest/core/database/app_database.dart';

abstract class TaskRepository {
  Stream<List<Task>> watchAllTasks();
  Future<List<Task>> getAllTasks();
  Future<Task?> getTaskById(String id);
  Future<void> createTask(TasksCompanion task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
  
  // Specific queries
  Stream<List<Task>> watchUrgentTasks();
  // ... existing methods
  Future<void> addEmotionalLog(EmotionalLogsCompanion log);
  Future<void> attachTaskImage(TaskImagesCompanion image);
  Stream<List<TaskImage>> watchTaskImages(String taskId);
  Future<List<String>> getDistinctTaskTitles();
  Future<Map<String, double>?> getTaskCompletionStats(String title);
}
