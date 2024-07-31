import 'package:flutter/material.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:simpletodo/domain/model/range_date_model.dart';
import 'package:table_calendar/table_calendar.dart';

class RangeDateCalendar extends StatelessWidget {
  const RangeDateCalendar({
    super.key,
    required this.onRangeSelected,
    required this.rangeDate,
    required this.selectedDate,
  });

  final RangeDate rangeDate;
  final DateTime selectedDate;
  final ValueChanged<RangeDate> onRangeSelected;

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
        rangeStartTextStyle: context.textTheme.bodyMedium!.copyWith(
          color: context.colorTheme.primary,
          fontWeight: FontWeight.bold,
        ),
        rangeEndTextStyle: context.textTheme.bodyMedium!.copyWith(
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
        rangeHighlightColor: context.colorTheme.onPrimary.withOpacity(0.2),
        rangeEndDecoration: BoxDecoration(
          color: context.colorTheme.onPrimary,
          shape: BoxShape.circle,
        ),
        rangeStartDecoration: BoxDecoration(
          color: context.colorTheme.onPrimary,
          shape: BoxShape.circle,
        ),
      ),
      rangeSelectionMode: RangeSelectionMode.enforced,
      focusedDay: selectedDate,
      rangeStartDay: rangeDate.start,
      rangeEndDay: rangeDate.end,
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      selectedDayPredicate: (day) {
        return isSameDay(selectedDate, day);
      },
      onRangeSelected: (start, end, focusedDay) {
        onRangeSelected(RangeDate(start: start, end: end));
      },
    );
  }
}
