import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  bool success;
  List<Datum> data;
  String message;

  CityModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    success: json["success"]??false,
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"].toString()??"",
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  String id;
  String name;

  Datum({
    required this.id,
    required this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"].toString()??"",
    name: json["name"].toString()??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
