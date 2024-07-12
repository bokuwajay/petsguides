import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/pets_guides_localizations.dart';

Map<String, String> failureMessagesToUser(BuildContext context, String message) {
  String prefix = message.substring(0, message.indexOf(':'));
  switch (prefix) {
    case 'Connection Error' || 'Connection Time Out':
      return {
        'title': AppLocalizations.of(context)!.connectionErrorDialogTitle,
        'content': AppLocalizations.of(context)!.connectionErrorDialogContent,
        'btn': AppLocalizations.of(context)!.okBtn
      };

    case 'Fetch Data Failure' ||
          'Send Time Out' ||
          'Receive Time Out' ||
          'Bad Certificate' ||
          'Cancel Failure' ||
          'Method Not Allowed' ||
          'Unprocessable Content' ||
          'Internal Server Failure' ||
          'Bad Request' ||
          'Not Found Resources' ||
          'Cache Failure':
      return {
        'title': AppLocalizations.of(context)!.systemErrorDialogTitle,
        'content': AppLocalizations.of(context)!.systemErrorDialogContent,
        'btn': AppLocalizations.of(context)!.okBtn
      };

    case 'Unauthorized' || 'Forbidden':
      return {
        'title': AppLocalizations.of(context)!.userAuthorityDialogTitle,
        'content': AppLocalizations.of(context)!.userAuthorityDialogContent,
        'btn': AppLocalizations.of(context)!.okBtn
      };

    case 'Duplicated Data':
      return {
        'title': AppLocalizations.of(context)!.duplicateDataErrorDialogTitle,
        'content': AppLocalizations.of(context)!.duplicateDataErrorDialogContent,
        'btn': AppLocalizations.of(context)!.okBtn
      };
    case 'Missing Params Failure':
      return {
        'title': AppLocalizations.of(context)!.userInputErrorDialogTitle,
        'content': AppLocalizations.of(context)!.userInputErrorDialogContent,
        'btn': AppLocalizations.of(context)!.okBtn
      };
    default:
      return {
        'title': AppLocalizations.of(context)!.unexpectedErrorDialogTitle,
        'content': AppLocalizations.of(context)!.unexpectedErrorDialogContent,
        'btn': AppLocalizations.of(context)!.okBtn
      };
  }
}
