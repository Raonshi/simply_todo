import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpletodo/bloc/todo_list/todo_list_bloc.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:simpletodo/domain/model/todo_model.dart';
import 'package:simpletodo/ui/widget/todo_list_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
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
              ],
            ),
          )
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return TodoListItem(
                data: todos[index],
                onTapCheckbox: () =>
                    context.read<TodoListBloc>().toggleCheckbox(index),
                onTapDelete: () =>
                    context.read<TodoListBloc>().deleteTodo(index),
              );
            },
          );
  }
}
