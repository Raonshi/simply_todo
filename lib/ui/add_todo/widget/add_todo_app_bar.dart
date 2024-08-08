import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simpletodo/common/theme.dart';

final class AddTodoAppBar extends AppBar {
  AddTodoAppBar({
    super.key,
    required BuildContext context,
    required VoidCallback onTapAdd,
  }) : super(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            iconSize: 32.0,
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: context.colorTheme.onPrimary,
              size: 24.0,
            ),
          ),
          centerTitle: false,
          title: Text(
            "할 일 추가",
            style: context.textTheme.titleLarge,
          ),
          actions: [
            IconButton(
              onPressed: onTapAdd,
              iconSize: 32.0,
              icon: const Icon(FontAwesomeIcons.check, size: 24.0),
            ),
            const SizedBox(width: 12.0),
          ],
        );
}
