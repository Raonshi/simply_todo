// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_payload_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationPayloadModelCWProxy {
  NotificationPayloadModel id(int id);

  NotificationPayloadModel title(String title);

  NotificationPayloadModel content(String content);

  NotificationPayloadModel scheduledDate(DateTime scheduledDate);

  NotificationPayloadModel dueDate(DateTime dueDate);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationPayloadModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationPayloadModel(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationPayloadModel call({
    int id,
    String title,
    String content,
    DateTime scheduledDate,
    DateTime dueDate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationPayloadModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationPayloadModel.copyWith.fieldName(...)`
class _$NotificationPayloadModelCWProxyImpl
    implements _$NotificationPayloadModelCWProxy {
  const _$NotificationPayloadModelCWProxyImpl(this._value);

  final NotificationPayloadModel _value;

  @override
  NotificationPayloadModel id(int id) => this(id: id);

  @override
  NotificationPayloadModel title(String title) => this(title: title);

  @override
  NotificationPayloadModel content(String content) => this(content: content);

  @override
  NotificationPayloadModel scheduledDate(DateTime scheduledDate) =>
      this(scheduledDate: scheduledDate);

  @override
  NotificationPayloadModel dueDate(DateTime dueDate) => this(dueDate: dueDate);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationPayloadModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationPayloadModel(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationPayloadModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? content = const $CopyWithPlaceholder(),
    Object? scheduledDate = const $CopyWithPlaceholder(),
    Object? dueDate = const $CopyWithPlaceholder(),
  }) {
    return NotificationPayloadModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as String,
      scheduledDate: scheduledDate == const $CopyWithPlaceholder()
          ? _value.scheduledDate
          // ignore: cast_nullable_to_non_nullable
          : scheduledDate as DateTime,
      dueDate: dueDate == const $CopyWithPlaceholder()
          ? _value.dueDate
          // ignore: cast_nullable_to_non_nullable
          : dueDate as DateTime,
    );
  }
}

extension $NotificationPayloadModelCopyWith on NotificationPayloadModel {
  /// Returns a callable class that can be used as follows: `instanceOfNotificationPayloadModel.copyWith(...)` or like so:`instanceOfNotificationPayloadModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationPayloadModelCWProxy get copyWith =>
      _$NotificationPayloadModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPayloadModel _$NotificationPayloadModelFromJson(
        Map<String, dynamic> json) =>
    NotificationPayloadModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      scheduledDate: DateTime.parse(json['scheduledDate'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
    );

Map<String, dynamic> _$NotificationPayloadModelToJson(
        NotificationPayloadModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'scheduledDate': instance.scheduledDate.toIso8601String(),
      'dueDate': instance.dueDate.toIso8601String(),
    };
