import 'package:bloc/bloc.dart';
import 'package:simpletodo/repository/todo_repository.dart';
import 'package:simpletodo/services/notification_service.dart';

import '../../../model/notification_payload_model.dart';
import '../../../model/todo_model.dart';

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
      final List<TodoModel> todos = await todoRepo.getTodoList();
      emit(TodoListLoaded(todos));
    } catch (e) {
      emit(TodoListError(e as Exception));
    }
  }

  void toggleCheckbox(int id) async {
    switch (state) {
      case TodoListLoaded loaded:
        final List<TodoModel> newTodos = loaded.todos.toList();
        final int index = newTodos.indexWhere((element) => element.id == id);
        if (index == 0 - 1) return;

        final bool newValue = !newTodos[index].completed;
        final TodoModel newTodo = newTodos[index].copyWith(
          completed: newValue,
          showNotification: newValue ? false : true,
        );
        newTodos[index] = newTodo;

        if (!newTodo.completed && newTodo.showNotification) {
          await NotificationService().scheduleNotification(
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
        final List<TodoModel> newTodos = loaded.todos.toList();
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
