import 'package:flutter/material.dart';
import 'package:flutter_high_performance_feed/core/constants/app_dimens.dart';

class SnackBarUtils {
  static void showSuccess(BuildContext context, String message) {

    final colorScheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(AppDimens.md),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusMd)),
        content: Row(
          children: [
            Icon(Icons.check_circle_outline, color: colorScheme.onPrimary),
            SizedBox(width: AppDimens.sm),
            Expanded(child: Text(message)),
          ],
        ),
        dismissDirection: DismissDirection.horizontal
      ),
    );
  }

  static void showError(BuildContext context, String message) {

    final colorScheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(AppDimens.md),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusMd)),
        content: Row(
          children: [
            Icon(Icons.error_outline, color: colorScheme.onPrimary),
            SizedBox(width: AppDimens.sm),
            Expanded(child: Text(message)),
          ],
        ),
        dismissDirection: DismissDirection.horizontal
      ),
    );
  }
}