import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_quest/features/tasks/data/task_providers.dart';
import 'package:focus_quest/features/gamification/gamification_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gamification_providers.g.dart';

@riverpod
GamificationService gamificationService(GamificationServiceRef ref) {
  final repo = ref.watch(taskRepositoryProvider);
  return GamificationService(repo);
}

@riverpod
Stream<int> currentStreak(CurrentStreakRef ref) {
  // Watch the stream of tasks to allow real-time updates
  return ref.watch(taskRepositoryProvider).watchAllTasks().map((tasks) {
    return ref.read(gamificationServiceProvider).calculateStreak(tasks);
  });
}

@riverpod
Stream<List<String>> earnedBadges(EarnedBadgesRef ref) {
  return ref.watch(taskRepositoryProvider).watchAllTasks().map((tasks) {
    return ref.read(gamificationServiceProvider).calculateBadges(tasks);
  });
}
