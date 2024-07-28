import 'package:flutter/material.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:simpletodo/domain/model/todo_model.dart';
import 'package:simpletodo/ui/home/widget/completed_list.dart';

import 'incompleted_list.dart';

class TodoPanel extends StatelessWidget {
  const TodoPanel({super.key, required this.todos, required this.onRefresh});

  final List<Todo> todos;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final List<Todo> completes = todos.where((e) => e.completed).toList();
    final List<Todo> incompletes = todos.where((e) => !e.completed).toList();

    return todos.isEmpty
        ? Center(
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
                  onPressed: onRefresh,
                  iconSize: 32.0,
                  color: context.colorTheme.onSurface,
                  icon: const Icon(Icons.refresh, size: 24.0),
                ),
              ],
            ),
          )
        : RefreshIndicator.adaptive(
            onRefresh: () async => onRefresh(),
            child: ListView(
              children: [
                if (incompletes.isNotEmpty) InCompletedList(todos: incompletes),
                if (completes.isNotEmpty) CompletedList(todos: completes)
              ],
            ),
          );
  }
}
