import 'package:drift/drift.dart';

class Tasks extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  IntColumn get estimatedDuration => integer().nullable()(); // in minutes
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get deadline => dateTime().nullable()();
  
  // 'low', 'medium', 'high'
  TextColumn get urgency => text().withDefault(const Constant('medium'))();
  
  // 'todo', 'in_progress', 'paused', 'completed'
  TextColumn get status => text().withDefault(const Constant('todo'))();
  
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  
  // For Sync
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  BoolColumn get isDirty => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class TaskSessions extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get taskId => text().references(Tasks, #id)();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  IntColumn get durationSeconds => integer().nullable()();

  // For Sync
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  BoolColumn get isDirty => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class EmotionalLogs extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get taskId => text().nullable().references(Tasks, #id)();
  TextColumn get userId => text()();
  TextColumn get mood => text().nullable()(); 
  IntColumn get intensity => integer().nullable()(); // 1-5 scale
  TextColumn get note => text().nullable()();
  TextColumn get context => text().nullable()(); // 'pre_task', 'post_task'
  DateTimeColumn get createdAt => dateTime()();

  // For Sync
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  BoolColumn get isDirty => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class TaskImages extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get taskId => text().references(Tasks, #id)();
  TextColumn get localPath => text()(); // Path on device
  TextColumn get storagePath => text().nullable()(); // Path in Supabase Storage
  DateTimeColumn get createdAt => dateTime()();

  // For Sync
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  BoolColumn get isDirty => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
