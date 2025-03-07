import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:simplytodo/core/repository/notification_repository.dart';
import 'package:simplytodo/todo/ui/add/bloc/add_todo_bloc.dart';
import 'package:simplytodo/common/exception.dart';
import 'package:simplytodo/common/theme.dart';
import 'package:simplytodo/repository/todo_repository.dart';
import 'package:simplytodo/todo/ui/add/widget/add_todo_content_field.dart';
import 'package:simplytodo/todo/ui/add/widget/add_todo_notification_switch.dart';
import 'package:simplytodo/todo/ui/add/widget/add_todo_schedule_panel.dart';
import 'package:simplytodo/todo/ui/add/widget/add_todo_title_field.dart';
import 'package:simplytodo/ui/global_widget/common_snackbar.dart';

import 'add_todo_app_bar.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => AddTodoBloc(
        todoRepo: context.read<TodoRepository>(),
        notiRepo: context.read<NotificationRepository>(),
      ),
      child: _AddTodoPageBody(
        formKey: GlobalKey<FormState>(),
      ),
    );
  }
}

class _AddTodoPageBody extends StatelessWidget {
  const _AddTodoPageBody({required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      final bool dismissArrow =
          scrollController.position.pixels <= 0 ? false : true;
      context.read<AddTodoBloc>().setVisibleScrollArrow(dismissArrow);
    });

    return Scaffold(
      appBar: AddTodoAppBar(
        context: context,
        onTapAdd: () {
          if (formKey.currentState?.validate() ?? false) {
            context.loaderOverlay.show();
            context.read<AddTodoBloc>().createTodo().then((_) {
              context.loaderOverlay.hide();
              context.pop();
            }).catchError((err) {
              final String errMsg = switch (err) {
                CustomException exception => exception.message,
                _ => "알 수 없는 오류가 발생했습니다.",
              };

              context.loaderOverlay.hide();
              showErrorSnackbar(context: context, msg: errMsg);
            });
          } else {
            showErrorSnackbar(context: context, msg: "제목을 입력해주세요!");
          }
        },
      ),
      body: BlocBuilder<AddTodoBloc, AddTodoState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      AddTodoTitleField(),
                      const SizedBox(height: 24.0),

                      // Content
                      AddTodoContentField(),
                      const SizedBox(height: 24.0),
                      Divider(
                        height: 4.0,
                        thickness: 4.0,
                        color: context.colorTheme.onSurface
                            .withValues(alpha: 0.08),
                      ),

                      // Notification Switch
                      AddTodoNotificationSwitch(),

                      Divider(
                        height: 4.0,
                        thickness: 4.0,
                        color: context.colorTheme.onSurface
                            .withValues(alpha: 0.08),
                      ),
                      const SizedBox(height: 24.0),

                      // Calendar
                      AddTodoSchedulePanel(
                        showNotification: state.showNotification,
                        onTapNotiSwitch:
                            context.read<AddTodoBloc>().toggleShowNotification,
                        onDaySelected: context.read<AddTodoBloc>().setDateTime,
                        selectedDay: state.dueDate,
                        rangeDate: state.rangeDate,
                        rangeSelection: state.rangeSelection,
                        onTapRangeDateSwitch:
                            context.read<AddTodoBloc>().toggleSwitchRangeDate,
                        onRangeSelected:
                            context.read<AddTodoBloc>().setRangeDate,
                      ),

                      const SizedBox(height: 64.0),
                    ],
                  ),
                ),
              ),
              if (state.visibleScrollArrow)
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.2, 1.0],
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.5),
                        Colors.white,
                      ],
                    ),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: InkWell(
                    onTap: () => scrollController.animateTo(
                      MediaQuery.of(context).size.height,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    ),
                    child: Icon(FontAwesomeIcons.chevronDown,
                        color: context.colorTheme.onSurface, size: 20.0),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
