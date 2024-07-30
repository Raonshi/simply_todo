part of 'add_todo_bloc.dart';

class AddTodoState {
  final String title;
  final String content;
  final DateTime? dateTime;
  final bool showNotification;
  final bool visibleScrollArrow;

  const AddTodoState({
    this.title = "",
    this.content = "",
    this.dateTime,
    this.showNotification = true,
    this.visibleScrollArrow = true,
  });

  AddTodoState copyWith({
    String? title,
    String? content,
    DateTime? dateTime,
    bool? showNotification,
    bool? visibleScrollArrow,
  }) {
    return AddTodoState(
      title: title ?? this.title,
      content: content ?? this.content,
      dateTime: dateTime ?? this.dateTime,
      showNotification: showNotification ?? this.showNotification,
      visibleScrollArrow: visibleScrollArrow ?? this.visibleScrollArrow,
    );
  }

  @override
  String toString() {
    return 'AddTodoState{title: $title, content: $content, dateTime: $dateTime, showNotification: $showNotification, visibleScrollArrow: $visibleScrollArrow}';
  }
}
