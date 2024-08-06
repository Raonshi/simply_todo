import 'base_model.dart';

final class RangeDateModel extends BaseModel {
  final DateTime? start;
  final DateTime? end;

  const RangeDateModel({
    required this.start,
    required this.end,
  });

  factory RangeDateModel.create() => RangeDateModel(
        start: DateTime.now(),
        end: null,
      );

  factory RangeDateModel.fromJson(Map<String, dynamic> json) {
    return RangeDateModel(
      start: json.containsKey("start")
          ? DateTime.fromMillisecondsSinceEpoch(json["start"])
          : null,
      end: json.containsKey("end")
          ? DateTime.fromMillisecondsSinceEpoch(json["end"])
          : null,
    );
  }

  @override
  RangeDateModel copyWith({
    DateTime? start,
    DateTime? end,
  }) {
    return RangeDateModel(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  Map<String, dynamic> toMap() => {
        "start": start?.millisecondsSinceEpoch,
        "end": end?.millisecondsSinceEpoch,
      };

  @override
  String toString() {
    return "RangeDate{start: $start, end: $end}";
  }
}
