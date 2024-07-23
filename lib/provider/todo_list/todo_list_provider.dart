import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simpletodo/domain/model/todo_model.dart';

part 'todo_list_state.dart';

// If you have this...
class TodoListStateNotifier extends StateNotifier<TodoListState> {
  TodoListStateNotifier() : super(const TodoListInitial()) {
    _init();
  }

  void _init() async {

  }
}
