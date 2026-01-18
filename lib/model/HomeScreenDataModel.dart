import 'dart:convert';

HomeScreenDataModel homeScreenDataModelFromJson(String str) => HomeScreenDataModel.fromJson(json.decode(str));

String homeScreenDataModelToJson(HomeScreenDataModel data) => json.encode(data.toJson());

class HomeScreenDataModel {
  bool? success;
  Data data;
  String message;

  HomeScreenDataModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory HomeScreenDataModel.fromJson(Map<String, dynamic> json) => HomeScreenDataModel(
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
  String matchesProfile;
  String justJoined;
  List<Banner> banners;
  User user;

  Data({
    required this.matchesProfile,
    required this.justJoined,
    required this.banners,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    matchesProfile: json["matchesProfile"].toString(),
    justJoined: json["justJoined"].toString(),
    banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "matchesProfile": matchesProfile,
    "justJoined": justJoined,
    "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
    "user": user.toJson(),
  };
}

class Banner {
  String id;
  String image;
  String categoryId;
  String status;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Banner({
    required this.id,
    required this.image,
    required this.categoryId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json["id"].toString(),
    image: json["image"].toString(),
    categoryId: json["category_id"].toString(),
    status: json["status"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    deletedAt: json["deleted_at"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "category_id": categoryId,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
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
  String country;
  String state;
  String district;
  String block;
  String city;

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
    country: json["country"].toString(),
    state: json["state"].toString(),
    district: json["district"].toString(),
    block: json["block"].toString(),
    city: json["city"].toString(),
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
    "country": country,
    "state": state,
    "district": district,
    "block": block,
    "city": city,
  };
}
