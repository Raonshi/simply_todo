import 'package:simpletodo/domain/model/base_model.dart';
import 'package:simpletodo/domain/model/range_date_model.dart';

final class TodoModel extends BaseModel {
  final int id;
  final String title;
  final String content;

  final DateTime dueDate;
  final RangeDateModel? rangeDate;

  final bool showNotification;

  final bool completed;

  const TodoModel._({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.content,
    required this.completed,
    required this.showNotification,
    required this.rangeDate,
  });

  /// Create a new Todo instance.
  /// [id] is the timestamp in days.
  factory TodoModel.create({
    required String title,
    required String content,
    required DateTime dueDate,
    required RangeDateModel? rangeDate,
    required bool showNotification,
  }) {
    // dueDate should be converted to timestamp
    final int timestamp = dueDate.millisecondsSinceEpoch;

    // id is the timestamp in seconds
    final int id = timestamp ~/ 1000;

    return TodoModel._(
      id: id,
      title: title,
      content: content,
      dueDate: dueDate,
      rangeDate: rangeDate,
      completed: false,
      showNotification: showNotification,
    );
  }

  /// Copy current Todo instance with new values.
  /// `id` and `timestamp` are not copied.
  @override
  TodoModel copyWith({
    String? title,
    String? content,
    bool? completed,
    bool? showNotification,
  }) {
    return TodoModel._(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      dueDate: dueDate,
      rangeDate: rangeDate,
      completed: completed ?? this.completed,
      showNotification: showNotification ?? this.showNotification,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> map) {
    return TodoModel._(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
      rangeDate: map['rangeDate'] != null
          ? RangeDateModel.fromJson(map['rangeDate'])
          : null,
      completed: map['completed'],
      showNotification: map['showNotification'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'rangeDate': rangeDate?.toMap(),
      'completed': completed,
      'showNotification': showNotification,
    };
  }
}
