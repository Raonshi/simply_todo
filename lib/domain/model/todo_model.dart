import 'package:simpletodo/domain/model/base_model.dart';

final class Todo extends BaseData {
  final int id;
  final String title;
  final String content;

  final bool completed;

  const Todo({
    required this.id,
    required this.title,
    required this.content,
    this.completed = false,
  });

  @override
  Todo copyWith({
    int? id,
    String? title,
    String? content,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      completed: completed ?? this.completed,
    );
  }

  factory Todo.fromJson(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      completed: map['deleted'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'deleted': completed,
    };
  }
}
