import 'dart:convert';

SubscriptionModel subscriptionModelFromJson(String str) => SubscriptionModel.fromJson(json.decode(str));

String subscriptionModelToJson(SubscriptionModel data) => json.encode(data.toJson());

class SubscriptionModel {
  bool success;
  List<Datum> data;
  String message;

  SubscriptionModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
    success: json["success"]??false,
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"]??"",
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
  String price;
  String duration;
  String noOfRequests;
  String description;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Datum({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.noOfRequests,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"].toString(),
    name: json["name"].toString(),
    price: json["price"].toString(),
    duration: json["duration"].toString(),
    noOfRequests: json["no_of_requests"].toString(),
    description: json["description"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    deletedAt: json["deleted_at"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "duration": duration,
    "no_of_requests": noOfRequests,
    "description": description,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}
