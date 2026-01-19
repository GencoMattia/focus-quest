import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:focus_quest/features/auth/data/guest_mode_provider.dart';
import 'package:focus_quest/features/auth/presentation/landing_page.dart';
import 'package:focus_quest/features/auth/presentation/login_screen.dart';
import 'package:focus_quest/features/auth/presentation/signup_screen.dart';
import 'package:focus_quest/features/tasks/presentation/dashboard_screen.dart';
import 'package:focus_quest/features/tasks/presentation/journal_screen.dart';
import 'package:focus_quest/features/tasks/presentation/create_task_screen.dart';
import 'package:focus_quest/features/tasks/presentation/task_execution_screen.dart';
import 'package:focus_quest/core/presentation/scaffold_with_navbar.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
  initialLocation: '/',
  refreshListenable: Listenable.merge([
    _GoRouterRefreshStream(Supabase.instance.client.auth.onAuthStateChange),
    _GuestModeRefreshNotifier(ref), // Need to create this helper or just listen to provider changes via a stream
  ]),
  redirect: (context, state) {
    final session = Supabase.instance.client.auth.currentSession;
    final isGuest = ref.read(guestModeProvider);
    print('DEBUG: Redirect Check - Session: $session, IsGuest: $isGuest, Path: ${state.uri}');
    
    final isLoggedIn = session != null || isGuest;
    
    final isLoggingIn = state.uri.toString() == '/login' || state.uri.toString() == '/signup' || state.uri.toString() == '/';
    
    if (!isLoggedIn && !isLoggingIn) return '/login';
    if (isLoggedIn && isLoggingIn) return '/dashboard';
    
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    // Shell Route for Bottom Nav
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        // Tab 1: Dashboard (Focus)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        // Tab 2: Journal (List & History)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/journal',
              builder: (context, state) => const JournalScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/create-task',
      builder: (context, state) => const CreateTaskScreen(),
    ),
    GoRoute(
      path: '/execute-task/:taskId',
      builder: (context, state) {
        final taskId = state.pathParameters['taskId']!;
        return TaskExecutionScreen(taskId: taskId);
      },
    ),
  ],
);
});

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<AuthState> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class _GuestModeRefreshNotifier extends ChangeNotifier {
  _GuestModeRefreshNotifier(ProviderRef ref) {
    ref.listen(guestModeProvider, (_, __) {
      print('DEBUG: Guest Mode Changed! Notifying listeners...');
      notifyListeners();
    });
  }
}
