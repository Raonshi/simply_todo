import 'package:simpletodo/domain/model/base_model.dart';

final class TagModel extends BaseModel {
  final String name;

  const TagModel._({required this.name});

  factory TagModel.create({required String name}) {
    return TagModel._(name: name);
  }

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel._(name: json["name"]);
  }

  String get label => "#$name";

  @override
  Map<String, dynamic> toMap() => {
        "name": name,
      };
}
