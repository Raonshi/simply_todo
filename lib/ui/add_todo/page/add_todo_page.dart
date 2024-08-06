import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:simpletodo/bloc/add_todo/add_todo_bloc.dart';
import 'package:simpletodo/common/exception.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:simpletodo/common/tools.dart';
import 'package:simpletodo/domain/repository/todo/todo_repository_impl.dart';
import 'package:simpletodo/ui/add_todo/widget/add_todo_schedule_panel.dart';
import 'package:simpletodo/ui/global_widget/common_snackbar.dart';

import '../widget/add_todo_app_bar.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepositoryImpl(),
      child: BlocProvider(
        lazy: false,
        create: (context) => AddTodoBloc(
          todoRepo: RepositoryProvider.of<TodoRepositoryImpl>(context),
        ),
        child: _AddTodoPageBody(
          formKey: GlobalKey<FormState>(),
        ),
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AddTodoAppBar(
          context: context,
          onTapAdd: () {
            if (formKey.currentState?.validate() ?? false) {
              context.loaderOverlay.show();
              context.read<AddTodoBloc>().createTodo().then((_) {
                context.loaderOverlay.hide();
                Navigator.of(context).pop();
              }).catchError((err) {
                lgr.e(err, stackTrace: err.stackTrace);
                final String errMsg = switch (err) {
                  CustomException exception => exception.message,
                  _ => "알 수 없는 오류가 발생했습니다.",
                };

                context.loaderOverlay.hide();
                showErrorSnackbar(context: context, msg: errMsg);
              });
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            cursorColor: context.colorTheme.onPrimary,
                            maxLength: 50,
                            decoration: InputDecoration(
                              labelText: "제목",
                              labelStyle:
                                  context.textTheme.titleSmall?.copyWith(
                                color: context.colorTheme.onPrimary,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: context.colorTheme.onPrimary,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: context.read<AddTodoBloc>().setTitle,
                            validator: (String? value) {
                              if ((value ?? "").isEmpty) {
                                return "제목을 입력해주세요.";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 24.0),

                        // Content
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            cursorColor: context.colorTheme.onPrimary,
                            minLines: 10,
                            maxLines: 10,
                            decoration: InputDecoration(
                              labelText: "내용",
                              labelStyle:
                                  context.textTheme.titleSmall?.copyWith(
                                color: context.colorTheme.onPrimary,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: context.colorTheme.onPrimary,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            onChanged: context.read<AddTodoBloc>().setContent,
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        Divider(
                          height: 4.0,
                          thickness: 4.0,
                          color: context.colorTheme.onSurface.withOpacity(0.08),
                        ),

                        // Notification Switch
                        SwitchListTile.adaptive(
                          value: state.showNotification,
                          visualDensity: VisualDensity.compact,
                          activeColor: context.colorTheme.onPrimary,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          onChanged: (_) => context
                              .read<AddTodoBloc>()
                              .toggleShowNotification(),
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
                        ),

                        Divider(
                          height: 4.0,
                          thickness: 4.0,
                          color: context.colorTheme.onSurface.withOpacity(0.08),
                        ),
                        const SizedBox(height: 24.0),

                        // Calendar
                        AddTodoSchedulePanel(
                          showNotification: state.showNotification,
                          onTapNotiSwitch: context
                              .read<AddTodoBloc>()
                              .toggleShowNotification,
                          onDaySelected:
                              context.read<AddTodoBloc>().setDateTime,
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
      ),
    );
  }
}
