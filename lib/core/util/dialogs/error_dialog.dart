import 'package:flutter/material.dart';
import 'package:petsguides/core/error/failure_messages_to_user.dart';
import 'package:petsguides/core/util/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String message) {
  final result = failureMessagesToUser(context, message);

  return showGenericDialog<void>(
    context: context,
    title: result['title']!,
    content: result['content']!,
    optionBuilder: () => {
      result['btn']!: null,
    },
  );
}
