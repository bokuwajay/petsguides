import 'package:flutter/material.dart';
import 'package:petsguides/views/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'Opsss something wrong',
    content: text,
    optionBuilder: () => {
      'OK': null,
    },
  );
}
