import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart'
    hide TextButton, Theme, Colors, AlertDialog, showDialog;

class DialogHelper {
  /// A beautiful, dynamic, and reusable dialog
  static Future<T?> showDialoger<T>({
    required BuildContext context,
    required String title,
    String subtitle = '',
    String? primaryButtonText,
    VoidCallback? onPrimaryPressed,
    String? secondaryButtonText,
    VoidCallback? onSecondaryPressed,
    bool barrierDismissible = true,
    Widget? icon,
    Color? iconColor,
    Widget? customContent,
    bool dangerous = false, // for delete/confirm actions
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            if (icon != null) ...[
              IconTheme(
                data: IconThemeData(
                    color: iconColor ?? (dangerous ? Colors.red : null)),
                child: icon,
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(title).medium,
            ),
          ],
        ),
        content: subtitle.isNotEmpty || customContent != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subtitle.isNotEmpty) Text(subtitle).muted.medium,
                  if (customContent != null) ...[
                    const SizedBox(height: 16),
                    customContent,
                  ],
                ],
              )
            : null,
        actions: [
          if (secondaryButtonText != null)
            TextButton(
              onPressed: onSecondaryPressed ?? () => Navigator.pop(context),
              child: Text(secondaryButtonText),
            ),
          if (primaryButtonText != null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: dangerous ? Colors.red : null,
              ),
              onPressed: onPrimaryPressed ?? () => Navigator.pop(context),
              // backgroundColor: dangerous ? Colors.red : null,
              child: Text(primaryButtonText),
            )
          else if (onPrimaryPressed != null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: dangerous ? Colors.red : null,
              ),
              onPressed: onPrimaryPressed,
              child: const Text('OK'),
            ),
        ],
      ),
    );
  }

  // Convenience methods

  static Future<bool?> confirm({
    required BuildContext context,
    required String title,
    String subtitle = 'This action cannot be undone.',
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onPrimaryPressed,

  }) {
    return showDialoger<bool>(
      context: context,
      title: title,
      subtitle: subtitle,
      primaryButtonText: confirmText,
      onPrimaryPressed: onPrimaryPressed ??() => Navigator.pop(context, true),
      secondaryButtonText: cancelText,
      onSecondaryPressed: () => Navigator.pop(context, false),
      dangerous: true,
      icon: const Icon(Iconsax.warning_2, size: 28),
      iconColor: Colors.red,
    );
  }

  static Future<void> success({
    required BuildContext context,
    required String title,
    String subtitle = 'Your changes have been saved successfully.',
  }) {
    return showDialoger(
      context: context,
      title: title,
      subtitle: subtitle,
      primaryButtonText: 'Done',
      icon: const Icon(Iconsax.tick_circle, size: 32, color: Colors.green),
    );
  }

  static Future<void> error({
    required BuildContext context,
    required String title,
    String subtitle = 'Please try again later.',
  }) {
    return showDialoger(
      context: context,
      title: title,
      subtitle: subtitle,
      primaryButtonText: 'OK',
      dangerous: true,
      icon: const Icon(Iconsax.close_circle, size: 32),
      iconColor: Colors.red,
    );
  }

  static Future<void> info({
    required BuildContext context,
    required String title,
    String subtitle = '',
    Widget? customContent,
  }) {
    return showDialoger(
      context: context,
      title: title,
      subtitle: subtitle,
      primaryButtonText: 'Got it',
      customContent: customContent,
      icon: const Icon(Iconsax.info_circle, size: 28),
      iconColor: Theme.of(context).colorScheme.primary,
    );
  }
}
