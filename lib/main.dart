import 'package:flutter/material.dart';
import 'package:jarvis/pages/home_page.dart';
import 'package:jarvis/theme/app_theme.dart';

void main() {
  runApp(const JarvisApp());
}

class JarvisApp extends StatelessWidget {
  const JarvisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      home: const HomePage(),
    );
  }
}
