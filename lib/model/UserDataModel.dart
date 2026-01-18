import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  bool success;
  Data data;
  String message;

  UserDataModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    success: json["success"]??false,
    data: Data.fromJson(json["data"]),
    message: json["message"]??"",
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  String interestStatus;
  User user;

  Data({
    required this.interestStatus,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    interestStatus: json["interestStatus"].toString(),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "interestStatus": interestStatus,
    "user": user.toJson(),
  };
}

class User {
  String id;
  String mobile;
  String email;
  String gender;
  String profileFor;
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
  String countryName;
  String stateName;
  String districtName;
  String blockName;
  String cityName;
  Country country;
  Country state;
  Country district;
  Country block;
  Country city;

  User({
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
    required this.countryName,
    required this.stateName,
    required this.districtName,
    required this.blockName,
    required this.cityName,
    required this.country,
    required this.state,
    required this.district,
    required this.block,
    required this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"].toString(),
    mobile: json["mobile"].toString(),
    email: json["email"].toString(),
    gender: json["gender"].toString(),
    profileFor: json["profile_for"].toString(),
    profilePictures: json["profile_pictures"].toString(),
    fullName: json["full_name"].toString(),
    dateOfBirth:json["date_of_birth"].toString(),
    height: json["height"].toString(),
    interest: json["interest"].toString(),
    aboutYou: json["about_you"].toString(),
    countryId: json["country_id"].toString(),
    stateId: json["state_id"].toString(),
    districtId: json["district_id"].toString(),
    blockId: json["block_id"].toString(),
    cityId: json["city_id"].toString(),
    selectCityBlock: json["select_city_block"].toString(),
    wardNo: json["ward_no"]??"",
    panchayat: json["panchayat"]??"",
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
    countryName: json["country_name"]??"",
    stateName: json["state_name"]??"",
    districtName: json["district_name"]??"",
    blockName: json["block_name"]??"",
    cityName: json["city_name"]??"",
    country: Country.fromJson(json["country"]??{}),
    state: Country.fromJson(json["state"]??{}),
    district:  Country.fromJson(json["district"]??{}),
    block:  Country.fromJson(json["block"]??{}),
    city:  Country.fromJson(json["city"]??{}),
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
    "district_id": districtId,
    "block_id": blockId,
    "city_id": cityId,
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
    "country": country.toJson(),
    "state": state.toJson(),
    "district": district.toJson(),
    "block": block.toJson(),
    "city": city.toJson(),
  };
}

class Country {
  String id;
  String name;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String? countryId;

  Country({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    this.countryId,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"].toString(),
    name: json["name"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    deletedAt: json["deleted_at"].toString(),
    countryId: json["country_id"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "country_id": countryId,
  };
}
