import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TextSelectionThemeClass {
  TextSelectionThemeClass._();

  static TextSelectionThemeData lightTextSelectionTheme =
      TextSelectionThemeData(cursorColor: HexColor('#ED7130'));

  static TextSelectionThemeData darkTextSelectionTheme =
      TextSelectionThemeData(cursorColor: HexColor('#F2A73B'));
}
