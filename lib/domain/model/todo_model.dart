import 'package:simpletodo/domain/model/base_model.dart';

final class Todo extends BaseData {
  final int id;
  final String title;
  final String content;

  final DateTime? dueDate;
  final bool showNotification;

  final bool completed;

  const Todo._({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.content,
    required this.completed,
    required this.showNotification,
  });

  /// Create a new Todo instance.
  /// [id] is the timestamp in days.
  factory Todo.create({
    required String title,
    required String content,
    required DateTime? dueDate,
    required bool showNotification,
  }) {
    // dueDate should be converted to timestamp
    late final int timestamp;
    if (showNotification && dueDate != null) {
      timestamp = dueDate.millisecondsSinceEpoch;
    } else {
      timestamp = DateTime.now().millisecondsSinceEpoch;
    }

    // id is the timestamp in seconds
    final int id = timestamp ~/ 1000;

    return Todo._(
        id: id,
        title: title,
        content: content,
        dueDate: dueDate,
        completed: false,
        showNotification: showNotification);
  }

  /// Copy current Todo instance with new values.
  /// `id` and `timestamp` are not copied.
  @override
  Todo copyWith({
    String? title,
    String? content,
    bool? completed,
    bool? showNotification,
  }) {
    return Todo._(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      dueDate: dueDate,
      completed: completed ?? this.completed,
      showNotification: showNotification ?? this.showNotification,
    );
  }

  factory Todo.fromJson(Map<String, dynamic> map) {
    return Todo._(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      dueDate: map['dueDate'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
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
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'completed': completed,
      'showNotification': showNotification,
    };
  }
}
