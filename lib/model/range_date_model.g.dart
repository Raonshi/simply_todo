// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'range_date_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RangeDateModelCWProxy {
  RangeDateModel start(DateTime? start);

  RangeDateModel end(DateTime? end);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RangeDateModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RangeDateModel(...).copyWith(id: 12, name: "My name")
  /// ````
  RangeDateModel call({
    DateTime? start,
    DateTime? end,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRangeDateModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRangeDateModel.copyWith.fieldName(...)`
class _$RangeDateModelCWProxyImpl implements _$RangeDateModelCWProxy {
  const _$RangeDateModelCWProxyImpl(this._value);

  final RangeDateModel _value;

  @override
  RangeDateModel start(DateTime? start) => this(start: start);

  @override
  RangeDateModel end(DateTime? end) => this(end: end);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RangeDateModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RangeDateModel(...).copyWith(id: 12, name: "My name")
  /// ````
  RangeDateModel call({
    Object? start = const $CopyWithPlaceholder(),
    Object? end = const $CopyWithPlaceholder(),
  }) {
    return RangeDateModel(
      start: start == const $CopyWithPlaceholder()
          ? _value.start
          // ignore: cast_nullable_to_non_nullable
          : start as DateTime?,
      end: end == const $CopyWithPlaceholder()
          ? _value.end
          // ignore: cast_nullable_to_non_nullable
          : end as DateTime?,
    );
  }
}

extension $RangeDateModelCopyWith on RangeDateModel {
  /// Returns a callable class that can be used as follows: `instanceOfRangeDateModel.copyWith(...)` or like so:`instanceOfRangeDateModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RangeDateModelCWProxy get copyWith => _$RangeDateModelCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `RangeDateModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RangeDateModel(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  RangeDateModel copyWithNull({
    bool start = false,
    bool end = false,
  }) {
    return RangeDateModel(
      start: start == true ? null : this.start,
      end: end == true ? null : this.end,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RangeDateModel _$RangeDateModelFromJson(Map<String, dynamic> json) =>
    RangeDateModel(
      start: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
      end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
    );

Map<String, dynamic> _$RangeDateModelToJson(RangeDateModel instance) =>
    <String, dynamic>{
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
    };
