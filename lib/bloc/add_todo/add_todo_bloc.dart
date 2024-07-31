import 'package:bloc/bloc.dart';
import 'package:simpletodo/common/exception.dart';
import 'package:simpletodo/common/tools.dart';
import 'package:simpletodo/domain/model/todo_model.dart';
import 'package:simpletodo/domain/repository/todo/todo_repository.dart';
import 'package:simpletodo/service/notification_service.dart';

part 'add_todo_state.dart';

class AddTodoBloc extends Cubit<AddTodoState> {
  final TodoRepository todoRepo;

  AddTodoBloc({
    required this.todoRepo,
  }) : super(AddTodoState(dueDate: DateTime.now()));

  void setVisibleScrollArrow(bool dismissable) {
    emit(state.copyWith(visibleScrollArrow: !dismissable));
  }

  void setTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void setContent(String content) {
    emit(state.copyWith(content: content));
  }

  void setDateTime(DateTime dueDate) {
    emit(state.copyWith(dueDate: dueDate));
  }

  void toggleShowNotification() {
    final bool newValue = !state.showNotification;
    emit(state.copyWith(showNotification: newValue));
  }

  @override
  void onChange(Change<AddTodoState> change) {
    lgr.d("CURRENT STATE : ${change.currentState.toString()}\n"
        "NEXT STATE : ${change.nextState.toString()}");
    super.onChange(change);
  }

  Future<void> createTodo() async {
    if (state.showNotification && state.dueDate == null) {
      throw CustomException("알림 날짜를 설정해주세요!");
    }

    final Todo todo = Todo.create(
      title: state.title,
      content: state.content,
      dueDate: state.dueDate,
      showNotification: state.showNotification,
    );

    if (todo.showNotification && todo.dueDate != null) {
      await NotificationService().scheduleNotification(
        id: todo.id,
        title: todo.title,
        body: todo.content,
        dueDate: todo.dueDate!,
      );
    }

    await todoRepo.saveTodo(todo);
  }
}
