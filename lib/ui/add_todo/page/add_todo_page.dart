import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpletodo/bloc/add_todo/add_todo_bloc.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:simpletodo/domain/repository/todo/todo_repository.dart';
import 'package:table_calendar/table_calendar.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepository(),
      child: BlocProvider(
        lazy: false,
        create: (context) => AddTodoBloc(
          todoRepo: RepositoryProvider.of<TodoRepository>(context),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: BlocBuilder<AddTodoBloc, AddTodoState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "일정 추가",
                      style: context.textTheme.titleSmall,
                    ),
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
                    const SizedBox(height: 12.0),
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
                    const SizedBox(height: 12.0),
                    TableCalendar(
                      focusedDay: DateTime.now(),
                      firstDay:
                          DateTime.now().subtract(const Duration(days: 365)),
                      lastDay: DateTime.now().add(const Duration(days: 365)),
                    ),
                    const SizedBox(height: 12.0),
                    SwitchListTile.adaptive(
                      value: true,
                      onChanged: (_) {},
                      title: Text(
                        "알림 설정",
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<AddTodoBloc>().createTodo();
                        }
                      },
                      child: Container(
                        color: context.colorTheme.onPrimary,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                        child: SafeArea(
                          child: Text(
                            "일정 추가",
                            style: context.textTheme.titleSmall?.copyWith(
                              color: context.colorTheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
