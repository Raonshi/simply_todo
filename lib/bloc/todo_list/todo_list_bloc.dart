// ignore_for_file: unnecessary_null_comparison

import 'package:simpletodo/domain/model/todo_model.dart';
import 'package:bloc/bloc.dart';
import 'package:simpletodo/domain/repository/todo/todo_repository.dart';
import 'package:simpletodo/service/notification_service.dart';

part 'todo_list_state.dart';

class TodoListBloc extends Cubit<TodoListState> {
  final TodoRepository todoRepo;

  TodoListBloc({
    required this.todoRepo,
  }) : super(const TodoListInitial()) {
    _init();
  }

  void _init() async {
    emit(const TodoListLoading());
    try {
      final List<Todo> todos = await todoRepo.getTodoList();
      emit(TodoListLoaded(todos));
    } catch (e) {
      emit(TodoListError(e as Exception));
    }
  }

  void toggleCheckbox(int id) async {
    switch (state) {
      case TodoListLoaded loaded:
        final List<Todo> newTodos = loaded.todos.toList();
        final int index = newTodos.indexWhere((element) => element.id == id);
        if (index == 0 - 1) return;

        final bool newValue = !newTodos[index].completed;
        final Todo newTodo = newTodos[index].copyWith(
          completed: newValue,
          showNotification: newValue
              ? false
              : newTodos[index].dueDate != null
                  ? true
                  : false,
        );
        newTodos[index] = newTodo;

        if (newTodo.dueDate != null &&
            !newTodo.completed &&
            newTodo.showNotification) {
          await NotificationService().scheduleNotification(
            id: id,
            title: newTodos[index].title,
            body: newTodos[index].content,
            dueDate: newTodos[index].dueDate,
          );
        } else {
          await NotificationService().cancelScheduledNotification(id);
        }

        emit(loaded.copyWith(todos: newTodos));
        await todoRepo.saveTodoList(newTodos);
        break;
      default:
        break;
    }
  }

  void deleteTodo(int id) async {
    switch (state) {
      case TodoListLoaded loaded:
        final List<Todo> newTodos = loaded.todos.toList();
        final int index = newTodos.indexWhere((element) => element.id == id);
        if (index == 0 - 1) return;

        await NotificationService().cancelScheduledNotification(id);
        newTodos.removeAt(index);
        emit(loaded.copyWith(todos: newTodos));
        await todoRepo.saveTodoList(newTodos);
        break;
      default:
        break;
    }
  }

  void refresh() {
    _init();
  }
}
