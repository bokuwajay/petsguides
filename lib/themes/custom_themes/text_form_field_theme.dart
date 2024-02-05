import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TextFormFieldThemeClass {
  TextFormFieldThemeClass._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
      labelStyle: const TextStyle().copyWith(
        fontSize: 14,
        color: HexColor('#ED7130'),
      ),
      hintStyle: const TextStyle().copyWith(
        fontSize: 14,
        color: Colors.grey,
      ),
      errorStyle: const TextStyle()
          .copyWith(fontStyle: FontStyle.normal, color: Colors.red),
      floatingLabelStyle: const TextStyle().copyWith(
        color: HexColor('#ED7130').withOpacity(0.8),
      ),
      border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.grey),
      ),
      enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.grey),
      ),
      focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          width: 1,
          color: HexColor('#ED7130'),
        ),
      ),
      errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 2, color: Colors.red),
      ),
      iconColor: HexColor('#ED7130'));

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: HexColor('#F2A73B'),
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: Colors.grey,
    ),
    errorStyle: const TextStyle()
        .copyWith(fontStyle: FontStyle.normal, color: Colors.red),
    floatingLabelStyle: const TextStyle().copyWith(
      color: HexColor('#F2A73B').withOpacity(0.8),
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: Colors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: Colors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        width: 1,
        color: HexColor('#F2A73B'),
      ),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 2, color: Colors.red),
    ),
  );
}
