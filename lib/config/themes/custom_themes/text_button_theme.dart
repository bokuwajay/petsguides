import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TextButtonThemeClass {
  TextButtonThemeClass._();

  static final lightTextButtonTheme = TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: HexColor('#ED7130'),
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 18),
          textStyle: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));

  static final darkTextButtonTheme = TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: HexColor('#F2A73B'),
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 18),
          textStyle: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));
}
