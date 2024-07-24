import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpletodo/bloc/todo_list/todo_list_bloc.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:simpletodo/domain/repository/todo/todo_repository_impl.dart';
import 'package:simpletodo/ui/widget/add_todo_bottom_sheet.dart';
import 'package:simpletodo/ui/widget/todo_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepositoryImpl(),
      child: BlocProvider(
        lazy: false,
        create: (context) => TodoListBloc(
          todoRepo: RepositoryProvider.of<TodoRepositoryImpl>(context),
        ),
        child: const _HomePageBody(),
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "심플리투두",
          style: context.textTheme.displayMedium,
        ),
      ),
      body: BlocBuilder<TodoListBloc, TodoListState>(
        builder: (context, state) => switch (state) {
          TodoListInitial _ => Container(),
          TodoListLoading _ => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          TodoListLoaded loaded => TodoList(
              todos: loaded.todos,
            ),
          TodoListError error => Center(
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorTheme.error,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 12.0),
                child: Text(
                  error.exception.toString(),
                  style: context.textTheme.labelLarge?.copyWith(
                    color: context.colorTheme.onError,
                  ),
                ),
              ),
            ),
          // ignore: unreachable_switch_case
          _ => Container(),
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorTheme.onPrimary,
                  foregroundColor: context.colorTheme.primary,
                  textStyle: context.textTheme.titleSmall?.copyWith(
                    color: context.colorTheme.primary,
                  ),
                ),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  showDragHandle: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.0),
                    ),
                  ),
                  builder: (subContext) => const AddTodoBottomSheet(),
                ).then((value) {
                  if (value == null) return;
                  context.read<TodoListBloc>().create(value);
                }),
                child: const Text("일정 추가"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
