import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const SmartTransitApp());
}

class SmartTransitApp extends StatelessWidget {
  const SmartTransitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartTransit',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: const Color(0xFF8E24AA),
      ),
      home: const LoginScreen(),
    );
  }
}
