import 'package:bloc/bloc.dart';
import 'package:simpletodo/domain/model/todo_model.dart';
import 'package:simpletodo/domain/repository/todo/todo_repository.dart';
import 'package:simpletodo/service/notification_service.dart';

part 'add_todo_state.dart';

class AddTodoBloc extends Cubit<AddTodoState> {
  final TodoRepository todoRepo;

  AddTodoBloc({
    required this.todoRepo,
  }) : super(const AddTodoState());

  void setTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void setContent(String content) {
    emit(state.copyWith(content: content));
  }

  void setDateTime(DateTime dateTime) {
    emit(state.copyWith(dateTime: dateTime));
  }

  void setShowNotification(bool showNotification) {
    emit(
      state.copyWith(
        showNotification: showNotification,
        dateTime: showNotification ? DateTime.now() : null,
      ),
    );
  }

  Future<void> createTodo() async {
    final Todo todo = Todo.create(
      title: state.title,
      content: state.content,
      dateTime: state.dateTime,
      showNotification: state.showNotification,
    );

    await NotificationService().scheduleNotification(
      id: todo.id,
      title: todo.title,
      body: todo.content,
      timestamp: todo.timestamp,
    );

    await todoRepo.saveTodo(todo);
  }
}
