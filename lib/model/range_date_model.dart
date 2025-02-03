import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'range_date_model.g.dart';

@JsonSerializable()
@CopyWith(copyWithNull: true)
final class RangeDateModel {
  final DateTime? start;
  final DateTime? end;

  const RangeDateModel({
    required this.start,
    required this.end,
  });

  factory RangeDateModel.fromJson(Map<String, dynamic> json) =>
      _$RangeDateModelFromJson(json);

  Map<String, dynamic> toJson() => _$RangeDateModelToJson(this);

  factory RangeDateModel.create() => RangeDateModel(
        start: DateTime.now(),
        end: null,
      );
}
