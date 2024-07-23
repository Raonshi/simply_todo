abstract class BaseData {
  const BaseData();

  Map<String, dynamic> toMap();

  BaseData fromMap(Map<String, dynamic> map);

  BaseData copyWith();

  @override
  String toString() {
    return toMap().toString();
  }
}
