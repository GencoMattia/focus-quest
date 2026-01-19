import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Interface
// Interface
abstract class AuthRepository {
  Stream<AuthState> get authStateChanges;
  User? get currentUser;
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> signOut();
  Future<void> signInAnonymously();
}

// Implementation
class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _supabase;
  SupabaseAuthRepository(this._supabase);

  @override
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  @override
  User? get currentUser => _supabase.auth.currentUser;

  @override
  Future<void> signIn(String email, String password) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> signUp(String email, String password) async {
    await _supabase.auth.signUp(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<void> signInAnonymously() async {
     // Since Supabase requires a backend config for proper anonymous sign-in,
     // and we want to UNBLOCK the user immediately without admin access,
     // we will use a workaround:
     // We will NOT update Supabase auth state, but we will manage a local "Guest Token"
     // that the Router checks.
     // BUT, cleaner way: actually try official anon sign in first:
     try {
       await _supabase.auth.signInAnonymously();
     } catch (_) {
       // Fallback for user: we just can't easily mock auth state stream from here 
       // without wrapping everything. 
       // Let's implement a workaround in the Router directly for this specific emergency.
       // Or throw a specific error only UI handles.
       rethrow;
     }
  }
}

// Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return SupabaseAuthRepository(Supabase.instance.client);
});

final authStateProvider = StreamProvider<AuthState>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});
