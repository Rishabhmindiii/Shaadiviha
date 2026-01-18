import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadiviha/controller/profile_controller/ProfileController.dart';
import 'package:shaadiviha/network/WebService.dart';
import 'package:shaadiviha/util/CommonFunction.dart';
import 'package:shaadiviha/util/CommonWidget.dart';
import 'package:shaadiviha/util/StringConst.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../util/ColorConst.dart';
import '../../util/ConstValue.dart';
import '../../util/ImageConst.dart';
import '../../util/Injection.dart';
import '../../util/RouteHelper.dart';
import '../../util/local_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.find<ProfileController>();

  var screenType = "";

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();

    if (Get.parameters["screenType"] != null) {
      screenType = Get.parameters["screenType"]!;
    }
    print(screenType);

    Future.delayed(
      Duration.zero,
      () {
        profileController
            .getUserProfileInfo(DI<MyLocalStorage>()
                .getStringValue(DI<MyLocalStorage>().userId)
                .toString())
            .then(
          (value) async {
            if (DI<ConstValue>().fromProfileDetail) {
              var data = {
                "screenType": "profile",
                "fullName": profileController
                        .userProfileModel.value?.data.user.fullName ??
                    "",
                "dob": profileController
                        .userProfileModel.value?.data.user.dateOfBirth ??
                    "",
                "height": profileController
                        .userProfileModel.value?.data.user.height ??
                    "",
                "interest": profileController
                        .userProfileModel.value?.data.user.interest ??
                    "",
                "aboutYou": profileController
                        .userProfileModel.value?.data.user.aboutYou ??
                    "",
              };
              var result = await Get.toNamed(
                  DI<RouteHelper>().getPersonalInfoScreen(),
                  parameters: data);
              if (result != null && result == "refresh") {
                profileController.getUserProfileInfo(DI<MyLocalStorage>()
                    .getStringValue(DI<MyLocalStorage>().userId)
                    .toString());
              }
            }
            else if (DI<ConstValue>().fromSubscription) {
              Get.toNamed(DI<RouteHelper>().getSubscriptionScreen());
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: DI<ColorConst>().colorPrimary,
        body: SingleChildScrollView(
          child: Obx(() {
            return Column(
              spacing: 10,
              children: [
                Container(
                  height: 70.w,
                  width: 100.w,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        DI<ColorConst>().darkPrimaryColor,
                        DI<ColorConst>().colorPrimary,
                      ])),
                  child: profileController.userProfileModel.value != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 5,
                          children: [
                            SizedBox(
                              height: kBottomNavigationBarHeight,
                            ),
                            profileCard(),
                            Text(
                              profileController.userProfileModel.value?.data.user
                                          .fullName
                                          .toString() !=
                                      "null"
                                  ? profileController.userProfileModel.value?.data
                                          .user.fullName ??
                                      ""
                                  : "N/A",
                              style: DI<CommonWidget>().myTextStyle(
                                  DI<ColorConst>().blackColor,
                                  17.sp,
                                  FontWeight.w500),
                            ),
                            Text(
                              profileController
                                      .userProfileModel.value?.data.user.email ??
                                  "",
                              style: DI<CommonWidget>().myTextStyle(
                                  DI<ColorConst>().blackColor,
                                  15.sp,
                                  FontWeight.w400),
                            ),
                            Text(
                              profileController
                                      .userProfileModel.value?.data.user.mobile ??
                                  "",
                              style: DI<CommonWidget>().myTextStyle(
                                  DI<ColorConst>().blackColor,
                                  15.sp,
                                  FontWeight.w400),
                            )
                          ],
                        )
                      : shimmerDataView(),
                ),
                customView(
                    CupertinoIcons.person, DI<StringConst>().editProfileText,
                    () async {
                  var data = {
                    "screenType": "profile",
                    "profile_image": profileController
                        .userProfileModel.value!.data.user.profilePictures
                        .toString()
                  };
                  var result = await Get.toNamed(
                      DI<RouteHelper>().getAddPhotoScreen(),
                      parameters: data);
                  if (result != null && result == "refresh") {
                    profileController.getUserProfileInfo(DI<MyLocalStorage>()
                        .getStringValue(DI<MyLocalStorage>().userId)
                        .toString());
                  }
                }),
                customView(CupertinoIcons.person_3_fill,
                    DI<StringConst>().editPersonalInfoText, () async {
                  var data = {
                    "screenType": "profile",
                    "fullName": profileController
                            .userProfileModel.value?.data.user.fullName ??
                        "",
                    "dob": profileController
                            .userProfileModel.value?.data.user.dateOfBirth ??
                        "",
                    "height": profileController
                            .userProfileModel.value?.data.user.height ??
                        "",
                    "interest": profileController
                            .userProfileModel.value?.data.user.interest ??
                        "",
                    "aboutYou": profileController
                            .userProfileModel.value?.data.user.aboutYou ??
                        "",
                  };
                  var result = await Get.toNamed(
                      DI<RouteHelper>().getPersonalInfoScreen(),
                      parameters: data);
                  if (result != null && result == "refresh") {
                    profileController.getUserProfileInfo(DI<MyLocalStorage>()
                        .getStringValue(DI<MyLocalStorage>().userId)
                        .toString());
                  }
                }),
                customView(
                    Icons.insert_emoticon, DI<StringConst>().editSocialInfoText,
                    () async {
                  var data = {"screenType": "profile"};
                  var result = await Get.toNamed(
                      DI<RouteHelper>().getSocialDetailScreen(),
                      parameters: data);
                  if (result != null && result == "refresh") {
                    profileController.getUserProfileInfo(DI<MyLocalStorage>()
                        .getStringValue(DI<MyLocalStorage>().userId)
                        .toString());
                  }
                }),
                customView(Icons.location_on, DI<StringConst>().editAddressText,
                    () async {
      
                  var data;
                  if (profileController.userProfileModel.value != null &&
                      profileController.userProfileModel.value!.data.user.countryName.isNotEmpty) {
                    data = {
                      "screenType": "profile",
                      "country": profileController.userProfileModel.value?.data.user.countryName ?? "",
                      "state": profileController.userProfileModel.value?.data.user.stateName ?? "",
                      "district": profileController.userProfileModel.value?.data.user.districtName?? "",
                      "select_city_block": profileController.userProfileModel.value?.data.user.selectCityBlock ?? "",
                      "city": profileController.userProfileModel.value?.data.user.cityName ?? "",
                      "block_name": profileController.userProfileModel.value?.data.user.blockName ?? "",
                      "ward_no": profileController.userProfileModel.value?.data.user.wardNo ?? "",
                      "panchayat": profileController.userProfileModel.value?.data.user.panchayat ?? "",
                      "police_station": profileController.userProfileModel.value?.data.user.policeStation ??"",
                    };
                  } else {
                    data = {
                      "screenType": "",
                    };
                  }
      
                  var result = await Get.toNamed(
                      DI<RouteHelper>().getAddressScreen(),
                      parameters: data);
                  if (result != null && result == "refresh") {
                 Future.delayed(Duration.zero,() {
                   profileController.getUserProfileInfo(DI<MyLocalStorage>()
                       .getStringValue(DI<MyLocalStorage>().userId)
                       .toString());
                 },);
                  }
                }),
                /*customView(
                    Icons.add_chart_rounded, DI<StringConst>().subscriptionText,
                    () async {
                  Get.toNamed(DI<RouteHelper>().getSubscriptionScreen());
                }),*/
                customView(
                    Icons.policy_outlined, DI<StringConst>().termsPoliciesText,
                    () async {
                  var data = {
                    "url": "https://shaadiviha.com/terms-and-conditions",
                    "screenType": "Terms & Conditions",
                  };
                  var result = await Get.toNamed(
                      DI<RouteHelper>().getWebViewScreen(),
                      parameters: data);
                  if (result != null && result == "refresh") {
                    profileController.getUserProfileInfo(DI<MyLocalStorage>()
                        .getStringValue(DI<MyLocalStorage>().userId)
                        .toString());
                  }
                }),
                customView(Icons.question_mark, DI<StringConst>().browseFaqText,
                    () async {
                  var data = {
                    "url":
                        "https://shaadiviha.com/faq",
                    "screenType": "FAQ",
                  };
                  var result = await Get.toNamed(
                      DI<RouteHelper>().getWebViewScreen(),
                      parameters: data);
                  if (result != null && result == "refresh") {
                    profileController.getUserProfileInfo(DI<MyLocalStorage>()
                        .getStringValue(DI<MyLocalStorage>().userId)
                        .toString());
                  }
                }),
                customView(Icons.headphones, DI<StringConst>().privacyPolicyText,
                    () async {
                  var data = {
                    "url":
                        "https://shaadiviha.com/privacy-policy",
                    "screenType": "Privacy Policy",
                  };
                  var result = await Get.toNamed(
                      DI<RouteHelper>().getWebViewScreen(),
                      parameters: data);
                  if (result != null && result == "refresh") {
                    profileController.getUserProfileInfo(DI<MyLocalStorage>()
                        .getStringValue(DI<MyLocalStorage>().userId)
                        .toString());
                  }
                }),
                customView(Icons.delete, DI<StringConst>().deleteAccountText, () async {
      
                  DI<CommonWidget>().errorDialog(DI<StringConst>().deleteAcMsgTxt, () {
                    Get.back();
                    profileController.deleteUserAccount();
                  });
      
      
                }),
                customView(Icons.logout, DI<StringConst>().logoutText, () async {
                  DI<MyLocalStorage>().clearLocalStorage();
                  DI<MyLocalStorage>()
                      .setBoolValue(DI<MyLocalStorage>().isLogin, false);
                  Get.offNamed(DI<RouteHelper>().getLoginScreen());
                }),
                SizedBox(
                  height: 20.sp,
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget profileCard() {
    return SizedBox(
      height: 45.sp,
      width: 45.sp,
      child: Center(
        child: Card(
          color: Colors.white,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45.sp),
              side: BorderSide(color: DI<ColorConst>().gryColor, width: 1)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45.sp),
            child: FadeInImage.assetNetwork(
              placeholder: DI<ImageConst>().Loader_Image,
              image:
                  "${DI<WebService>().IMAGE_BASE_URL}${DI<CommonFunction>().getProfileImageFromCommaString(profileController.userProfileModel.value!.data.user.profilePictures)}",
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  DI<ImageConst>().PERSON_DEFAULT_IMAGE,
                  height: 45.sp,
                  width: 45.sp,
                );
              },
              fit: BoxFit.cover,
              height: 45.sp,
              width: 45.sp,
            ),
          ),
        ),
      ),
    );
  }

  /// Profile row
  Widget customView(IconData icon, String text, void Function() onTap) {
    return Card(
      color: DI<ColorConst>().whiteColor,
      elevation: 1.0,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: Icon(
              icon,
              color: DI<ColorConst>().secondColorPrimary,
            ),
            title: Text(text,
                style: DI<CommonWidget>().myTextStyle(
                    DI<ColorConst>().secondColorPrimary,
                    15.sp,
                    FontWeight.w400)),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 17,
              color: DI<ColorConst>().secondColorPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget shimmerDataView() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 7,
        children: [
          SizedBox(
            height: kBottomNavigationBarHeight,
          ),
          SizedBox(
            height: 45.sp,
            width: 45.sp,
            child: Center(
              child: Card(
                color: Colors.white,
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.sp),
                    side:
                        BorderSide(color: DI<ColorConst>().gryColor, width: 1)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(45.sp),
                    child: SizedBox(
                      height: 45.sp,
                      width: 45.sp,
                    )),
              ),
            ),
          ),
          Container(
            height: 7,
            width: 40.w,
            color: Colors.white,
          ),
          Container(
            height: 7,
            width: 40.w,
            color: Colors.white,
          ),
          Container(
            height: 7,
            width: 40.w,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
