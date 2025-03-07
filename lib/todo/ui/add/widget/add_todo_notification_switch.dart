import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplytodo/common/theme.dart';
import 'package:simplytodo/todo/ui/add/bloc/add_todo_bloc.dart';

class AddTodoNotificationSwitch extends StatelessWidget {
  const AddTodoNotificationSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddTodoBloc, AddTodoState, bool>(
      selector: (state) => state.showNotification,
      builder: (context, showNotification) {
        return SwitchListTile.adaptive(
          value: showNotification,
          visualDensity: VisualDensity.compact,
          activeColor: context.colorTheme.onPrimary,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 8.0,
          ),
          onChanged: (_) =>
              context.read<AddTodoBloc>().toggleShowNotification(),
          title: Text(
            "알림 설정",
            style: context.textTheme.titleSmall,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              "알림은 선택한 날짜의 09:00 AM에 발송됩니다.",
              style: context.textTheme.bodyMedium!.copyWith(
                color: context.colorTheme.onSurface,
              ),
            ),
          ),
        );
      },
    );
  }
}
