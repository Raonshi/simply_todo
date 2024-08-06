import 'package:flutter/material.dart';
import 'package:simpletodo/domain/model/todo_model.dart';
import 'package:simpletodo/ui/home/widget/completed_list.dart';

import 'empty_todo_panel.dart';
import 'incompleted_list.dart';

class TodoPanel extends StatelessWidget {
  const TodoPanel({super.key, required this.todos, required this.onRefresh});

  final List<TodoModel> todos;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final List<TodoModel> completes = todos.where((e) => e.completed).toList();
    final List<TodoModel> incompletes =
        todos.where((e) => !e.completed).toList();

    return todos.isEmpty
        ? EmptyTodoPanel(onRefresh: onRefresh)
        : RefreshIndicator.adaptive(
            onRefresh: () async => onRefresh(),
            child: ListView(
              children: [
                InCompletedList(todos: incompletes),
                if (completes.isNotEmpty) CompletedList(todos: completes)
              ],
            ),
          );
  }
}
