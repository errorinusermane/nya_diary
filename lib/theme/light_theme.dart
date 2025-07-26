import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 255, 215, 155), // 주요 색 (AppBar, 버튼, 배경 등)
    onPrimary: Colors.brown[900]!, // primary 위 텍스트
    secondary: Colors.orange[600]!, // 강조 요소 (예: 선택된 탭)
    onSecondary: Colors.black, // secondary 위 텍스트
    error: Colors.red[400]!,
    onError: Colors.white,
    surface: Color.fromARGB(255, 169, 117, 84),
    onSurface: Colors.orange[100]!, // 카드 선택했을 때
  ),
);
