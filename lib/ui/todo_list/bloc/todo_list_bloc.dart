import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplytodo/core/repository/notification_repository.dart';
import 'package:simplytodo/repository/todo_repository.dart';
import 'package:simplytodo/core/service/notification_service.dart';

import '../../../model/notification_payload_model.dart';
import '../../../model/todo_model.dart';

part 'todo_list_state.dart';
part 'todo_list_bloc.g.dart';

class TodoListBloc extends Cubit<TodoListState> {
  final TodoRepository _todoRepo;
  final NotificationRepository _notiRepo;

  TodoListBloc({
    required TodoRepository todoRepo,
    required NotificationRepository notiRepo,
  })  : _todoRepo = todoRepo,
        _notiRepo = notiRepo,
        super(const TodoListState()) {
    _init();
  }

  void _init() => _todoRepo.getTodoList().then((todos) {
        emit(state.copyWith(todos: todos.toList()));
      });

  void toggleCheckbox(int id) async {
    final List<TodoModel> newTodos = state.todos.toList();
    final int index = newTodos.indexWhere((element) => element.id == id);
    if (index == -1) return;

    final bool newValue = !newTodos[index].completed;
    final TodoModel newTodo = newTodos[index].copyWith(
      completed: newValue,
      showNotification: newValue ? false : true,
    );
    await _todoRepo.updateTodo(newTodo);

    newTodos[index] = newTodo;

    if (!newTodo.completed && newTodo.showNotification) {
      _notiRepo.scheduleNotification(
        NotificationPayloadModel.create(
          title: newTodo.title,
          content: newTodo.content,
          scheduledDate: DateTime.now(),
          dueDate: newTodo.rangeDate?.end ?? newTodo.dueDate,
        ),
      );
    } else {
      await NotificationService().cancelScheduledNotification(id);
    }

    emit(state.copyWith(todos: newTodos));
  }

  void deleteTodo(int id) async {
    _notiRepo.cancelScheduledNotification(id);

    await _todoRepo.deleteTodo(id);

    final List<TodoModel> newTodos =
        await _todoRepo.getTodoList().then((res) => res.toList());
    emit(state.copyWith(todos: newTodos));
  }

  void refresh() {
    _init();
  }
}
