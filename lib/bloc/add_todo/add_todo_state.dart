part of 'add_todo_bloc.dart';

class AddTodoState {
  final String title;
  final String content;
  final DateTime? dueDate;
  final bool showNotification;
  final bool visibleScrollArrow;

  const AddTodoState({
    this.title = "",
    this.content = "",
    this.dueDate,
    this.showNotification = true,
    this.visibleScrollArrow = true,
  });

  AddTodoState copyWith({
    String? title,
    String? content,
    DateTime? dueDate,
    bool? showNotification,
    bool? visibleScrollArrow,
  }) {
    return AddTodoState(
      title: title ?? this.title,
      content: content ?? this.content,
      dueDate: dueDate ?? this.dueDate,
      showNotification: showNotification ?? this.showNotification,
      visibleScrollArrow: visibleScrollArrow ?? this.visibleScrollArrow,
    );
  }

  @override
  String toString() {
    return 'AddTodoState{title: $title, content: $content, dueDate: $dueDate, showNotification: $showNotification, visibleScrollArrow: $visibleScrollArrow}';
  }
}
