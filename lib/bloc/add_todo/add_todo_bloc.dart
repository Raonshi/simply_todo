import 'package:bloc/bloc.dart';
import 'package:simpletodo/common/exception.dart';
import 'package:simpletodo/common/tools.dart';
import 'package:simpletodo/domain/model/notification_payload_model.dart';
import 'package:simpletodo/domain/model/range_date_model.dart';
import 'package:simpletodo/domain/model/tag_model.dart';
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
      rangeDate: newValue ? RangeDateModel.create() : null,
    ));
  }

  void setRangeDate(RangeDateModel rangeDate) {
    final RangeDateModel newRangeDate = RangeDateModel(
      start: rangeDate.start,
      end: rangeDate.end,
    );
    emit(state.copyWith(rangeDate: newRangeDate, dueDate: newRangeDate.start));
  }

  void updateTempTagInput(String input) {
    emit(state.copyWith(tempTagInput: input));
  }

  void addTag() {
    if (state.tempTagInput == null) return;

    final List<TagModel> newTags = List<TagModel>.from(state.tags);
    newTags.add(TagModel.create(name: state.tempTagInput!));
    emit(state.copyWith(tags: newTags, tempTagInput: null));
  }

  void removeTag(int index) {
    final List<TagModel> newTags = List<TagModel>.from(state.tags);
    newTags.removeAt(index);
    emit(state.copyWith(tags: newTags));
  }

  Future<void> createTodo() async {
    if (state.rangeSelection &&
        (state.rangeDate?.start == null || state.rangeDate?.end == null)) {
      throw CustomException("일정 기간을 설정해주세요!");
    }

    final TodoModel todo = TodoModel.create(
      title: state.title,
      content: state.content,
      dueDate: state.dueDate,
      rangeDate: state.rangeDate,
      showNotification: state.showNotification,
    );

    if (todo.showNotification) {
      final DateTime todayNotiTime = DateTime(now.year, now.month, now.day);

      if (todo.dueDate.difference(todayNotiTime).inDays == 0) {
        throw CustomException("알림 설정을 선택한 경우, 오늘 이후 날짜로 설정해주세요!");
      }

      await NotificationService().scheduleNotification(
        NotificationPayloadModel.create(
          title: todo.title,
          content: todo.content,
          scheduledDate: state.rangeSelection
              ? (todo.rangeDate?.start ?? todo.dueDate)
              : todo.dueDate,
          dueDate: state.rangeSelection
              ? (todo.rangeDate?.end ?? todo.dueDate)
              : todo.dueDate,
        ),
      );
    }

    await todoRepo.saveTodo(todo);
  }
}
