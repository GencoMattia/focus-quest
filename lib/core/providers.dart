import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus_quest/core/database/app_database.dart';
import 'package:focus_quest/core/sync_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
AppDatabase database(DatabaseRef ref) {
  return AppDatabase();
}

@Riverpod(keepAlive: true)
SyncService syncService(SyncServiceRef ref) {
  final database = ref.watch(databaseProvider);
  final supabaseClient = Supabase.instance.client;
  return SyncService(database, supabaseClient);
}
