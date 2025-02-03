import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simpletodo/common/tools.dart';

import 'range_date_model.dart';

part 'todo_model.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith(copyWithNull: true)
final class TodoModel {
  final int id;
  final String title;
  final String content;

  final DateTime dueDate;
  final RangeDateModel? rangeDate;

  final bool showNotification;

  final bool completed;

  const TodoModel({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.content,
    required this.completed,
    required this.showNotification,
    required this.rangeDate,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);

  /// Create a new Todo instance.
  /// [id] is the timestamp in days.
  factory TodoModel.create({
    required String title,
    required String content,
    required DateTime dueDate,
    required RangeDateModel? rangeDate,
    required bool showNotification,
  }) {
    return TodoModel(
      id: uuid.v4().hashCode,
      title: title,
      content: content,
      dueDate: dueDate,
      rangeDate: rangeDate,
      completed: false,
      showNotification: showNotification,
    );
  }
}
