// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TodoModelCWProxy {
  TodoModel id(int id);

  TodoModel title(String title);

  TodoModel dueDate(DateTime dueDate);

  TodoModel content(String content);

  TodoModel completed(bool completed);

  TodoModel showNotification(bool showNotification);

  TodoModel rangeDate(RangeDateModel? rangeDate);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TodoModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TodoModel(...).copyWith(id: 12, name: "My name")
  /// ````
  TodoModel call({
    int id,
    String title,
    DateTime dueDate,
    String content,
    bool completed,
    bool showNotification,
    RangeDateModel? rangeDate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTodoModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTodoModel.copyWith.fieldName(...)`
class _$TodoModelCWProxyImpl implements _$TodoModelCWProxy {
  const _$TodoModelCWProxyImpl(this._value);

  final TodoModel _value;

  @override
  TodoModel id(int id) => this(id: id);

  @override
  TodoModel title(String title) => this(title: title);

  @override
  TodoModel dueDate(DateTime dueDate) => this(dueDate: dueDate);

  @override
  TodoModel content(String content) => this(content: content);

  @override
  TodoModel completed(bool completed) => this(completed: completed);

  @override
  TodoModel showNotification(bool showNotification) =>
      this(showNotification: showNotification);

  @override
  TodoModel rangeDate(RangeDateModel? rangeDate) => this(rangeDate: rangeDate);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TodoModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TodoModel(...).copyWith(id: 12, name: "My name")
  /// ````
  TodoModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? dueDate = const $CopyWithPlaceholder(),
    Object? content = const $CopyWithPlaceholder(),
    Object? completed = const $CopyWithPlaceholder(),
    Object? showNotification = const $CopyWithPlaceholder(),
    Object? rangeDate = const $CopyWithPlaceholder(),
  }) {
    return TodoModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      dueDate: dueDate == const $CopyWithPlaceholder()
          ? _value.dueDate
          // ignore: cast_nullable_to_non_nullable
          : dueDate as DateTime,
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as String,
      completed: completed == const $CopyWithPlaceholder()
          ? _value.completed
          // ignore: cast_nullable_to_non_nullable
          : completed as bool,
      showNotification: showNotification == const $CopyWithPlaceholder()
          ? _value.showNotification
          // ignore: cast_nullable_to_non_nullable
          : showNotification as bool,
      rangeDate: rangeDate == const $CopyWithPlaceholder()
          ? _value.rangeDate
          // ignore: cast_nullable_to_non_nullable
          : rangeDate as RangeDateModel?,
    );
  }
}

extension $TodoModelCopyWith on TodoModel {
  /// Returns a callable class that can be used as follows: `instanceOfTodoModel.copyWith(...)` or like so:`instanceOfTodoModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TodoModelCWProxy get copyWith => _$TodoModelCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `TodoModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TodoModel(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  TodoModel copyWithNull({
    bool rangeDate = false,
  }) {
    return TodoModel(
      id: id,
      title: title,
      dueDate: dueDate,
      content: content,
      completed: completed,
      showNotification: showNotification,
      rangeDate: rangeDate == true ? null : this.rangeDate,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => TodoModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      content: json['content'] as String,
      completed: json['completed'] as bool,
      showNotification: json['showNotification'] as bool,
      rangeDate: json['rangeDate'] == null
          ? null
          : RangeDateModel.fromJson(json['rangeDate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'dueDate': instance.dueDate.toIso8601String(),
      'rangeDate': instance.rangeDate?.toJson(),
      'showNotification': instance.showNotification,
      'completed': instance.completed,
    };
