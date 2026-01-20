import 'package:drift/drift.dart';
import 'package:focus_quest/core/database/app_database.dart';
import 'package:focus_quest/core/database/tables.dart';
import 'package:focus_quest/core/utils/logger.dart';
import 'package:focus_quest/core/utils/exceptions.dart';
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
        
        // Mark as synced locally
        await _db.update(_db.tasks).replace(task.copyWith(isDirty: false, lastSyncedAt: Value(DateTime.now())));
      } catch (e, stackTrace) {
        // Handle error (e.g. retry later) or conflict
        if (e is supabase.AuthException) {
          AppLogger.error('Auth error during sync for task ${task.id}', e, stackTrace, 'SyncService');
          throw AuthException('Failed to sync task: ${e.message}', originalError: e);
        } else if (e is supabase.PostgrestException) {
          AppLogger.error('Database error during sync for task ${task.id}', e, stackTrace, 'SyncService');
          throw SyncException('Failed to sync task: ${e.message}', originalError: e);
        } else {
          AppLogger.error('Sync error for task ${task.id}', e, stackTrace, 'SyncService');
          throw SyncException('Failed to sync task', originalError: e);
        }
      }
    }

    // 2. Pull Remote Changes
    // This is a simplified pull strategy (last_write wins)
    try {
      final response = await _supabase.from('tasks').select().eq('user_id', userId);
      
      // Safe type casting with validation
      if (response is! List) {
        AppLogger.warning('Unexpected response type from Supabase', 'SyncService');
        return;
      }
      
      final remoteTasks = response as List<dynamic>;

      for (final remote in remoteTasks) {
        if (remote is! Map<String, dynamic>) continue;
        
        // TODO: Implement proper conflict resolution by comparing timestamps
        // For now, remote changes overwrite local changes
        final remoteUpdatedAt = remote['updated_at'] != null 
            ? DateTime.parse(remote['updated_at'] as String)
            : DateTime.now();
            
        await _db.into(_db.tasks).insertOnConflictUpdate(TasksCompanion(
          id: Value(remote['id'] as String),
          userId: Value(remote['user_id'] as String),
          title: Value(remote['title'] as String),
          description: Value(remote['description'] as String?),
          estimatedDuration: Value(remote['estimated_duration'] as int?),
          urgency: Value(remote['urgency'] as String),
          status: Value(remote['status'] as String),
          createdAt: Value(DateTime.parse(remote['created_at'] as String)),
          updatedAt: Value(remoteUpdatedAt),
          isDirty: const Value(false),
          lastSyncedAt: Value(DateTime.now()),
        ));
      }
    } catch (e, stackTrace) {
      AppLogger.error('Pull error', e, stackTrace, 'SyncService');
      if (e is supabase.AuthException) {
        throw AuthException('Failed to pull remote data: ${e.message}', originalError: e);
      } else if (e is supabase.PostgrestException) {
        throw SyncException('Failed to pull remote data: ${e.message}', originalError: e);
      } else {
        throw SyncException('Failed to pull remote data', originalError: e);
      }
    }
  }
}
