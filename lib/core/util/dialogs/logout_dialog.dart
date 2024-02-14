import 'package:flutter/material.dart';
import 'package:petsguides/core/util/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(
  BuildContext context,
  String title,
  String text,
  String confirmBtn,
  String cancelBtn,
) {
  return showGenericDialog<bool>(
    context: context,
    title: title,
    content: text,
    optionBuilder: () => {
      cancelBtn: false,
      confirmBtn: true,
    },
  ).then(
    (value) => value ?? false,
  );
}
