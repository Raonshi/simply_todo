import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpletodo/bloc/todo_list/todo_list_bloc.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:simpletodo/common/tools.dart';
import 'package:simpletodo/domain/model/todo_model.dart';
import 'package:simpletodo/ui/home/widget/event_calendar.dart';
import 'package:simpletodo/ui/home/widget/todo_list_item.dart';
import 'package:table_calendar/table_calendar.dart';

class TodoCalendar extends StatefulWidget {
  const TodoCalendar({super.key, required this.todos});

  final List<TodoModel> todos;

  @override
  State<TodoCalendar> createState() => _TodoCalendarState();
}

class _TodoCalendarState extends State<TodoCalendar> {
  late DateTime _selectedDay;
  late CalendarFormat _format;
  List<TodoModel> _totalTodos = [];

  @override
  void initState() {
    _selectedDay = now;
    _format = CalendarFormat.month;
    _totalTodos = widget.todos;
    super.initState();
  }

  List<TodoModel> get _selectedTodos => _totalTodos.where((element) {
        if (element.rangeDate != null) {
          final DateTime start = element.rangeDate!.start ?? now;
          final DateTime end = element.rangeDate!.end ?? now;
          return start.year <= _selectedDay.year &&
              start.month <= _selectedDay.month &&
              start.day <= _selectedDay.day &&
              end.year >= _selectedDay.year &&
              end.month >= _selectedDay.month &&
              end.day >= _selectedDay.day;
        } else {
          return element.dueDate.year == _selectedDay.year &&
              element.dueDate.month == _selectedDay.month &&
              element.dueDate.day == _selectedDay.day;
        }
      }).toList();

  @override
  void didUpdateWidget(covariant TodoCalendar oldWidget) {
    setState(() => _totalTodos = widget.todos);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12.0),
        EventCalendar(
          todos: widget.todos,
          selectedDay: _selectedDay,
          format: _format,
          onDaySelected: (DateTime date) {
            setState(() {
              _selectedDay = date;
            });
          },
          onFormatChanged: (CalendarFormat format) =>
              setState(() => _format = format),
        ),
        const SizedBox(height: 8.0),
        Divider(
          height: 4.0,
          thickness: 4.0,
          color: context.colorTheme.onSurface.withOpacity(0.08),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            itemCount: _selectedTodos.length,
            itemBuilder: (context, index) {
              final TodoModel todo = _selectedTodos[index];
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
        ),
      ],
    );
  }
}
