import 'package:supabase_flutter/supabase_flutter.dart';


class AuthModel {
  final bool isLoading;
  final String? error;
  final User? user; // Replace with your User class

  AuthModel({this.isLoading = false, this.error, this.user});

  AuthModel copyWith({bool? isLoading, String? error, User? user}) {
    return AuthModel(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}
