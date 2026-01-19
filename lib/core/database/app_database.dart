import 'package:drift/drift.dart';
import 'package:focus_quest/core/database/tables.dart';

// Import for connection opening (we will implement this separately)
import 'connection/connection.dart' as impl;

part 'app_database.g.dart';

@DriftDatabase(tables: [Tasks, TaskSessions, EmotionalLogs, TaskImages])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  @override
  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // We added EmotionalLogs and TaskImages in version 2
          await m.createTable(emotionalLogs);
          await m.createTable(taskImages);
        }
        if (from < 3) {
          // Version 3 fix: emotional_logs might have been created without 'intensity' due to state mismatch.
          // Force drop and recreate to ensure schema is correct.
          // Note: This wipes data in these tables, but it's acceptable for this dev phase of a new feature.
          await m.deleteTable(emotionalLogs.actualTableName);
          await m.createTable(emotionalLogs);
          
          await m.deleteTable(taskImages.actualTableName); 
          await m.createTable(taskImages);
        }
      },
    );
  }
}
