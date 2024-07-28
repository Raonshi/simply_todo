import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpletodo/bloc/todo_list/todo_list_bloc.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:simpletodo/domain/model/todo_model.dart';
import 'package:simpletodo/ui/home/widget/todo_list_item.dart';

class InCompletedList extends StatelessWidget {
  const InCompletedList({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 24.0),
          child: Text("할 일", style: context.textTheme.titleSmall),
        ),
        Divider(
          height: 17.0,
          thickness: 1.0,
          color: context.colorTheme.onSurface,
          indent: 20.0,
          endIndent: 20.0,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final Todo todo = todos[index];
            return TodoListItem(
              key: ValueKey(todo.id),
              data: todo,
              onTapCheckbox: () =>
                  context.read<TodoListBloc>().toggleCheckbox(todo.id),
              onTapDelete: () =>
                  context.read<TodoListBloc>().deleteTodo(todo.id),
            );
          },
        ),
      ],
    );
  }
}
