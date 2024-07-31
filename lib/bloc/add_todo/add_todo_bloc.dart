import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:simpletodo/common/exception.dart';
import 'package:simpletodo/domain/model/range_date_model.dart';
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

  void toggleSwitchRangeDate() {
    final bool newValue = !state.rangeSelection;
    emit(state.copyWith(
      rangeSelection: newValue,
      rangeDate: newValue ? RangeDate.create() : null,
    ));
  }

  void setRangeDate(RangeDate rangeDate) {
    final RangeDate newRangeDate = RangeDate(
      start: rangeDate.start,
      end: rangeDate.end,
    );
    emit(state.copyWith(rangeDate: newRangeDate, dueDate: newRangeDate.start));
  }

  Future<void> createTodo() async {
    if (state.rangeSelection && state.rangeDate == null) {
      throw CustomException("일정 기간을 설정해주세요!");
    }

    final Todo todo = Todo.create(
      title: state.title,
      content: state.content,
      dueDate: state.dueDate,
      rangeDate: state.rangeDate,
      showNotification: state.showNotification,
    );

    if (todo.showNotification) {
      await NotificationService().scheduleNotification(
        id: todo.id,
        title: todo.title,
        body: todo.content,
        dueDate: state.rangeSelection
            ? todo.rangeDate!.start ?? todo.dueDate
            : todo.dueDate,
      );
    }

    await todoRepo.saveTodo(todo);
  }
}
