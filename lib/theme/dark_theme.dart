import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 169, 117, 84), // 주요 색 (AppBar, 버튼, 배경 등)
    onPrimary: Colors.orange[100]!, // primary 위 텍스트
    secondary: Colors.orange[600]!, // 강조 요소 (예: 선택된 탭)
    onSecondary: Colors.black, // secondary 위 텍스트
    error: Colors.red[400]!,
    onError: Colors.white,
    surface: Colors.orangeAccent[200]!,
    onSurface: Colors.brown[900]!, // 카드 선택했을 때
  ),
);
