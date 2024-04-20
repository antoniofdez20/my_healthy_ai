import 'package:flutter/material.dart';
import 'package:my_healthy_ai/utils/utils.dart';

class MyTheme {
  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: MyColors.carolinaBlue,
        centerTitle: true,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: MyColors.azure,
      ),
      //primaryColor: const Color(0xFFA3CEF1), //0xFF6096BA
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: MyColors.prussianBlue,
        centerTitle: true,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: MyColors.prussianBlue,
      ),
      //primaryColor: const Color(0xFF09586A),
      scaffoldBackgroundColor: MyColors.midnightGreen,
    );
  }
}
