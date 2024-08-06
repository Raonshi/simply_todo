import 'package:flutter/material.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:simpletodo/domain/model/range_date_model.dart';
import 'package:simpletodo/ui/add_todo/widget/range_date_calendar.dart';

import 'point_date_calendar.dart';

class AddTodoSchedulePanel extends StatelessWidget {
  const AddTodoSchedulePanel({
    super.key,
    required this.showNotification,
    required this.onTapNotiSwitch,
    required this.onDaySelected,
    required this.selectedDay,
    required this.rangeSelection,
    required this.onTapRangeDateSwitch,
    required this.rangeDate,
    required this.onRangeSelected,
  });

  final bool showNotification;
  final bool rangeSelection;

  final DateTime selectedDay;
  final RangeDateModel? rangeDate;

  final VoidCallback onTapNotiSwitch;
  final VoidCallback onTapRangeDateSwitch;

  final ValueChanged<DateTime> onDaySelected;
  final ValueChanged<RangeDateModel> onRangeSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "디데이 설정",
            style: context.textTheme.titleSmall,
          ),
        ),
        const SizedBox(height: 24.0),
        SwitchListTile.adaptive(
          value: rangeSelection,
          visualDensity: VisualDensity.compact,
          activeColor: context.colorTheme.onPrimary,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          onChanged: (_) => onTapRangeDateSwitch(),
          title: Text(
            "기간 설정",
            style: context.textTheme.labelLarge,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              "기간 설정을 활성화할 경우, 시작일과 종료일을 설정할 수 있습니다.",
              style: context.textTheme.bodyMedium!.copyWith(
                color: context.colorTheme.onSurface,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: rangeSelection
              ? RangeDateCalendar(
                  rangeDate: rangeDate!,
                  onRangeSelected: onRangeSelected,
                  selectedDate: selectedDay,
                )
              : PointDateCalendar(
                  selectedDay: selectedDay,
                  onDaySelected: onDaySelected,
                ),
        ),
      ],
    );
  }
}
