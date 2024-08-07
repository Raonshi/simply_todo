import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:simpletodo/domain/model/todo_model.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendar extends StatelessWidget {
  const EventCalendar({
    super.key,
    required this.todos,
    required this.selectedDay,
    required this.format,
    required this.onDaySelected,
    required this.onFormatChanged,
  });

  final List<TodoModel> todos;

  final DateTime selectedDay;
  final CalendarFormat format;

  final ValueChanged<DateTime> onDaySelected;
  final ValueChanged<CalendarFormat> onFormatChanged;

  @override
  Widget build(BuildContext context) {
    return TableCalendar<TodoModel>(
      headerStyle: HeaderStyle(
        formatButtonVisible: true,
        titleCentered: true,
        leftChevronVisible: true,
        rightChevronVisible: true,
        headerPadding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 0.0,
          bottom: 20.0,
        ),
        titleTextStyle: context.textTheme.titleSmall!,
        titleTextFormatter: (date, locale) {
          return "${date.year}년 ${date.month}월";
        },
        formatButtonShowsNext: false,
        formatButtonDecoration: BoxDecoration(
          color: context.colorTheme.primary,
          border: Border.all(color: context.colorTheme.onPrimary, width: 1.0),
          borderRadius: BorderRadius.circular(99.0),
        ),
        formatButtonTextStyle: context.textTheme.labelMedium!.copyWith(
          color: context.colorTheme.onPrimary,
        ),
        leftChevronIcon: const Icon(FontAwesomeIcons.chevronLeft, size: 20.0),
        rightChevronIcon: const Icon(FontAwesomeIcons.chevronRight, size: 20.0),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: context.textTheme.labelMedium!,
        weekendStyle: context.textTheme.labelMedium!.copyWith(
          color: context.colorTheme.error,
        ),
      ),
      calendarStyle: CalendarStyle(
        todayTextStyle: context.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
        holidayTextStyle: context.textTheme.bodyMedium!.copyWith(
          color: context.colorTheme.error,
        ),
        weekendTextStyle: context.textTheme.bodyMedium!.copyWith(
          color: context.colorTheme.error,
        ),
        defaultTextStyle: context.textTheme.bodyMedium!,
        outsideTextStyle: context.textTheme.bodyMedium!.copyWith(
          color: context.colorTheme.onSurface.withOpacity(0.5),
        ),
        selectedTextStyle: context.textTheme.bodyMedium!.copyWith(
          color: context.colorTheme.primary,
          fontWeight: FontWeight.bold,
        ),
        todayDecoration: BoxDecoration(
          color: context.colorTheme.onSurface,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: context.colorTheme.onPrimary,
          shape: BoxShape.circle,
        ),
        markerDecoration: BoxDecoration(
          color: Colors.blue.shade300,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue.shade100, width: 1.0),
        ),
      ),
      rangeSelectionMode: RangeSelectionMode.disabled,
      focusedDay: selectedDay,
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 730)),
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
      availableCalendarFormats: const {
        CalendarFormat.month: '1 달',
        CalendarFormat.twoWeeks: '2 주',
        CalendarFormat.week: '1 주'
      },
      calendarFormat: format,
      onFormatChanged: onFormatChanged,
      eventLoader: (day) {
        return todos.where((e) {
          if (e.rangeDate != null) {
            return (e.rangeDate!.start?.isBefore(day) ?? false) &&
                (e.rangeDate!.end?.isAfter(day) ?? false);
          } else {
            return isSameDay(e.dueDate, day);
          }
        }).toList();
      },
      onDaySelected: (selectedDay, focusedDay) {
        onDaySelected(selectedDay);
      },
    );
  }
}
