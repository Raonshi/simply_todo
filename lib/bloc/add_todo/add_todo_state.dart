part of 'add_todo_bloc.dart';

class AddTodoState {
  final String title;
  final String content;
  final DateTime? dateTime;
  final bool showNotification;

  const AddTodoState({
    this.title = "",
    this.content = "",
    this.dateTime,
    this.showNotification = true,
  });

  AddTodoState copyWith({
    String? title,
    String? content,
    DateTime? dateTime,
    bool? showNotification,
  }) {
    return AddTodoState(
      title: title ?? this.title,
      content: content ?? this.content,
      dateTime: dateTime ?? this.dateTime,
      showNotification: showNotification ?? this.showNotification,
    );
  }
}
