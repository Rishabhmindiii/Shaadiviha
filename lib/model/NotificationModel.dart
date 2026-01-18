// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  bool success;
  List<Datum> data;
  String message;

  NotificationModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  String id;
  String recipientId;
  String senderId;
  String type;
  String referenceId;
  String message;
  String? metadata;
  String isRead;
  String createdAt;
  String updatedAt;
  String deletedAt;
  Interest? interest;
  Recipient sender;
  Recipient recipient;

  Datum({
    required this.id,
    required this.recipientId,
    required this.senderId,
    required this.type,
    required this.referenceId,
    required this.message,
    required this.metadata,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.interest,
    required this.sender,
    required this.recipient,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"].toString(),
    recipientId: json["recipient_id"].toString(),
    senderId: json["sender_id"].toString(),
    type: json["type"].toString(),
    referenceId: json["reference_id"].toString(),
    message: json["message"].toString(),
    metadata: json["metadata"].toString(),
    isRead: json["is_read"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt:json["updated_at"].toString(),
    deletedAt: json["deleted_at"].toString(),
    interest: json["interest"] == null ? null : Interest.fromJson(json["interest"]),
    sender: Recipient.fromJson(json["sender"]),
    recipient: Recipient.fromJson(json["recipient"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "recipient_id": recipientId,
    "sender_id": senderId,
    "type": type,
    "reference_id": referenceId,
    "message": message,
    "metadata": metadata,
    "is_read": isRead,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "interest": interest?.toJson(),
    "sender": sender.toJson(),
    "recipient": recipient.toJson(),
  };
}

class Interest {
  String id;
  String fromUserId;
  String toUserId;
  String status;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Interest({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
    id: json["id"].toString(),
    fromUserId: json["from_user_id"].toString(),
    toUserId: json["to_user_id"].toString(),
    status: json["status"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    deletedAt: json["deleted_at"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "from_user_id": fromUserId,
    "to_user_id": toUserId,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}


class Recipient {
  String id;
  String mobile;
  String email;
  String gender;
  String? profileFor;
  String profilePictures;
  String fullName;
  String dateOfBirth;
  String height;
  String interest;
  String aboutYou;
  String countryId;
  String stateId;
  String districtId;
  String blockId;
  String cityId;
  String selectCityBlock;
  String wardNo;
  String panchayat;
  String policeStation;
  String motherToungue;
  String maritalStatus;
  String religion;
  String caste;
  String education;
  String occupation;
  String isVerified;
  String verifiedBy;
  String verifiedAt;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;

  Recipient({
    required this.id,
    required this.mobile,
    required this.email,
    required this.gender,
    required this.profileFor,
    required this.profilePictures,
    required this.fullName,
    required this.dateOfBirth,
    required this.height,
    required this.interest,
    required this.aboutYou,
    required this.countryId,
    required this.stateId,
    required this.districtId,
    required this.blockId,
    required this.cityId,
    required this.selectCityBlock,
    required this.wardNo,
    required this.panchayat,
    required this.policeStation,
    required this.motherToungue,
    required this.maritalStatus,
    required this.religion,
    required this.caste,
    required this.education,
    required this.occupation,
    required this.isVerified,
    required this.verifiedBy,
    required this.verifiedAt,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) => Recipient(
    id: json["id"].toString(),
    mobile: json["mobile"].toString(),
    email: json["email"].toString(),
    gender: json["gender"].toString(),
    profileFor: json["profile_for"].toString(),
    profilePictures: json["profile_pictures"].toString(),
    fullName: json["full_name"].toString(),
    dateOfBirth: json["date_of_birth"].toString(),
    height: json["height"].toString(),
    interest: json["interest"].toString(),
    aboutYou: json["about_you"].toString(),
    countryId: json["country_id"].toString(),
    stateId: json["state_id"].toString(),
    districtId: json["district_id"].toString(),
    blockId: json["block_id"].toString(),
    cityId: json["city_id"].toString(),
    selectCityBlock: json["select_city_block"].toString(),
    wardNo: json["ward_no"].toString(),
    panchayat: json["panchayat"],
    policeStation: json["police_station"].toString(),
    motherToungue: json["mother_toungue"].toString(),
    maritalStatus: json["marital_status"].toString(),
    religion: json["religion"].toString(),
    caste: json["caste"].toString(),
    education: json["education"].toString(),
    occupation: json["occupation"].toString(),
    isVerified: json["is_verified"].toString(),
    verifiedBy: json["verified_by"].toString(),
    verifiedAt: json["verified_at"].toString(),
    emailVerifiedAt: json["email_verified_at"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mobile": mobile,
    "email": email,
    "gender":gender,
    "profile_for": profileFor,
    "profile_pictures": profilePictures,
    "full_name": fullName,
    "date_of_birth": dateOfBirth,
    "height": height,
    "interest": interest,
    "about_you": aboutYou,
    "country_id": countryId,
    "state_id": stateId,
    "district_id": districtId,
    "block_id": blockId,
    "city_id": cityId,
    "select_city_block": selectCityBlock,
    "ward_no": wardNo,
    "panchayat": panchayat,
    "police_station": policeStation,
    "mother_toungue": motherToungue,
    "marital_status": maritalStatus,
    "religion":religion,
    "caste": caste,
    "education": education,
    "occupation": occupation,
    "is_verified": isVerified,
    "verified_by": verifiedBy,
    "verified_at": verifiedAt,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

