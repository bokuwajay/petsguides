import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppBarThemeClass {
  AppBarThemeClass._();

  static AppBarTheme lightAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: HexColor('#ED7130')));

  static AppBarTheme darkAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: HexColor('#F2A73B')));
}
