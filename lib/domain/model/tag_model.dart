import 'package:simpletodo/domain/model/base_model.dart';

final class TagModel extends BaseModel {
  final String name;

  const TagModel({required this.name});

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(name: json["name"]);
  }

  String get label => "#$name";

  @override
  Map<String, dynamic> toMap() => {
        "name": name,
      };
}
