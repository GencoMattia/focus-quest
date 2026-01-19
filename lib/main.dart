import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:focus_quest/core/router/app_router.dart';
import 'package:focus_quest/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  // 1. Go to your Supabase Dashboard -> Project Settings -> API
  // 2. Copy the "URL" and "anon" (public) key
  await Supabase.initialize(
    url: 'https://zsoedqtarozpwnpxajrc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpzb2VkcXRhcm96cHducHhhanJjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg4NDQxMDcsImV4cCI6MjA4NDQyMDEwN30.Z7CI8yhdABNk8GKzlGNG5a9A_U4lybrbFFv5P09cuLM',
  );




  runApp(
    const ProviderScope(
      child: FocusQuestApp(),
    ),
  );
}

class FocusQuestApp extends ConsumerWidget {
  const FocusQuestApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Focus Quest',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
