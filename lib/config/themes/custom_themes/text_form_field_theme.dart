import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TextFormFieldThemeClass {
  TextFormFieldThemeClass._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: HexColor('#ED7130'),
    suffixIconColor: HexColor('#ED7130'),
    labelStyle: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: HexColor('#ED7130'),
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: HexColor('#ED7130'),
    ),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal, color: Colors.red),
    floatingLabelStyle: const TextStyle().copyWith(
      color: HexColor('#ED7130').withOpacity(0.8),
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 1, color: HexColor('#ED7130')),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 1, color: HexColor('#ED7130')),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 2,
        color: HexColor('#ED7130'),
      ),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 2, color: Colors.red),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: HexColor('#F2A73B'),
    suffixIconColor: HexColor('#F2A73B'),
    labelStyle: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: HexColor('#F2A73B'),
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: HexColor('#F2A73B'),
    ),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal, color: Colors.red),
    floatingLabelStyle: const TextStyle().copyWith(
      color: HexColor('#F2A73B').withOpacity(0.8),
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 1, color: HexColor('#F2A73B')),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 1, color: HexColor('#F2A73B')),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 2,
        color: HexColor('#F2A73B'),
      ),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 2, color: Colors.red),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
  );
}
