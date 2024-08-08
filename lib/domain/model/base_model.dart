abstract class BaseModel {
  const BaseModel();

  Map<String, dynamic> toMap();

  BaseModel copyWith() {
    throw UnimplementedError();
  }
  

  @override
  String toString() => toMap().toString();
}
