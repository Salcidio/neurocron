import 'package:flakesmobile/auth/models/auth_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthNotifier extends StateNotifier<AuthModel> {
  final SupabaseClient _supabase = Supabase.instance.client;

  AuthNotifier() : super(AuthModel()) {
    // Check initial session
    _supabase.auth.onAuthStateChange.listen((data) {
      final Session? session = data.session;
      if (session != null) {
        state = state.copyWith(user: session.user);
      } else {
        state = state.copyWith(user: null);
      }
    });
  }

  Future<void> signUp(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      // The onAuthStateChange listener will handle setting the user state
    } on AuthException catch (e) {
      // Handle error, maybe expose it in the state
      print(e.message);
      state = state.copyWith(
        isLoading: false,
        error: "Algo correu mal .Por favor tente novamente",
      );
    } finally {
      state = state.copyWith(
        isLoading: false,
        error: "Algo correu mal .Por favor tente novamente",
      );
    }
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      print(response);
    } on AuthException catch (e) {
      print(e.message);
      state = state.copyWith(
        isLoading: false,
        error: "Algo correu mal .Por favor tente novamente",
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    await _supabase.auth.signOut();
    state = state.copyWith(isLoading: false, user: null);
  }
}
