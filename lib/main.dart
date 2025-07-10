import 'package:flakesmobile/auth/gate/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Required by Flutter --snowFlake
  await Supabase.initialize(
    url: 'https://xhubdviugwuxhezfclgg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhodWJkdml1Z3d1eGhlemZjbGdnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIxMzUwMjcsImV4cCI6MjA2NzcxMTAyN30.v0PX5GeBVXOdL9ZaLYcEVbidAKN8uz7jN6RgHkEyqyo',
  );

  runApp(
    ProviderScope(
      child: MaterialApp(debugShowCheckedModeBanner: false, home: AuthGate()),
    ),
  );
}
