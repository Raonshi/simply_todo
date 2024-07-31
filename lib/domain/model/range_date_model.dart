import 'base_model.dart';

final class RangeDate implements BaseData {
  final DateTime? start;
  final DateTime? end;

  const RangeDate({
    required this.start,
    required this.end,
  });

  factory RangeDate.create() => RangeDate(
        start: DateTime.now(),
        end: null,
      );

  factory RangeDate.fromJson(Map<String, dynamic> json) {
    return RangeDate(
      start: json.containsKey("start")
          ? DateTime.fromMillisecondsSinceEpoch(json["start"])
          : null,
      end: json.containsKey("end")
          ? DateTime.fromMillisecondsSinceEpoch(json["end"])
          : null,
    );
  }

  @override
  RangeDate copyWith({
    DateTime? start,
    DateTime? end,
  }) {
    return RangeDate(
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
