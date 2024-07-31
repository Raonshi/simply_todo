part of 'add_todo_bloc.dart';

class AddTodoState {
  /* Todo data states */
  final String title;
  final String content;
  final DateTime dueDate;
  final RangeDate? rangeDate;
  final bool showNotification;

  /* UI States */
  final bool visibleScrollArrow;
  final bool rangeSelection;

  const AddTodoState({
    this.title = "",
    this.content = "",
    required this.dueDate,
    this.rangeDate,
    this.showNotification = false,
    this.visibleScrollArrow = true,
    this.rangeSelection = false,
  });

  AddTodoState copyWith({
    String? title,
    String? content,
    DateTime? dueDate,
    bool? showNotification,
    bool? visibleScrollArrow,
    RangeDate? rangeDate,
    bool? rangeSelection,
  }) {
    return AddTodoState(
      title: title ?? this.title,
      content: content ?? this.content,
      dueDate: dueDate ?? this.dueDate,
      rangeDate: rangeDate ?? this.rangeDate,
      showNotification: showNotification ?? this.showNotification,
      visibleScrollArrow: visibleScrollArrow ?? this.visibleScrollArrow,
      rangeSelection: rangeSelection ?? this.rangeSelection,
    );
  }

  AddTodoState removeRangeDate() {
    return AddTodoState(
      title: title,
      content: content,
      dueDate: DateTime.now(),
      rangeDate: null,
      showNotification: showNotification,
      visibleScrollArrow: visibleScrollArrow,
      rangeSelection: false,
    );
  }

  @override
  String toString() {
    return "AddTodoState{title: $title, content: $content, dueDate: $dueDate, rangeDate: ${rangeDate.toString()}, showNotification: $showNotification, visibleScrollArrow: $visibleScrollArrow, rangeSelection: $rangeSelection}";
  }
}
