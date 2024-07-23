import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simpletodo/provider/todo_list/todo_list_provider.dart';

final todoListProvider =
    StateNotifierProvider<TodoListStateNotifier, TodoListState>((ref) {
  return TodoListStateNotifier();
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListState = ref.watch(todoListProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Simple Todo"),
      ),
      body: switch (todoListState) {
        TodoListInitial _ => Container(),
        TodoListLoading _ => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        TodoListLoaded loaded => ListView.builder(
            itemCount: loaded.todos.length,
            itemBuilder: (context, index) {
              return const Text("asdfasd");
            }),
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
    );
  }
}
