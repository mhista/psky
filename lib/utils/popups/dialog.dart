import 'package:flutter/material.dart';

class PDialogs {
  static defaultDialog({
    required BuildContext context,
    String title = 'Removal Confirmation',
    String content =
        'Removing this data wil delete all related data. Are you sure?',
    String cancelText = 'Cancel',
    String confirmText = 'Remove',
    Function()? onCancel,
    Function()? onConfirm,
  }) {
    // show a confirmation dialog
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                onPressed: onCancel ?? () => Navigator.of(context).pop(),
                child: Text(cancelText),
              ),
              TextButton(
                onPressed: onConfirm,
                child: Text(confirmText),
              ),
            ],
          );
        });
  }
}
