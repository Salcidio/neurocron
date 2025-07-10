import 'package:flakesmobile/auth/providers/auth_provider.dart';
import 'package:flakesmobile/auth/screens/home.dart';
import 'package:flakesmobile/auth/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider for state changes
    final authState = ref.watch(authProvider);

    // Return the correct screen based on auth state
    // The UI will automatically rebuild when the state changes
    if (authState.user != null) {
      return const HomePage();
    } else {
      return const LoginPage(); //const WelcomeScreen();
    }
  }
}
