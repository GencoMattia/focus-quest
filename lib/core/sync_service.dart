import 'package:drift/drift.dart';
import 'package:focus_quest/core/database/app_database.dart';
import 'package:focus_quest/core/database/tables.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class SyncService {
  final AppDatabase _db;
  final supabase.SupabaseClient _supabase;

  SyncService(this._db, this._supabase);

  Future<void> syncPendingChanges() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    // 1. Push Local Changes (Tasks)
    final dirtyTasks = await (_db.select(_db.tasks)..where((t) => t.isDirty.equals(true))).get();
    
    for (final task in dirtyTasks) {
      try {
        await _supabase.from('tasks').upsert({
          'id': task.id,
          'user_id': userId,
          'title': task.title,
          'description': task.description,
          'estimated_duration': task.estimatedDuration,
          'urgency': task.urgency,
          'status': task.status,
          'created_at': task.createdAt.toIso8601String(),
          'updated_at': task.updatedAt.toIso8601String(),
        });
        
        // Mark as synced localy
        await _db.update(_db.tasks).replace(task.copyWith(isDirty: false, lastSyncedAt: Value(DateTime.now())));
      } catch (e) {
        // Handle error (e.g. retry later) or conflict
        print('Sync error for task ${task.id}: $e');
      }
    }

    // 2. Pull Remote Changes
    // This is a simplified pull strategy (last_write wins)
    try {
      final response = await _supabase.from('tasks').select().eq('user_id', userId);
      final remoteTasks = response as List<dynamic>;

      for (final remote in remoteTasks) {
        // Upsert to local DB
        // In a real app we would check timestamps to decide whether to overwrite
        await _db.into(_db.tasks).insertOnConflictUpdate(TasksCompanion(
          id: Value(remote['id']),
          userId: Value(remote['user_id']),
          title: Value(remote['title']),
          description: Value(remote['description']),
          estimatedDuration: Value(remote['estimated_duration']),
          urgency: Value(remote['urgency']),
          status: Value(remote['status']),
          createdAt: Value(DateTime.parse(remote['created_at'])),
          updatedAt: Value(DateTime.parse(remote['updated_at'])),
          isDirty: const Value(false),
          lastSyncedAt: Value(DateTime.now()),
        ));
      }
    } catch (e) {
      print('Pull error: $e');
    }
  }
}
