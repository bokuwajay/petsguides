// previously we have error dialog (return different error msg) and logout dialog (return true / false)
// now we need this generic dialog based on what you provide to it, and is able to return those values to you
// every button/ item / option that is displayed in our generic dialog should have a value
// we assume that all btns that you display in any given dialog is going to have values of exactly the same data type
// thus here a need generic type , we are going to call it data type T

// T is optional because android hardware down btn can bypass responding to the dialog and make the value null

import 'package:flutter/material.dart';

// we need some sort ways for user able to specify (like a list of btns tp display), e.g every Text Button should have string to display and a press and optionally have a value (T), T is dynamic
// do above line by type definition below
// String is the text (title) and T is the value
// we have a type definition called DialogOptionBuilder, it is a generic
// it equals to a Function that returns that value
typedef DialogOptionBuilder<T> = Map<String, T?> Function();

// DialogOptionBuilder is stored in variable optionBuilder below
// then optionBuilder is stored in variable options, when options is called, every key (String in Map) inside the options is the title of the dialog

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionBuilder,
}) {
  final options = optionBuilder();
  return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: options.keys.map((optionTitle) {
            final T value = options[optionTitle];
            return TextButton(
                onPressed: () {
                  if (value != null) {
                    Navigator.of(context).pop(value);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(optionTitle));
          }).toList(), // without .toList() , when hover on options , we will see it return Iterable
        );
      });
}
