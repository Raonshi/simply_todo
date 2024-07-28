import 'package:flutter/material.dart';
import 'package:simpletodo/common/theme.dart';

void showCommonSnackbar({
  required BuildContext context,
  required String msg,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: context.colorTheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        content: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.info,
                size: 24.0,
                color: context.colorTheme.primary,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                msg,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: context.colorTheme.primary,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );

void showErrorSnackbar({
  required BuildContext context,
  required String msg,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: context.colorTheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        content: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.dangerous,
                size: 24.0,
                color: context.colorTheme.onError,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                msg,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: context.colorTheme.onError,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
