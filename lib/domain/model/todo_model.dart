import 'package:simpletodo/domain/model/base_model.dart';

final class Todo extends BaseData {
  final int id;
  final String title;
  final String content;

  final int timestamp;
  final bool showNotification;

  final bool completed;

  const Todo._({
    required this.id,
    required this.title,
    required this.timestamp,
    required this.content,
    required this.completed,
    required this.showNotification,
  });

  /// Create a new Todo instance.
  /// [id] is the timestamp in days.
  factory Todo.create({
    required String title,
    required String content,
    required DateTime? dateTime,
    required bool showNotification,
  }) {
    // dateTime should be converted to timestamp
    late final int timestamp;
    if (showNotification && dateTime != null) {
      timestamp = dateTime.millisecondsSinceEpoch;
    } else {
      timestamp = DateTime.now().millisecondsSinceEpoch;
    }

    // id is the timestamp in days
    final int id = timestamp ~/ (1000 * 60 * 60 * 24);

    return Todo._(
        id: id,
        title: title,
        content: content,
        timestamp: timestamp,
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
  }) {
    return Todo._(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      timestamp: timestamp,
      completed: completed ?? this.completed,
      showNotification: showNotification,
    );
  }

  factory Todo.fromJson(Map<String, dynamic> map) {
    return Todo._(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      timestamp: map['timestamp'],
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
      'timestamp': timestamp,
      'completed': completed,
      'showNotification': showNotification,
    };
  }
}
