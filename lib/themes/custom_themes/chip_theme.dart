import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ChipThemeClass {
  ChipThemeClass._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: TextStyle(color: HexColor('#ED7130')),
    selectedColor: HexColor('#ED7130'),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: Colors.white,
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: TextStyle(color: HexColor('#F2A73B')),
    selectedColor: HexColor('#F2A73B'),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: Colors.white,
  );
}
