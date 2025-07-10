import 'package:flakesmobile/auth/models/auth_model.dart';
import 'package:flakesmobile/auth/notifiers/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthModel>((ref) {
  return AuthNotifier();
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isLoading;
});