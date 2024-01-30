import 'package:flutter/material.dart';
import 'package:password_generator/auth/login.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MainApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
