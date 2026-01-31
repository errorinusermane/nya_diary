import 'package:flutter/material.dart';
import 'package:nya_diary/pages/lock_page.dart';
import 'theme/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _theme = lightTheme;

  void _toggleTheme(ThemeData newTheme) {
    setState(() {
      _theme = newTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '냥생일지',
      theme: _theme,
      home: LockPage(onThemeChange: _toggleTheme), // ✅ 첫 진입은 LockPage
      debugShowCheckedModeBanner: false,
    );
  }
}
