import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpletodo/bloc/todo_list/todo_list_bloc.dart';
import 'package:simpletodo/domain/repository/todo/todo_repository_impl.dart';
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
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Simple Todo",
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
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
          TodoListError error => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.red, width: 1.0),
              ),
              child: Text(error.exception.toString()),
            ),
          // ignore: unreachable_switch_case
          _ => Container(),
        },
      ),
    );
  }
}
