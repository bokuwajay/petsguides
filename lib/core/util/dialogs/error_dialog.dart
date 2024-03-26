import 'package:flutter/material.dart';
import 'package:petsguides/core/util/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String title,
  String text,
  String confirmBtn,
) {
  return showGenericDialog<void>(
    context: context,
    title: title,
    content: text,
    optionBuilder: () => {
      confirmBtn: null,
    },
  );
}