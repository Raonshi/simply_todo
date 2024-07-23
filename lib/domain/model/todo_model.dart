import 'package:simpletodo/domain/model/base_model.dart';

final class Todo extends BaseData {
  final String id;
  final String title;
  final String content;

  final bool deleted;

  const Todo({
    required this.id,
    required this.title,
    required this.content,
    required this.deleted,
  });

  @override
  Todo copyWith({
    String? id,
    String? title,
    String? content,
    bool? deleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      deleted: deleted ?? this.deleted,
    );
  }

  @override
  Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      deleted: map['deleted'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'deleted': deleted,
    };
  }
}
