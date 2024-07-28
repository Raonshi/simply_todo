import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:simpletodo/bloc/add_todo/add_todo_bloc.dart';
import 'package:simpletodo/common/exception.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:simpletodo/domain/repository/todo/todo_repository_impl.dart';
import 'package:simpletodo/ui/add_todo/widget/add_todo_schedule_panel.dart';
import 'package:simpletodo/ui/global_widget/common_snackbar.dart';

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "할 일 추가",
            style: context.textTheme.titleLarge,
          ),
          actions: [
            IconButton(
              iconSize: 32.0,
              icon: const Icon(Icons.check, size: 24.0),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  context.loaderOverlay.show();
                  context.read<AddTodoBloc>().createTodo().then((_) {
                    context.loaderOverlay.hide();
                    Navigator.of(context).pop();
                  }).catchError((err) {
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
            const SizedBox(width: 12.0),
          ],
        ),
        body: BlocBuilder<AddTodoBloc, AddTodoState>(
          builder: (context, state) {
            return SingleChildScrollView(
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
                          labelStyle: context.textTheme.labelLarge?.copyWith(
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
                          labelStyle: context.textTheme.labelLarge?.copyWith(
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
                    const SizedBox(height: 12.0),

                    // Notification / Date
                    AddTodoSchedulePanel(
                      showNotification: state.showNotification,
                      onTapNotiSwitch:
                          context.read<AddTodoBloc>().toggleShowNotification,
                      onDaySelected: context.read<AddTodoBloc>().setDateTime,
                      selectedDay: state.dateTime,
                    ),

                    const SizedBox(height: 64.0),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
