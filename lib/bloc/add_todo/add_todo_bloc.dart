import 'package:bloc/bloc.dart';
import 'package:simpletodo/common/tools.dart';
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

  void toggleShowNotification() {
    final bool newValue = !state.showNotification;
    emit(
      state.copyWith(
        showNotification: newValue,
        dateTime: newValue ? DateTime.now() : null,
      ),
    );
  }

  @override
  void onChange(Change<AddTodoState> change) {
    lgr.d("CURRENT STATE : ${change.currentState.toString()}\n"
        "NEXT STATE : ${change.nextState.toString()}");
    super.onChange(change);
  }

  Future<void> createTodo() async {
    final Todo todo = Todo.create(
      title: state.title,
      content: state.content,
      dateTime: state.dateTime,
      showNotification: state.showNotification,
    );

    if (todo.showNotification && todo.dateTime != null) {
      await NotificationService().scheduleNotification(
        id: todo.id,
        title: todo.title,
        body: todo.content,
        dateTime: todo.dateTime!,
      );
    }

    await todoRepo.saveTodo(todo);
  }
}
