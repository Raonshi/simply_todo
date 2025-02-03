import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simpletodo/common/tools.dart';

part 'notification_payload_model.g.dart';

@JsonSerializable()
@CopyWith(copyWithNull: true)
final class NotificationPayloadModel {
  final int id;
  final String title;
  final String content;

  final DateTime scheduledDate;
  final DateTime dueDate;

  const NotificationPayloadModel({
    required this.id,
    required this.title,
    required this.content,
    required this.scheduledDate,
    required this.dueDate,
  });

  factory NotificationPayloadModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationPayloadModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPayloadModelToJson(this);

  factory NotificationPayloadModel.create({
    required String title,
    required String content,
    required DateTime scheduledDate,
    required DateTime dueDate,
  }) {
    return NotificationPayloadModel(
      id: uuid.v4().hashCode,
      title: title,
      content: content,
      scheduledDate: DateTime(
        scheduledDate.year,
        scheduledDate.month,
        scheduledDate.day,
        9,
      ),
      dueDate: DateTime(
        dueDate.year,
        dueDate.month,
        dueDate.day,
        9,
      ),
    );
  }
}
