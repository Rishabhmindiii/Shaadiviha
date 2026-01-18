import 'dart:convert';

UserListModel userListModelFromJson(String str) => UserListModel.fromJson(json.decode(str));

String userListModelToJson(UserListModel data) => json.encode(data.toJson());

class UserListModel {
  bool success;
  List<Datum> data;
  String message;

  UserListModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
    success: json["success"]??false,
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  String id;
  String mobile;
  String email;
  String gender;
  String? profileFor;
  String? profilePictures;
  String? fullName;
  String? dateOfBirth;
  String? height;
  String? interest;
  String? aboutYou;
  String? countryId;
  String? stateId;
  String? district;
  String selectCityBlock;
  String? wardNo;
  String? panchayat;
  String? policeStation;
  String? motherToungue;
  String? maritalStatus;
  String? religion;
  String? caste;
  String? education;
  String? occupation;
  String isVerified;
  String verifiedBy;
  String verifiedAt;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;

  Datum({
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
    required this.district,
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    district: json["district"].toString(),
    selectCityBlock: json["select_city_block"].toString(),
    wardNo: json["ward_no"].toString(),
    panchayat: json["panchayat"].toString(),
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
    "gender": gender,
    "profile_for": profileFor,
    "profile_pictures": profilePictures,
    "full_name": fullName,
    "date_of_birth": dateOfBirth,
    "height": height,
    "interest": interest,
    "about_you": aboutYou,
    "country_id": countryId,
    "state_id": stateId,
    "district": district,
    "select_city_block": selectCityBlock,
    "ward_no": wardNo,
    "panchayat": panchayat,
    "police_station": policeStation,
    "mother_toungue": motherToungue,
    "marital_status": maritalStatus,
    "religion": religion,
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
