import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Required by Flutter --snowFlake
  await Supabase.initialize(
    url: 'https://xhubdviugwuxhezfclgg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhodWJkdml1Z3d1eGhlemZjbGdnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIxMzUwMjcsImV4cCI6MjA2NzcxMTAyN30.v0PX5GeBVXOdL9ZaLYcEVbidAKN8uz7jN6RgHkEyqyo',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Base App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main View')),
      body: Center(
        child: Text(
          'Welcome to your Flutter app!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
