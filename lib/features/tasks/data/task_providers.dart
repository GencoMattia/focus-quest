import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_quest/core/providers.dart';
import 'package:focus_quest/core/database/app_database.dart';
import 'package:focus_quest/features/tasks/data/local_task_repository.dart';
import 'package:focus_quest/features/tasks/domain/quick_start_service.dart';
import 'package:focus_quest/features/tasks/domain/task_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_providers.g.dart';

@Riverpod(keepAlive: true)
TaskRepository taskRepository(TaskRepositoryRef ref) {
  final db = ref.watch(databaseProvider);
  return LocalTaskRepository(db);
}

@riverpod
QuickStartService quickStartService(QuickStartServiceRef ref) {
  final repo = ref.watch(taskRepositoryProvider);
  return QuickStartService(repo);
}

@riverpod
Stream<List<Task>> taskList(TaskListRef ref) {
  final repo = ref.watch(taskRepositoryProvider);
  return repo.watchAllTasks();
}
