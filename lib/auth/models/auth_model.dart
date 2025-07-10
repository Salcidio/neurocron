import 'package:supabase_flutter/supabase_flutter.dart';

class AuthModel {
  final User? user;
  final bool isLoading;

  AuthModel({this.user, this.isLoading = false});

  // A copyWith method allows easy state updates --snowFlake
  AuthModel copyWith({User? user, bool? isLoading}) {
    return AuthModel(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}