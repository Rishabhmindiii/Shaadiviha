import 'dart:convert';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  bool success;
  List<Datum> data;
  String message;

  CountryModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
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
