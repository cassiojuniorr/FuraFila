import 'package:flutter/material.dart';
import './pages/login.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MyApp(title: 'sdada',));
}

class MyApp extends StatelessWidget {
  final String title;
  const MyApp({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}