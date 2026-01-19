// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _estimatedDurationMeta =
      const VerificationMeta('estimatedDuration');
  @override
  late final GeneratedColumn<int> estimatedDuration = GeneratedColumn<int>(
      'estimated_duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _deadlineMeta =
      const VerificationMeta('deadline');
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
      'deadline', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _urgencyMeta =
      const VerificationMeta('urgency');
  @override
  late final GeneratedColumn<String> urgency = GeneratedColumn<String>(
      'urgency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('medium'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('todo'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isDirtyMeta =
      const VerificationMeta('isDirty');
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
      'is_dirty', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_dirty" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        title,
        description,
        estimatedDuration,
        startDate,
        deadline,
        urgency,
        status,
        createdAt,
        updatedAt,
        lastSyncedAt,
        isDirty
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('estimated_duration')) {
      context.handle(
          _estimatedDurationMeta,
          estimatedDuration.isAcceptableOrUnknown(
              data['estimated_duration']!, _estimatedDurationMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('deadline')) {
      context.handle(_deadlineMeta,
          deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta));
    }
    if (data.containsKey('urgency')) {
      context.handle(_urgencyMeta,
          urgency.isAcceptableOrUnknown(data['urgency']!, _urgencyMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('is_dirty')) {
      context.handle(_isDirtyMeta,
          isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      estimatedDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}estimated_duration']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      deadline: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deadline']),
      urgency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}urgency'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_synced_at']),
      isDirty: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dirty'])!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final int? estimatedDuration;
  final DateTime? startDate;
  final DateTime? deadline;
  final String urgency;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastSyncedAt;
  final bool isDirty;
  const Task(
      {required this.id,
      required this.userId,
      required this.title,
      this.description,
      this.estimatedDuration,
      this.startDate,
      this.deadline,
      required this.urgency,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      this.lastSyncedAt,
      required this.isDirty});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || estimatedDuration != null) {
      map['estimated_duration'] = Variable<int>(estimatedDuration);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<DateTime>(deadline);
    }
    map['urgency'] = Variable<String>(urgency);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      estimatedDuration: estimatedDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedDuration),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      urgency: Value(urgency),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      isDirty: Value(isDirty),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      estimatedDuration: serializer.fromJson<int?>(json['estimatedDuration']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      deadline: serializer.fromJson<DateTime?>(json['deadline']),
      urgency: serializer.fromJson<String>(json['urgency']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'estimatedDuration': serializer.toJson<int?>(estimatedDuration),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'deadline': serializer.toJson<DateTime?>(deadline),
      'urgency': serializer.toJson<String>(urgency),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  Task copyWith(
          {String? id,
          String? userId,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<int?> estimatedDuration = const Value.absent(),
          Value<DateTime?> startDate = const Value.absent(),
          Value<DateTime?> deadline = const Value.absent(),
          String? urgency,
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> lastSyncedAt = const Value.absent(),
          bool? isDirty}) =>
      Task(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        estimatedDuration: estimatedDuration.present
            ? estimatedDuration.value
            : this.estimatedDuration,
        startDate: startDate.present ? startDate.value : this.startDate,
        deadline: deadline.present ? deadline.value : this.deadline,
        urgency: urgency ?? this.urgency,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        isDirty: isDirty ?? this.isDirty,
      );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      estimatedDuration: data.estimatedDuration.present
          ? data.estimatedDuration.value
          : this.estimatedDuration,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      urgency: data.urgency.present ? data.urgency.value : this.urgency,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('estimatedDuration: $estimatedDuration, ')
          ..write('startDate: $startDate, ')
          ..write('deadline: $deadline, ')
          ..write('urgency: $urgency, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      title,
      description,
      estimatedDuration,
      startDate,
      deadline,
      urgency,
      status,
      createdAt,
      updatedAt,
      lastSyncedAt,
      isDirty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.description == this.description &&
          other.estimatedDuration == this.estimatedDuration &&
          other.startDate == this.startDate &&
          other.deadline == this.deadline &&
          other.urgency == this.urgency &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.isDirty == this.isDirty);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> title;
  final Value<String?> description;
  final Value<int?> estimatedDuration;
  final Value<DateTime?> startDate;
  final Value<DateTime?> deadline;
  final Value<String> urgency;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<bool> isDirty;
  final Value<int> rowid;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.estimatedDuration = const Value.absent(),
    this.startDate = const Value.absent(),
    this.deadline = const Value.absent(),
    this.urgency = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    required String id,
    required String userId,
    required String title,
    this.description = const Value.absent(),
    this.estimatedDuration = const Value.absent(),
    this.startDate = const Value.absent(),
    this.deadline = const Value.absent(),
    this.urgency = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.lastSyncedAt = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        title = Value(title),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Task> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? estimatedDuration,
    Expression<DateTime>? startDate,
    Expression<DateTime>? deadline,
    Expression<String>? urgency,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<bool>? isDirty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (estimatedDuration != null) 'estimated_duration': estimatedDuration,
      if (startDate != null) 'start_date': startDate,
      if (deadline != null) 'deadline': deadline,
      if (urgency != null) 'urgency': urgency,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (isDirty != null) 'is_dirty': isDirty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? title,
      Value<String?>? description,
      Value<int?>? estimatedDuration,
      Value<DateTime?>? startDate,
      Value<DateTime?>? deadline,
      Value<String>? urgency,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? lastSyncedAt,
      Value<bool>? isDirty,
      Value<int>? rowid}) {
    return TasksCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      startDate: startDate ?? this.startDate,
      deadline: deadline ?? this.deadline,
      urgency: urgency ?? this.urgency,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      isDirty: isDirty ?? this.isDirty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (estimatedDuration.present) {
      map['estimated_duration'] = Variable<int>(estimatedDuration.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (urgency.present) {
      map['urgency'] = Variable<String>(urgency.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('estimatedDuration: $estimatedDuration, ')
          ..write('startDate: $startDate, ')
          ..write('deadline: $deadline, ')
          ..write('urgency: $urgency, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('isDirty: $isDirty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaskSessionsTable extends TaskSessions
    with TableInfo<$TaskSessionsTable, TaskSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tasks (id)'));
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isDirtyMeta =
      const VerificationMeta('isDirty');
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
      'is_dirty', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_dirty" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, taskId, startTime, endTime, durationSeconds, lastSyncedAt, isDirty];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<TaskSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('is_dirty')) {
      context.handle(_isDirtyMeta,
          isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time']),
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds']),
      lastSyncedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_synced_at']),
      isDirty: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dirty'])!,
    );
  }

  @override
  $TaskSessionsTable createAlias(String alias) {
    return $TaskSessionsTable(attachedDatabase, alias);
  }
}

class TaskSession extends DataClass implements Insertable<TaskSession> {
  final String id;
  final String taskId;
  final DateTime startTime;
  final DateTime? endTime;
  final int? durationSeconds;
  final DateTime? lastSyncedAt;
  final bool isDirty;
  const TaskSession(
      {required this.id,
      required this.taskId,
      required this.startTime,
      this.endTime,
      this.durationSeconds,
      this.lastSyncedAt,
      required this.isDirty});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['task_id'] = Variable<String>(taskId);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  TaskSessionsCompanion toCompanion(bool nullToAbsent) {
    return TaskSessionsCompanion(
      id: Value(id),
      taskId: Value(taskId),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      isDirty: Value(isDirty),
    );
  }

  factory TaskSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskSession(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String>(taskId),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  TaskSession copyWith(
          {String? id,
          String? taskId,
          DateTime? startTime,
          Value<DateTime?> endTime = const Value.absent(),
          Value<int?> durationSeconds = const Value.absent(),
          Value<DateTime?> lastSyncedAt = const Value.absent(),
          bool? isDirty}) =>
      TaskSession(
        id: id ?? this.id,
        taskId: taskId ?? this.taskId,
        startTime: startTime ?? this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        durationSeconds: durationSeconds.present
            ? durationSeconds.value
            : this.durationSeconds,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        isDirty: isDirty ?? this.isDirty,
      );
  TaskSession copyWithCompanion(TaskSessionsCompanion data) {
    return TaskSession(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskSession(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, taskId, startTime, endTime, durationSeconds, lastSyncedAt, isDirty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskSession &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.durationSeconds == this.durationSeconds &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.isDirty == this.isDirty);
}

class TaskSessionsCompanion extends UpdateCompanion<TaskSession> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<int?> durationSeconds;
  final Value<DateTime?> lastSyncedAt;
  final Value<bool> isDirty;
  final Value<int> rowid;
  const TaskSessionsCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaskSessionsCompanion.insert({
    required String id,
    required String taskId,
    required DateTime startTime,
    this.endTime = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        taskId = Value(taskId),
        startTime = Value(startTime);
  static Insertable<TaskSession> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? durationSeconds,
    Expression<DateTime>? lastSyncedAt,
    Expression<bool>? isDirty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (isDirty != null) 'is_dirty': isDirty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaskSessionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? taskId,
      Value<DateTime>? startTime,
      Value<DateTime?>? endTime,
      Value<int?>? durationSeconds,
      Value<DateTime?>? lastSyncedAt,
      Value<bool>? isDirty,
      Value<int>? rowid}) {
    return TaskSessionsCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      isDirty: isDirty ?? this.isDirty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskSessionsCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('isDirty: $isDirty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmotionalLogsTable extends EmotionalLogs
    with TableInfo<$EmotionalLogsTable, EmotionalLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmotionalLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tasks (id)'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
      'mood', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _intensityMeta =
      const VerificationMeta('intensity');
  @override
  late final GeneratedColumn<int> intensity = GeneratedColumn<int>(
      'intensity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contextMeta =
      const VerificationMeta('context');
  @override
  late final GeneratedColumn<String> context = GeneratedColumn<String>(
      'context', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isDirtyMeta =
      const VerificationMeta('isDirty');
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
      'is_dirty', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_dirty" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        taskId,
        userId,
        mood,
        intensity,
        note,
        context,
        createdAt,
        lastSyncedAt,
        isDirty
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emotional_logs';
  @override
  VerificationContext validateIntegrity(Insertable<EmotionalLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('mood')) {
      context.handle(
          _moodMeta, mood.isAcceptableOrUnknown(data['mood']!, _moodMeta));
    }
    if (data.containsKey('intensity')) {
      context.handle(_intensityMeta,
          intensity.isAcceptableOrUnknown(data['intensity']!, _intensityMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('context')) {
      context.handle(_contextMeta,
          this.context.isAcceptableOrUnknown(data['context']!, _contextMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('is_dirty')) {
      context.handle(_isDirtyMeta,
          isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmotionalLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmotionalLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      mood: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mood']),
      intensity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}intensity']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      context: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}context']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_synced_at']),
      isDirty: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dirty'])!,
    );
  }

  @override
  $EmotionalLogsTable createAlias(String alias) {
    return $EmotionalLogsTable(attachedDatabase, alias);
  }
}

class EmotionalLog extends DataClass implements Insertable<EmotionalLog> {
  final String id;
  final String? taskId;
  final String userId;
  final String? mood;
  final int? intensity;
  final String? note;
  final String? context;
  final DateTime createdAt;
  final DateTime? lastSyncedAt;
  final bool isDirty;
  const EmotionalLog(
      {required this.id,
      this.taskId,
      required this.userId,
      this.mood,
      this.intensity,
      this.note,
      this.context,
      required this.createdAt,
      this.lastSyncedAt,
      required this.isDirty});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<String>(taskId);
    }
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<String>(mood);
    }
    if (!nullToAbsent || intensity != null) {
      map['intensity'] = Variable<int>(intensity);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || context != null) {
      map['context'] = Variable<String>(context);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  EmotionalLogsCompanion toCompanion(bool nullToAbsent) {
    return EmotionalLogsCompanion(
      id: Value(id),
      taskId:
          taskId == null && nullToAbsent ? const Value.absent() : Value(taskId),
      userId: Value(userId),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      intensity: intensity == null && nullToAbsent
          ? const Value.absent()
          : Value(intensity),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      context: context == null && nullToAbsent
          ? const Value.absent()
          : Value(context),
      createdAt: Value(createdAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      isDirty: Value(isDirty),
    );
  }

  factory EmotionalLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmotionalLog(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String?>(json['taskId']),
      userId: serializer.fromJson<String>(json['userId']),
      mood: serializer.fromJson<String?>(json['mood']),
      intensity: serializer.fromJson<int?>(json['intensity']),
      note: serializer.fromJson<String?>(json['note']),
      context: serializer.fromJson<String?>(json['context']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String?>(taskId),
      'userId': serializer.toJson<String>(userId),
      'mood': serializer.toJson<String?>(mood),
      'intensity': serializer.toJson<int?>(intensity),
      'note': serializer.toJson<String?>(note),
      'context': serializer.toJson<String?>(context),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  EmotionalLog copyWith(
          {String? id,
          Value<String?> taskId = const Value.absent(),
          String? userId,
          Value<String?> mood = const Value.absent(),
          Value<int?> intensity = const Value.absent(),
          Value<String?> note = const Value.absent(),
          Value<String?> context = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> lastSyncedAt = const Value.absent(),
          bool? isDirty}) =>
      EmotionalLog(
        id: id ?? this.id,
        taskId: taskId.present ? taskId.value : this.taskId,
        userId: userId ?? this.userId,
        mood: mood.present ? mood.value : this.mood,
        intensity: intensity.present ? intensity.value : this.intensity,
        note: note.present ? note.value : this.note,
        context: context.present ? context.value : this.context,
        createdAt: createdAt ?? this.createdAt,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        isDirty: isDirty ?? this.isDirty,
      );
  EmotionalLog copyWithCompanion(EmotionalLogsCompanion data) {
    return EmotionalLog(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      userId: data.userId.present ? data.userId.value : this.userId,
      mood: data.mood.present ? data.mood.value : this.mood,
      intensity: data.intensity.present ? data.intensity.value : this.intensity,
      note: data.note.present ? data.note.value : this.note,
      context: data.context.present ? data.context.value : this.context,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmotionalLog(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('userId: $userId, ')
          ..write('mood: $mood, ')
          ..write('intensity: $intensity, ')
          ..write('note: $note, ')
          ..write('context: $context, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taskId, userId, mood, intensity, note,
      context, createdAt, lastSyncedAt, isDirty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmotionalLog &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.userId == this.userId &&
          other.mood == this.mood &&
          other.intensity == this.intensity &&
          other.note == this.note &&
          other.context == this.context &&
          other.createdAt == this.createdAt &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.isDirty == this.isDirty);
}

class EmotionalLogsCompanion extends UpdateCompanion<EmotionalLog> {
  final Value<String> id;
  final Value<String?> taskId;
  final Value<String> userId;
  final Value<String?> mood;
  final Value<int?> intensity;
  final Value<String?> note;
  final Value<String?> context;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<bool> isDirty;
  final Value<int> rowid;
  const EmotionalLogsCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.userId = const Value.absent(),
    this.mood = const Value.absent(),
    this.intensity = const Value.absent(),
    this.note = const Value.absent(),
    this.context = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmotionalLogsCompanion.insert({
    required String id,
    this.taskId = const Value.absent(),
    required String userId,
    this.mood = const Value.absent(),
    this.intensity = const Value.absent(),
    this.note = const Value.absent(),
    this.context = const Value.absent(),
    required DateTime createdAt,
    this.lastSyncedAt = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        createdAt = Value(createdAt);
  static Insertable<EmotionalLog> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<String>? userId,
    Expression<String>? mood,
    Expression<int>? intensity,
    Expression<String>? note,
    Expression<String>? context,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<bool>? isDirty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (userId != null) 'user_id': userId,
      if (mood != null) 'mood': mood,
      if (intensity != null) 'intensity': intensity,
      if (note != null) 'note': note,
      if (context != null) 'context': context,
      if (createdAt != null) 'created_at': createdAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (isDirty != null) 'is_dirty': isDirty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmotionalLogsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? taskId,
      Value<String>? userId,
      Value<String?>? mood,
      Value<int?>? intensity,
      Value<String?>? note,
      Value<String?>? context,
      Value<DateTime>? createdAt,
      Value<DateTime?>? lastSyncedAt,
      Value<bool>? isDirty,
      Value<int>? rowid}) {
    return EmotionalLogsCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      userId: userId ?? this.userId,
      mood: mood ?? this.mood,
      intensity: intensity ?? this.intensity,
      note: note ?? this.note,
      context: context ?? this.context,
      createdAt: createdAt ?? this.createdAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      isDirty: isDirty ?? this.isDirty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (mood.present) {
      map['mood'] = Variable<String>(mood.value);
    }
    if (intensity.present) {
      map['intensity'] = Variable<int>(intensity.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (context.present) {
      map['context'] = Variable<String>(context.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmotionalLogsCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('userId: $userId, ')
          ..write('mood: $mood, ')
          ..write('intensity: $intensity, ')
          ..write('note: $note, ')
          ..write('context: $context, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('isDirty: $isDirty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaskImagesTable extends TaskImages
    with TableInfo<$TaskImagesTable, TaskImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tasks (id)'));
  static const VerificationMeta _localPathMeta =
      const VerificationMeta('localPath');
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
      'local_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _storagePathMeta =
      const VerificationMeta('storagePath');
  @override
  late final GeneratedColumn<String> storagePath = GeneratedColumn<String>(
      'storage_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isDirtyMeta =
      const VerificationMeta('isDirty');
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
      'is_dirty', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_dirty" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, taskId, localPath, storagePath, createdAt, lastSyncedAt, isDirty];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_images';
  @override
  VerificationContext validateIntegrity(Insertable<TaskImage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta));
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('storage_path')) {
      context.handle(
          _storagePathMeta,
          storagePath.isAcceptableOrUnknown(
              data['storage_path']!, _storagePathMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('is_dirty')) {
      context.handle(_isDirtyMeta,
          isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskImage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id'])!,
      localPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_path'])!,
      storagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}storage_path']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_synced_at']),
      isDirty: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dirty'])!,
    );
  }

  @override
  $TaskImagesTable createAlias(String alias) {
    return $TaskImagesTable(attachedDatabase, alias);
  }
}

class TaskImage extends DataClass implements Insertable<TaskImage> {
  final String id;
  final String taskId;
  final String localPath;
  final String? storagePath;
  final DateTime createdAt;
  final DateTime? lastSyncedAt;
  final bool isDirty;
  const TaskImage(
      {required this.id,
      required this.taskId,
      required this.localPath,
      this.storagePath,
      required this.createdAt,
      this.lastSyncedAt,
      required this.isDirty});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['task_id'] = Variable<String>(taskId);
    map['local_path'] = Variable<String>(localPath);
    if (!nullToAbsent || storagePath != null) {
      map['storage_path'] = Variable<String>(storagePath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  TaskImagesCompanion toCompanion(bool nullToAbsent) {
    return TaskImagesCompanion(
      id: Value(id),
      taskId: Value(taskId),
      localPath: Value(localPath),
      storagePath: storagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(storagePath),
      createdAt: Value(createdAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      isDirty: Value(isDirty),
    );
  }

  factory TaskImage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskImage(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      localPath: serializer.fromJson<String>(json['localPath']),
      storagePath: serializer.fromJson<String?>(json['storagePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String>(taskId),
      'localPath': serializer.toJson<String>(localPath),
      'storagePath': serializer.toJson<String?>(storagePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  TaskImage copyWith(
          {String? id,
          String? taskId,
          String? localPath,
          Value<String?> storagePath = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> lastSyncedAt = const Value.absent(),
          bool? isDirty}) =>
      TaskImage(
        id: id ?? this.id,
        taskId: taskId ?? this.taskId,
        localPath: localPath ?? this.localPath,
        storagePath: storagePath.present ? storagePath.value : this.storagePath,
        createdAt: createdAt ?? this.createdAt,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        isDirty: isDirty ?? this.isDirty,
      );
  TaskImage copyWithCompanion(TaskImagesCompanion data) {
    return TaskImage(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      storagePath:
          data.storagePath.present ? data.storagePath.value : this.storagePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskImage(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('localPath: $localPath, ')
          ..write('storagePath: $storagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, taskId, localPath, storagePath, createdAt, lastSyncedAt, isDirty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskImage &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.localPath == this.localPath &&
          other.storagePath == this.storagePath &&
          other.createdAt == this.createdAt &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.isDirty == this.isDirty);
}

class TaskImagesCompanion extends UpdateCompanion<TaskImage> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<String> localPath;
  final Value<String?> storagePath;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<bool> isDirty;
  final Value<int> rowid;
  const TaskImagesCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.storagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaskImagesCompanion.insert({
    required String id,
    required String taskId,
    required String localPath,
    this.storagePath = const Value.absent(),
    required DateTime createdAt,
    this.lastSyncedAt = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        taskId = Value(taskId),
        localPath = Value(localPath),
        createdAt = Value(createdAt);
  static Insertable<TaskImage> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<String>? localPath,
    Expression<String>? storagePath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<bool>? isDirty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (localPath != null) 'local_path': localPath,
      if (storagePath != null) 'storage_path': storagePath,
      if (createdAt != null) 'created_at': createdAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (isDirty != null) 'is_dirty': isDirty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaskImagesCompanion copyWith(
      {Value<String>? id,
      Value<String>? taskId,
      Value<String>? localPath,
      Value<String?>? storagePath,
      Value<DateTime>? createdAt,
      Value<DateTime?>? lastSyncedAt,
      Value<bool>? isDirty,
      Value<int>? rowid}) {
    return TaskImagesCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      localPath: localPath ?? this.localPath,
      storagePath: storagePath ?? this.storagePath,
      createdAt: createdAt ?? this.createdAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      isDirty: isDirty ?? this.isDirty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (storagePath.present) {
      map['storage_path'] = Variable<String>(storagePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskImagesCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('localPath: $localPath, ')
          ..write('storagePath: $storagePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('isDirty: $isDirty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $TaskSessionsTable taskSessions = $TaskSessionsTable(this);
  late final $EmotionalLogsTable emotionalLogs = $EmotionalLogsTable(this);
  late final $TaskImagesTable taskImages = $TaskImagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [tasks, taskSessions, emotionalLogs, taskImages];
}

typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  required String id,
  required String userId,
  required String title,
  Value<String?> description,
  Value<int?> estimatedDuration,
  Value<DateTime?> startDate,
  Value<DateTime?> deadline,
  Value<String> urgency,
  Value<String> status,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> lastSyncedAt,
  Value<bool> isDirty,
  Value<int> rowid,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> title,
  Value<String?> description,
  Value<int?> estimatedDuration,
  Value<DateTime?> startDate,
  Value<DateTime?> deadline,
  Value<String> urgency,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> lastSyncedAt,
  Value<bool> isDirty,
  Value<int> rowid,
});

final class $$TasksTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTable, Task> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TaskSessionsTable, List<TaskSession>>
      _taskSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.taskSessions,
          aliasName: $_aliasNameGenerator(db.tasks.id, db.taskSessions.taskId));

  $$TaskSessionsTableProcessedTableManager get taskSessionsRefs {
    final manager = $$TaskSessionsTableTableManager($_db, $_db.taskSessions)
        .filter((f) => f.taskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_taskSessionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$EmotionalLogsTable, List<EmotionalLog>>
      _emotionalLogsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.emotionalLogs,
              aliasName:
                  $_aliasNameGenerator(db.tasks.id, db.emotionalLogs.taskId));

  $$EmotionalLogsTableProcessedTableManager get emotionalLogsRefs {
    final manager = $$EmotionalLogsTableTableManager($_db, $_db.emotionalLogs)
        .filter((f) => f.taskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_emotionalLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TaskImagesTable, List<TaskImage>>
      _taskImagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.taskImages,
          aliasName: $_aliasNameGenerator(db.tasks.id, db.taskImages.taskId));

  $$TaskImagesTableProcessedTableManager get taskImagesRefs {
    final manager = $$TaskImagesTableTableManager($_db, $_db.taskImages)
        .filter((f) => f.taskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_taskImagesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get estimatedDuration => $composableBuilder(
      column: $table.estimatedDuration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deadline => $composableBuilder(
      column: $table.deadline, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get urgency => $composableBuilder(
      column: $table.urgency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnFilters(column));

  Expression<bool> taskSessionsRefs(
      Expression<bool> Function($$TaskSessionsTableFilterComposer f) f) {
    final $$TaskSessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.taskSessions,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskSessionsTableFilterComposer(
              $db: $db,
              $table: $db.taskSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> emotionalLogsRefs(
      Expression<bool> Function($$EmotionalLogsTableFilterComposer f) f) {
    final $$EmotionalLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.emotionalLogs,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmotionalLogsTableFilterComposer(
              $db: $db,
              $table: $db.emotionalLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> taskImagesRefs(
      Expression<bool> Function($$TaskImagesTableFilterComposer f) f) {
    final $$TaskImagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.taskImages,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskImagesTableFilterComposer(
              $db: $db,
              $table: $db.taskImages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get estimatedDuration => $composableBuilder(
      column: $table.estimatedDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
      column: $table.deadline, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get urgency => $composableBuilder(
      column: $table.urgency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnOrderings(column));
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get estimatedDuration => $composableBuilder(
      column: $table.estimatedDuration, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<String> get urgency =>
      $composableBuilder(column: $table.urgency, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);

  Expression<T> taskSessionsRefs<T extends Object>(
      Expression<T> Function($$TaskSessionsTableAnnotationComposer a) f) {
    final $$TaskSessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.taskSessions,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskSessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.taskSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> emotionalLogsRefs<T extends Object>(
      Expression<T> Function($$EmotionalLogsTableAnnotationComposer a) f) {
    final $$EmotionalLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.emotionalLogs,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmotionalLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.emotionalLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> taskImagesRefs<T extends Object>(
      Expression<T> Function($$TaskImagesTableAnnotationComposer a) f) {
    final $$TaskImagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.taskImages,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TaskImagesTableAnnotationComposer(
              $db: $db,
              $table: $db.taskImages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TasksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, $$TasksTableReferences),
    Task,
    PrefetchHooks Function(
        {bool taskSessionsRefs, bool emotionalLogsRefs, bool taskImagesRefs})> {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int?> estimatedDuration = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            Value<String> urgency = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TasksCompanion(
            id: id,
            userId: userId,
            title: title,
            description: description,
            estimatedDuration: estimatedDuration,
            startDate: startDate,
            deadline: deadline,
            urgency: urgency,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastSyncedAt: lastSyncedAt,
            isDirty: isDirty,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<int?> estimatedDuration = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            Value<String> urgency = const Value.absent(),
            Value<String> status = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TasksCompanion.insert(
            id: id,
            userId: userId,
            title: title,
            description: description,
            estimatedDuration: estimatedDuration,
            startDate: startDate,
            deadline: deadline,
            urgency: urgency,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastSyncedAt: lastSyncedAt,
            isDirty: isDirty,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TasksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {taskSessionsRefs = false,
              emotionalLogsRefs = false,
              taskImagesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (taskSessionsRefs) db.taskSessions,
                if (emotionalLogsRefs) db.emotionalLogs,
                if (taskImagesRefs) db.taskImages
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (taskSessionsRefs)
                    await $_getPrefetchedData<Task, $TasksTable, TaskSession>(
                        currentTable: table,
                        referencedTable:
                            $$TasksTableReferences._taskSessionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TasksTableReferences(db, table, p0)
                                .taskSessionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.taskId == item.id),
                        typedResults: items),
                  if (emotionalLogsRefs)
                    await $_getPrefetchedData<Task, $TasksTable, EmotionalLog>(
                        currentTable: table,
                        referencedTable:
                            $$TasksTableReferences._emotionalLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TasksTableReferences(db, table, p0)
                                .emotionalLogsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.taskId == item.id),
                        typedResults: items),
                  if (taskImagesRefs)
                    await $_getPrefetchedData<Task, $TasksTable, TaskImage>(
                        currentTable: table,
                        referencedTable:
                            $$TasksTableReferences._taskImagesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TasksTableReferences(db, table, p0)
                                .taskImagesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.taskId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TasksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, $$TasksTableReferences),
    Task,
    PrefetchHooks Function(
        {bool taskSessionsRefs, bool emotionalLogsRefs, bool taskImagesRefs})>;
typedef $$TaskSessionsTableCreateCompanionBuilder = TaskSessionsCompanion
    Function({
  required String id,
  required String taskId,
  required DateTime startTime,
  Value<DateTime?> endTime,
  Value<int?> durationSeconds,
  Value<DateTime?> lastSyncedAt,
  Value<bool> isDirty,
  Value<int> rowid,
});
typedef $$TaskSessionsTableUpdateCompanionBuilder = TaskSessionsCompanion
    Function({
  Value<String> id,
  Value<String> taskId,
  Value<DateTime> startTime,
  Value<DateTime?> endTime,
  Value<int?> durationSeconds,
  Value<DateTime?> lastSyncedAt,
  Value<bool> isDirty,
  Value<int> rowid,
});

final class $$TaskSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $TaskSessionsTable, TaskSession> {
  $$TaskSessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TasksTable _taskIdTable(_$AppDatabase db) => db.tasks
      .createAlias($_aliasNameGenerator(db.taskSessions.taskId, db.tasks.id));

  $$TasksTableProcessedTableManager get taskId {
    final $_column = $_itemColumn<String>('task_id')!;

    final manager = $$TasksTableTableManager($_db, $_db.tasks)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TaskSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $TaskSessionsTable> {
  $$TaskSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnFilters(column));

  $$TasksTableFilterComposer get taskId {
    final $$TasksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableFilterComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TaskSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TaskSessionsTable> {
  $$TaskSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnOrderings(column));

  $$TasksTableOrderingComposer get taskId {
    final $$TasksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableOrderingComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TaskSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaskSessionsTable> {
  $$TaskSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);

  $$TasksTableAnnotationComposer get taskId {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableAnnotationComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TaskSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TaskSessionsTable,
    TaskSession,
    $$TaskSessionsTableFilterComposer,
    $$TaskSessionsTableOrderingComposer,
    $$TaskSessionsTableAnnotationComposer,
    $$TaskSessionsTableCreateCompanionBuilder,
    $$TaskSessionsTableUpdateCompanionBuilder,
    (TaskSession, $$TaskSessionsTableReferences),
    TaskSession,
    PrefetchHooks Function({bool taskId})> {
  $$TaskSessionsTableTableManager(_$AppDatabase db, $TaskSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> taskId = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<int?> durationSeconds = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskSessionsCompanion(
            id: id,
            taskId: taskId,
            startTime: startTime,
            endTime: endTime,
            durationSeconds: durationSeconds,
            lastSyncedAt: lastSyncedAt,
            isDirty: isDirty,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String taskId,
            required DateTime startTime,
            Value<DateTime?> endTime = const Value.absent(),
            Value<int?> durationSeconds = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskSessionsCompanion.insert(
            id: id,
            taskId: taskId,
            startTime: startTime,
            endTime: endTime,
            durationSeconds: durationSeconds,
            lastSyncedAt: lastSyncedAt,
            isDirty: isDirty,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TaskSessionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({taskId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (taskId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.taskId,
                    referencedTable:
                        $$TaskSessionsTableReferences._taskIdTable(db),
                    referencedColumn:
                        $$TaskSessionsTableReferences._taskIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TaskSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TaskSessionsTable,
    TaskSession,
    $$TaskSessionsTableFilterComposer,
    $$TaskSessionsTableOrderingComposer,
    $$TaskSessionsTableAnnotationComposer,
    $$TaskSessionsTableCreateCompanionBuilder,
    $$TaskSessionsTableUpdateCompanionBuilder,
    (TaskSession, $$TaskSessionsTableReferences),
    TaskSession,
    PrefetchHooks Function({bool taskId})>;
typedef $$EmotionalLogsTableCreateCompanionBuilder = EmotionalLogsCompanion
    Function({
  required String id,
  Value<String?> taskId,
  required String userId,
  Value<String?> mood,
  Value<int?> intensity,
  Value<String?> note,
  Value<String?> context,
  required DateTime createdAt,
  Value<DateTime?> lastSyncedAt,
  Value<bool> isDirty,
  Value<int> rowid,
});
typedef $$EmotionalLogsTableUpdateCompanionBuilder = EmotionalLogsCompanion
    Function({
  Value<String> id,
  Value<String?> taskId,
  Value<String> userId,
  Value<String?> mood,
  Value<int?> intensity,
  Value<String?> note,
  Value<String?> context,
  Value<DateTime> createdAt,
  Value<DateTime?> lastSyncedAt,
  Value<bool> isDirty,
  Value<int> rowid,
});

final class $$EmotionalLogsTableReferences
    extends BaseReferences<_$AppDatabase, $EmotionalLogsTable, EmotionalLog> {
  $$EmotionalLogsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $TasksTable _taskIdTable(_$AppDatabase db) => db.tasks
      .createAlias($_aliasNameGenerator(db.emotionalLogs.taskId, db.tasks.id));

  $$TasksTableProcessedTableManager? get taskId {
    final $_column = $_itemColumn<String>('task_id');
    if ($_column == null) return null;
    final manager = $$TasksTableTableManager($_db, $_db.tasks)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EmotionalLogsTableFilterComposer
    extends Composer<_$AppDatabase, $EmotionalLogsTable> {
  $$EmotionalLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mood => $composableBuilder(
      column: $table.mood, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get intensity => $composableBuilder(
      column: $table.intensity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get context => $composableBuilder(
      column: $table.context, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnFilters(column));

  $$TasksTableFilterComposer get taskId {
    final $$TasksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableFilterComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EmotionalLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $EmotionalLogsTable> {
  $$EmotionalLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mood => $composableBuilder(
      column: $table.mood, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get intensity => $composableBuilder(
      column: $table.intensity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get context => $composableBuilder(
      column: $table.context, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnOrderings(column));

  $$TasksTableOrderingComposer get taskId {
    final $$TasksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableOrderingComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EmotionalLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmotionalLogsTable> {
  $$EmotionalLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<int> get intensity =>
      $composableBuilder(column: $table.intensity, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get context =>
      $composableBuilder(column: $table.context, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);

  $$TasksTableAnnotationComposer get taskId {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableAnnotationComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EmotionalLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EmotionalLogsTable,
    EmotionalLog,
    $$EmotionalLogsTableFilterComposer,
    $$EmotionalLogsTableOrderingComposer,
    $$EmotionalLogsTableAnnotationComposer,
    $$EmotionalLogsTableCreateCompanionBuilder,
    $$EmotionalLogsTableUpdateCompanionBuilder,
    (EmotionalLog, $$EmotionalLogsTableReferences),
    EmotionalLog,
    PrefetchHooks Function({bool taskId})> {
  $$EmotionalLogsTableTableManager(_$AppDatabase db, $EmotionalLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmotionalLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmotionalLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmotionalLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> taskId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String?> mood = const Value.absent(),
            Value<int?> intensity = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> context = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EmotionalLogsCompanion(
            id: id,
            taskId: taskId,
            userId: userId,
            mood: mood,
            intensity: intensity,
            note: note,
            context: context,
            createdAt: createdAt,
            lastSyncedAt: lastSyncedAt,
            isDirty: isDirty,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> taskId = const Value.absent(),
            required String userId,
            Value<String?> mood = const Value.absent(),
            Value<int?> intensity = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> context = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EmotionalLogsCompanion.insert(
            id: id,
            taskId: taskId,
            userId: userId,
            mood: mood,
            intensity: intensity,
            note: note,
            context: context,
            createdAt: createdAt,
            lastSyncedAt: lastSyncedAt,
            isDirty: isDirty,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EmotionalLogsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({taskId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (taskId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.taskId,
                    referencedTable:
                        $$EmotionalLogsTableReferences._taskIdTable(db),
                    referencedColumn:
                        $$EmotionalLogsTableReferences._taskIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EmotionalLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EmotionalLogsTable,
    EmotionalLog,
    $$EmotionalLogsTableFilterComposer,
    $$EmotionalLogsTableOrderingComposer,
    $$EmotionalLogsTableAnnotationComposer,
    $$EmotionalLogsTableCreateCompanionBuilder,
    $$EmotionalLogsTableUpdateCompanionBuilder,
    (EmotionalLog, $$EmotionalLogsTableReferences),
    EmotionalLog,
    PrefetchHooks Function({bool taskId})>;
typedef $$TaskImagesTableCreateCompanionBuilder = TaskImagesCompanion Function({
  required String id,
  required String taskId,
  required String localPath,
  Value<String?> storagePath,
  required DateTime createdAt,
  Value<DateTime?> lastSyncedAt,
  Value<bool> isDirty,
  Value<int> rowid,
});
typedef $$TaskImagesTableUpdateCompanionBuilder = TaskImagesCompanion Function({
  Value<String> id,
  Value<String> taskId,
  Value<String> localPath,
  Value<String?> storagePath,
  Value<DateTime> createdAt,
  Value<DateTime?> lastSyncedAt,
  Value<bool> isDirty,
  Value<int> rowid,
});

final class $$TaskImagesTableReferences
    extends BaseReferences<_$AppDatabase, $TaskImagesTable, TaskImage> {
  $$TaskImagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TasksTable _taskIdTable(_$AppDatabase db) => db.tasks
      .createAlias($_aliasNameGenerator(db.taskImages.taskId, db.tasks.id));

  $$TasksTableProcessedTableManager get taskId {
    final $_column = $_itemColumn<String>('task_id')!;

    final manager = $$TasksTableTableManager($_db, $_db.tasks)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TaskImagesTableFilterComposer
    extends Composer<_$AppDatabase, $TaskImagesTable> {
  $$TaskImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storagePath => $composableBuilder(
      column: $table.storagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnFilters(column));

  $$TasksTableFilterComposer get taskId {
    final $$TasksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableFilterComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TaskImagesTableOrderingComposer
    extends Composer<_$AppDatabase, $TaskImagesTable> {
  $$TaskImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storagePath => $composableBuilder(
      column: $table.storagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnOrderings(column));

  $$TasksTableOrderingComposer get taskId {
    final $$TasksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableOrderingComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TaskImagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaskImagesTable> {
  $$TaskImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get storagePath => $composableBuilder(
      column: $table.storagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);

  $$TasksTableAnnotationComposer get taskId {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableAnnotationComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TaskImagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TaskImagesTable,
    TaskImage,
    $$TaskImagesTableFilterComposer,
    $$TaskImagesTableOrderingComposer,
    $$TaskImagesTableAnnotationComposer,
    $$TaskImagesTableCreateCompanionBuilder,
    $$TaskImagesTableUpdateCompanionBuilder,
    (TaskImage, $$TaskImagesTableReferences),
    TaskImage,
    PrefetchHooks Function({bool taskId})> {
  $$TaskImagesTableTableManager(_$AppDatabase db, $TaskImagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> taskId = const Value.absent(),
            Value<String> localPath = const Value.absent(),
            Value<String?> storagePath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskImagesCompanion(
            id: id,
            taskId: taskId,
            localPath: localPath,
            storagePath: storagePath,
            createdAt: createdAt,
            lastSyncedAt: lastSyncedAt,
            isDirty: isDirty,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String taskId,
            required String localPath,
            Value<String?> storagePath = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaskImagesCompanion.insert(
            id: id,
            taskId: taskId,
            localPath: localPath,
            storagePath: storagePath,
            createdAt: createdAt,
            lastSyncedAt: lastSyncedAt,
            isDirty: isDirty,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TaskImagesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({taskId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (taskId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.taskId,
                    referencedTable:
                        $$TaskImagesTableReferences._taskIdTable(db),
                    referencedColumn:
                        $$TaskImagesTableReferences._taskIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TaskImagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TaskImagesTable,
    TaskImage,
    $$TaskImagesTableFilterComposer,
    $$TaskImagesTableOrderingComposer,
    $$TaskImagesTableAnnotationComposer,
    $$TaskImagesTableCreateCompanionBuilder,
    $$TaskImagesTableUpdateCompanionBuilder,
    (TaskImage, $$TaskImagesTableReferences),
    TaskImage,
    PrefetchHooks Function({bool taskId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$TaskSessionsTableTableManager get taskSessions =>
      $$TaskSessionsTableTableManager(_db, _db.taskSessions);
  $$EmotionalLogsTableTableManager get emotionalLogs =>
      $$EmotionalLogsTableTableManager(_db, _db.emotionalLogs);
  $$TaskImagesTableTableManager get taskImages =>
      $$TaskImagesTableTableManager(_db, _db.taskImages);
}
