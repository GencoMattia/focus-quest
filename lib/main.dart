import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:focus_quest/core/router/app_router.dart';
import 'package:focus_quest/core/theme/app_theme.dart';
import 'package:focus_quest/core/config/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase with environment configuration
  // Configuration is loaded from EnvConfig which can use environment variables
  // For development, default values are used from EnvConfig
  // For production, set SUPABASE_URL and SUPABASE_ANON_KEY environment variables
  await Supabase.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseAnonKey,
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
