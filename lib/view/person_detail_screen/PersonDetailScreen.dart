import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shaadiviha/controller/profile_controller/ProfileController.dart';
import 'package:shaadiviha/network/WebService.dart';
import 'package:sizer/sizer.dart';

import '../../util/ColorConst.dart';
import '../../util/CommonFunction.dart';
import '../../util/CommonWidget.dart';
import '../../util/ConstValue.dart';
import '../../util/ImageConst.dart';
import '../../util/Injection.dart';
import '../../util/StringConst.dart';

class PersonDetailScreen extends StatefulWidget {
  const PersonDetailScreen({super.key});

  @override
  State<PersonDetailScreen> createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends State<PersonDetailScreen> {
  ProfileController profileController = Get.find<ProfileController>();

  var userId = "", isUserDetailFilled = "";
  var requestSend = false.obs;
  PageController pageController = PageController();
  var indexDot = 0.obs;

  var listPageView = <Widget>[].obs;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();

    if (Get.parameters["userId"] != null) {
      userId = Get.parameters["userId"]!;
      isUserDetailFilled = Get.parameters["isUserDetailFilled"]!;
      profileController.getUserProfileInfo(userId).then((value) {

        //TO get image list profile string
        if(profileController.userProfileModel.value !=null){
         var profileImage = profileController.userProfileModel.value?.data.user.profilePictures??"";
          List<String> imageList = profileImage
              .split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();
          for(var value in imageList){
            listPageView.add( productImageView("${DI<WebService>().IMAGE_BASE_URL}$value"));
          }
        }

      },);
    }


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DI<CommonWidget>().gradientAppbar(
            backIcon: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: DI<ColorConst>().whiteColor,
              ),
            ),
            "",
            search: Icon(null)),
        body: Obx(
          () {
            if (profileController.profileLoading.value) {
              return SizedBox.shrink();
            }
            if (profileController.userProfileModel.value == null) {
              return DI<CommonWidget>().noRecordFound();
            }
            var userData = profileController.userProfileModel.value?.data.user;
            return SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  pageViewImage(),
                  dotList(),
                  rowData(
                      DI<StringConst>().nameText,
                      (userData?.fullName == null ||
                              userData!.fullName.toLowerCase() == "null")
                          ? "N/A"
                          : userData!.fullName),
                  rowData(
                      DI<StringConst>().emailText,
                      (userData?.email == null ||
                              userData!.email.toLowerCase() == "null")
                          ? "N/A"
                          : getMaskedEmail(userData!.email, profileController.userProfileModel.value?.data.interestStatus.toString()??"")),
                  rowData(
                      DI<StringConst>().mobileText,
                      (userData?.mobile == null ||
                              userData!.mobile.toLowerCase() == "null")
                          ? "N/A"
                          : getMaskedMobile(userData!.mobile, profileController.userProfileModel.value?.data.interestStatus.toString()??"")),
                  rowData(DI<StringConst>().d_o_bText,
                      (userData?.dateOfBirth == null || userData!.dateOfBirth.toLowerCase() == "null")
                          ? "N/A"
                          : userData!.dateOfBirth),
                  rowData(
                      DI<StringConst>().heightText, (userData?.height == null ||
            userData!.height.toLowerCase() == "null")
            ? "N/A"
                : userData!.height),
                  rowData(DI<StringConst>().qualificationText,
                      (userData?.education == null ||
                          userData!.education.toLowerCase() == "null")
                          ? "N/A"
                          : userData!.education),
                  rowData(DI<StringConst>().workingText,
                      (userData?.occupation == null ||
                          userData!.occupation.toLowerCase() == "null")
                          ? "N/A"
                          : userData!.occupation),
      
                  rowData(DI<StringConst>().panchayatText,
                      (userData?.panchayat == null ||
                          userData!.panchayat.toLowerCase() == "null")
                          ? "N/A"
                          : userData!.panchayat),
                  rowData(DI<StringConst>().stateText,  (userData?.state == null ||
                      userData!.state == "null")
                      ? "N/A"
                      : userData!.state.name),
                  rowData(
                      DI<StringConst>().descText,  (userData?.aboutYou == null ||
                      userData!.aboutYou.toLowerCase() == "null")
                      ? "N/A"
                      : userData!.aboutYou),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Obx(() => SizedBox(
          height: profileController.userProfileModel.value?.data.interestStatus.toString() != "3"?kBottomNavigationBarHeight:0,
          child:
          profileController.userProfileModel.value?.data.interestStatus.toString() != "3"?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (isUserDetailFilled.toString() == "true") {
                        if(profileController.userProfileModel.value?.data.interestStatus.toString() == "0"){
                          requestSend.value = await profileController.sendInterestRequest(userId);
                          if (requestSend.value) {
                            profileController
                                .userProfileModel.value?.data.interestStatus = "1";
      
                            profileController.userProfileModel.refresh();
      
                            print(">>${profileController
                                .userProfileModel.value!.data.interestStatus}");
                          }
                        }else  if(profileController.userProfileModel.value?.data.interestStatus.toString() == "2"){
                          // to response
                          profileController.interestRespond(userId, "accepted");
                        }
                        else{
                          print("Not send");
                        }
      
                      } else {
                        //Please complete your profile first
                        DI<CommonWidget>().errorDialog(
                            DI<StringConst>().pleaseCompleteYourProfileTxt, () {
                          Get.back();
                          Get.back(result: "Complete");
                        });
                      }
                    },
                    style: ButtonStyle(
                        elevation: WidgetStatePropertyAll(3.0),
                        padding:
                        WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 15)),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(
                                color: DI<ColorConst>().whiteColor, width: 1.3),
                          ),
                        ),
                        backgroundColor:
                        WidgetStatePropertyAll(DI<ColorConst>().darkPrimaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                              () => Icon(
                            _getInterestIcon(profileController
                                .userProfileModel.value?.data.interestStatus
                                .toString()),
                            color: DI<ColorConst>().colorPrimary,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          _getInterestText(profileController
                              .userProfileModel.value?.data.interestStatus
                              .toString()),
                          style: DI<CommonWidget>().myTextStyle(
                              DI<ColorConst>().colorPrimary, 16.sp, FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                profileController.userProfileModel.value?.data.interestStatus.toString() == "2"?
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (isUserDetailFilled.toString() == "true") {
                        // to response
                        profileController.interestRespond(userId, "rejected");
                      } else {
                        //Please complete your profile first
                      await  DI<CommonWidget>().errorDialog(
                            DI<StringConst>().pleaseCompleteYourProfileTxt, () {
                          Get.back();
                        });
                      print("ref");
                      Get.back();
                      Get.back(result: "Complete");
                      }
                    },
                    style: ButtonStyle(
                        elevation: WidgetStatePropertyAll(3.0),
                        padding:
                        WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 15)),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(
                                color: DI<ColorConst>().whiteColor, width: 1.3),
                          ),
                        ),
                        backgroundColor:
                        WidgetStatePropertyAll(DI<ColorConst>().redDulColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cancel_outlined,
                          color: DI<ColorConst>().colorPrimary,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          DI<StringConst>().requestRejectedText,
                          style: DI<CommonWidget>().myTextStyle(
                              DI<ColorConst>().colorPrimary, 16.sp, FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ):SizedBox(),
              ],
            ),
          ):SizedBox(),
        ),)
      ),
    );
  }

  IconData _getInterestIcon(String? interestStatus) {
    switch (interestStatus) {
      case "1":
        return Icons.check;
      case "2":
        return Icons.call_received;
      case "3":
        return Icons.done_all;
      case "0":
        return CupertinoIcons.heart_solid;
      default:
        return CupertinoIcons.heart_solid; // fallback icon
    }
  }

  String _getInterestText(String? interestStatus) {
    switch (interestStatus) {
      case "1":
        return DI<StringConst>().requestSendText;
      case "2":
        return DI<StringConst>().acceptText;
      case "3":
        return DI<StringConst>().requestAcceptedText;
      case "0":
        return DI<StringConst>().interestedText;
      default:
        return DI<StringConst>().interestedText; // fallback icon
    }
  }

  Widget rowData(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: DI<CommonWidget>().myTextStyle(
                  DI<ColorConst>().blackColor, 16.sp, FontWeight.w500),
            ),
          ),
          Text(":"),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              maxLines: 5,
              style: DI<CommonWidget>().myTextStyle(
                  DI<ColorConst>().darkGryColor, 16.sp, FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  String getMaskedMobile(String mobile, String interestStatus) {
    if (interestStatus == "3") return mobile;
    if (mobile.length < 4) return '**'; // fallback for short numbers
    return mobile.substring(0, 2) + '******' + mobile.substring(mobile.length - 2);
  }


  String getMaskedEmail(String email, String interestStatus) {
    if (interestStatus == "3") return email;

    final parts = email.split('@');
    if (parts.length != 2) return email;

    String username = parts[0];
    String domain = parts[1];

    if (username.length <= 2) {
      username = '*' * username.length;
    } else {
      username = username[0] + '*' * (username.length - 2) + username[username.length - 1];
    }

    return '$username@$domain';
  }

  Widget pageViewImage() {
    return SizedBox(
      height: 91.w,
      child: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        children: listPageView.value,
        onPageChanged: (index) {
          print("Index :-- $index");
          indexDot.value = index;
        },
      ),
    );
  }


  Widget productImageView(String productImage) {
    return SizedBox(
      height: 100.w,
      width: 100.w,
      child: PhotoView.customChild(
        backgroundDecoration: BoxDecoration(
            color: DI<ColorConst>().whiteColor
        ),
        minScale: PhotoViewComputedScale.contained,
        child: FadeInImage.assetNetwork(
          placeholder: DI<ImageConst>().Loader_Image,
          placeholderFit: BoxFit.scaleDown,
          image: productImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }


  Widget dotList() {
    return SizedBox(
      height: 4.w,
      width: 100.w,
      child: Center(
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount:listPageView.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Center(
              child: Obx(
                    () => Container(
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                      color: indexDot.value == index
                          ? DI<ColorConst>().gryColor
                          : DI<ColorConst>().whiteColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: DI<ColorConst>().gryColor)),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 5,
            );
          },
        ),
      ),
    );
  }
}
