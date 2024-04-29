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
      scaffoldBackgroundColor: MyColors.azure,

      //estilo elevated buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(200, 50),
          backgroundColor: MyColors.uranianBlue,
          foregroundColor: Colors.black,
        ),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: MyColors.uranianBlue,
      ),
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
