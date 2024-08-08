import 'package:simpletodo/common/tools.dart';
import 'package:simpletodo/domain/model/base_model.dart';

class NotificationPayloadModel extends BaseModel {
  final int id;
  final String title;
  final String content;

  final DateTime scheduledDate;
  final DateTime dueDate;

  const NotificationPayloadModel._({
    required this.id,
    required this.title,
    required this.content,
    required this.scheduledDate,
    required this.dueDate,
  });

  factory NotificationPayloadModel.create({
    required String title,
    required String content,
    required DateTime scheduledDate,
    required DateTime dueDate,
  }) {
    return NotificationPayloadModel._(
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

  factory NotificationPayloadModel.fromJson(Map<String, dynamic> json) {
    return NotificationPayloadModel._(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      scheduledDate: DateTime.fromMillisecondsSinceEpoch(json["scheduledDate"]),
      dueDate: DateTime.fromMillisecondsSinceEpoch(json["dueDate"]),
    );
  }

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "content": content,
        "scheduledDate": scheduledDate.millisecondsSinceEpoch,
        "dueDate": dueDate.millisecondsSinceEpoch,
      };

  @override
  NotificationPayloadModel copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? scheduledDate,
    DateTime? dueDate,
  }) {
    return NotificationPayloadModel._(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
