import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadiviha/controller/home_controller/HomeController.dart';
import 'package:shaadiviha/controller/profile_controller/ProfileController.dart';
import 'package:shaadiviha/network/WebService.dart';
import 'package:shaadiviha/util/CommonFunction.dart';


import '../../../util/ColorConst.dart';
import '../../../util/ImageConst.dart';
import '../../util/CommonWidget.dart';
import '../../util/Injection.dart';
import '../../util/RouteHelper.dart';
import '../../util/StringConst.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  HomeController homeController = Get.find<HomeController>();
  ProfileController profileController = Get.find<ProfileController>();
  @override
  void initState() {

    super.initState();
    homeController.getNotificationList();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        appBar: DI<CommonWidget>().gradientAppbar(backIcon: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios,color: DI<ColorConst>().whiteColor,),
        ), DI<StringConst>().notificationText,search: Icon(null)),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Obx(
            () =>  Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                homeController.notificationListModel.value != null && homeController.notificationListModel.value!.data.isNotEmpty?
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:homeController.notificationListModel.value?.data.length??0,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(height: 0);
                  },
                  itemBuilder: (BuildContext context, int index) {
                   var notification = homeController.notificationListModel.value?.data;
                    return Container(
                      padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        // isThreeLine: true,
                        leading: InkWell(
                          onTap: (){
                            Map<String, String>? data = {
                              "userId": notification?[index].senderId.toString()??"",
                              "isUserDetailFilled": "true"
                            };
                            Get.toNamed(DI<RouteHelper>().getPersonDetailScreen(), parameters: data);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: DI<ColorConst>().secondColorPrimary),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: FadeInImage.assetNetwork(
                                placeholder: DI<ImageConst>().Loader_Image,
                                placeholderFit: BoxFit.scaleDown,
                                image: "${DI<WebService>().IMAGE_BASE_URL}${DI<CommonFunction>().getProfileImageFromCommaString(notification?[index].sender.profilePictures??"")}",
                                fit: BoxFit.cover,
                              ),
                            )
                           // Icon(CupertinoIcons.bell_fill,size: 25,color: DI<ColorConst>().secondColorPrimary,),
                          ),
                        ),

                        title: Text(notification?[index].message??"N/A",
                          maxLines: 2,
                          style: DI<CommonWidget>().myTextStyle(
                              DI<ColorConst>().blackColor, 15, FontWeight.w500),
                          overflow: TextOverflow.visible,
                        ),

                        trailing:notification?[index].type == "interest_request" &&  notification?[index].interest?.status.toLowerCase() == "pending"?Column(
                          children: [
                            InkWell(
                              onTap:(){
                                print("acceptText");
                                profileController.interestRespond(notification?[index].senderId??"", "accepted").then((value) {
                                  homeController.getNotificationList();
                                },);
                              },
                              child: Text(
                                DI<StringConst>().acceptText,
                                style: DI<CommonWidget>().myTextStyle(
                                    DI<ColorConst>().greenColor, 15,
                                    FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            InkWell(
                              onTap:(){
                                print("requestRejectedText");
                                profileController.interestRespond(notification?[index].senderId??"", "rejected").then((value) {
                                  homeController.getNotificationList();
                                },);
                              },
                              child: Text(
                                DI<StringConst>().requestRejectedText,
                                style: DI<CommonWidget>().myTextStyle(
                                    DI<ColorConst>().redDulColor, 15,
                                    FontWeight.w700),
                              ),
                            ),
                          ],
                        ):SizedBox(),
                      ),
                    );
                  },
                ):SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
