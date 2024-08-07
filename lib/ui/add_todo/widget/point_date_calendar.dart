import 'package:flutter/material.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class PointDateCalendar extends StatelessWidget {
  const PointDateCalendar(
      {super.key, required this.selectedDay, required this.onDaySelected});

  final DateTime selectedDay;
  final ValueChanged<DateTime> onDaySelected;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
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
      ),
      rangeSelectionMode: RangeSelectionMode.disabled,
      focusedDay: selectedDay,
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        onDaySelected(selectedDay);
      },
    );
  }
}
