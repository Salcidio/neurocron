import 'package:flutter/material.dart';

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
