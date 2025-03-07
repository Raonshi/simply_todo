import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simplytodo/common/theme.dart';

import '../bloc/todo_list_bloc.dart';

class EmptyTodoPanel extends StatelessWidget {
  const EmptyTodoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "일정이 없습니다.\n일정을 추가해주세요.",
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorTheme.onSurface,
            ),
          ),
          const SizedBox(height: 12.0),
          IconButton(
            onPressed: () {
              context.read<TodoListBloc>().refresh();
            },
            iconSize: 32.0,
            color: context.colorTheme.onSurface,
            icon: const Icon(FontAwesomeIcons.arrowsRotate, size: 24.0),
          ),
        ],
      ),
    );
  }
}
