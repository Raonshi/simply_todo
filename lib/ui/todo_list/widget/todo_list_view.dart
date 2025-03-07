import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplytodo/ui/todo_list/bloc/todo_list_bloc.dart';
import 'package:simplytodo/ui/todo_list/widget/empty_todo_panel.dart';

import '../../../model/todo_model.dart';
import 'completed_list.dart';
import 'incompleted_list.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TodoListBloc, TodoListState, List<TodoModel>>(
      selector: (state) => state.todos,
      builder: (context, todos) {
        final List<TodoModel> completes =
            todos.where((e) => e.completed).toList();
        final List<TodoModel> incompletes =
            todos.where((e) => !e.completed).toList();

        return todos.isEmpty
            ? const EmptyTodoPanel()
            : RefreshIndicator.adaptive(
                onRefresh: () async => context.read<TodoListBloc>().refresh(),
                child: ListView(
                  children: [
                    InCompletedList(todos: incompletes),
                    if (completes.isNotEmpty) CompletedList(todos: completes)
                  ],
                ),
              );
      },
    );
  }
}
