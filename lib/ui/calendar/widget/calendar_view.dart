import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'todo_calendar.dart';
import '../../todo_list/bloc/todo_list_bloc.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoListState>(
      builder: (context, state) => TodoCalendar(
        todos: state.todos,
      ),
    );
  }
}
