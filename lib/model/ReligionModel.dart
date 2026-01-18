import 'dart:convert';

ReligionModel religionModelFromJson(String str) => ReligionModel.fromJson(json.decode(str));

String religionModelToJson(ReligionModel data) => json.encode(data.toJson());

class ReligionModel {
  bool success;
  List<Religion> data;
  String message;

  ReligionModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ReligionModel.fromJson(Map<String, dynamic> json) => ReligionModel(
    success: json["success"]??false,
    data: List<Religion>.from(json["data"].map((x) => Religion.fromJson(x))),
    message: json["message"]??"",
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Religion {
  String id;
  String name;

  Religion({
    required this.id,
    required this.name,
  });

  factory Religion.fromJson(Map<String, dynamic> json) => Religion(
    id: json["id"].toString(),
    name: json["name"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
