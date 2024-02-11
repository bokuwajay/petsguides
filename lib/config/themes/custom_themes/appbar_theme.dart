import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppBarThemeClass {
  AppBarThemeClass._();

  static AppBarTheme lightAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: HexColor('#ED7130'), size: 24),
      actionsIconTheme: IconThemeData(color: HexColor('#ED7130'), size: 24),
      titleTextStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: HexColor('#ED7130')));

  static AppBarTheme darkAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: HexColor('#F2A73B'), size: 24),
      actionsIconTheme: IconThemeData(color: HexColor('#F2A73B'), size: 24),
      titleTextStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: HexColor('#F2A73B')));
}
