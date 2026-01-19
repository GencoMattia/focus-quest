import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_quest/core/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
AppDatabase database(DatabaseRef ref) {
  return AppDatabase();
}
