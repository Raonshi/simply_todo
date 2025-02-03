import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpletodo/common/theme.dart';

import 'todo_calendar.dart';
import '../../todo_list/bloc/todo_list_bloc.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoListState>(
      builder: (context, state) => switch (state) {
        TodoListInitial _ => Container(),
        TodoListLoading _ => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        TodoListLoaded loaded => TodoCalendar(
            todos: loaded.todos,
          ),
        TodoListError error => Center(
            child: Container(
              decoration: BoxDecoration(
                color: context.colorTheme.error,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 12.0,
              ),
              child: Text(
                error.exception.toString(),
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorTheme.onError,
                ),
              ),
            ),
          ),
        // ignore: unreachable_switch_case
        _ => Container(),
      },
    );
  }
}
