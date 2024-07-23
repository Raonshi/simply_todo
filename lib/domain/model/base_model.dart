abstract class BaseData {
  const BaseData();

  Map<String, dynamic> toMap();

  BaseData copyWith();

  @override
  String toString() {
    return toMap().toString();
  }
}
