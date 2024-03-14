import 'package:flutter/material.dart';
import 'package:petsguides/config/themes/custom_themes/appbar_theme.dart';
import 'package:petsguides/config/themes/custom_themes/bottom_sheet_theme.dart';
import 'package:petsguides/config/themes/custom_themes/checkbox_theme.dart';
import 'package:petsguides/config/themes/custom_themes/chip_theme.dart';
import 'package:petsguides/config/themes/custom_themes/elevated_button_theme.dart';
import 'package:petsguides/config/themes/custom_themes/icon_theme.dart';
import 'package:petsguides/config/themes/custom_themes/outlined_button_theme.dart';
import 'package:petsguides/config/themes/custom_themes/text_button_theme.dart';
import 'package:petsguides/config/themes/custom_themes/text_form_field_theme.dart';
import 'package:petsguides/config/themes/custom_themes/text_selection_theme.dart';
import 'package:petsguides/config/themes/custom_themes/text_theme.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeClass {
  // ThemeClass has a private constructor with the name _ ,
  // By making the constructor private, you ensure that instances of ThemeClass cannot be created using the new keyword from outside
  ThemeClass._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: HexColor('#F2F2F2'),
    textTheme: TextThemeClass.lightTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeClass.lightElevatedButtonTheme,
    appBarTheme: AppBarThemeClass.lightAppBarTheme,
    bottomSheetTheme: BottomSheetThemeClass.lightBottomSheetTheme,
    checkboxTheme: CheckboxThemeClass.lightCheckboxTheme,
    chipTheme: ChipThemeClass.lightChipTheme,
    outlinedButtonTheme: OutlinedButtonThemeClass.lightOutlinedButtonTheme,
    inputDecorationTheme: TextFormFieldThemeClass.lightInputDecorationTheme,
    textButtonTheme: TextButtonThemeClass.lightTextButtonTheme,
    textSelectionTheme: TextSelectionThemeClass.lightTextSelectionTheme,
    iconTheme: IconThemeClass.lightIconTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: HexColor('#333333'),
    textTheme: TextThemeClass.darkTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeClass.darkElevatedButtonTheme,
    appBarTheme: AppBarThemeClass.darkAppBarTheme,
    bottomSheetTheme: BottomSheetThemeClass.darkBottomSheetTheme,
    checkboxTheme: CheckboxThemeClass.darkCheckboxTheme,
    chipTheme: ChipThemeClass.darkChipTheme,
    outlinedButtonTheme: OutlinedButtonThemeClass.darkOutlinedButtonTheme,
    inputDecorationTheme: TextFormFieldThemeClass.darkInputDecorationTheme,
    textButtonTheme: TextButtonThemeClass.darkTextButtonTheme,
    textSelectionTheme: TextSelectionThemeClass.darkTextSelectionTheme,
    iconTheme: IconThemeClass.darkIconTheme,
  );
}
