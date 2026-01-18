import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadiviha/controller/home_controller/HomeController.dart';
import 'package:shaadiviha/util/ColorConst.dart';
import 'package:shaadiviha/util/StringConst.dart';
import 'package:sizer/sizer.dart';

import '../../network/WebService.dart';
import '../../util/CommonFunction.dart';
import '../../util/CommonWidget.dart';
import '../../util/ImageConst.dart';
import '../../util/Injection.dart';
import '../../util/RouteHelper.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  HomeController homeController = Get.find<HomeController>();

   List<Map<String, dynamic>> userList =[];

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    userList = [
      {
        "name": "Fatima",
        "profileImage": "https://plus.unsplash.com/premium_photo-1677966145689-2f2ba6f8782b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8bXVzbGltJTIwcGVvcGxlfGVufDB8fDB8fHww",
        "shortDescription": "Coffee lover and traveler",
        "age": "24",
      },
      {
        "name": "Sahil",
        "profileImage": "https://i.pinimg.com/736x/b0/45/9d/b0459d7b91e3a175f33846de93a252b0.jpg",
        "shortDescription": "Tech geek and foodie",
        "age": "27",
      },
      {
        "name": "Khitab",
        "profileImage": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9mkkIWGbRhO32n6VPSr50ws1k-xD6zaLVDlp4FglUd4hNW4we79WYEWzSoy-oMkzzixg&usqp=CAU",
        "shortDescription": "Tech geek and foodie",
        "age": "22",
      },
      {
        "name": "Jainab",
        "profileImage": "https://media.istockphoto.com/id/1394149744/photo/headshot-of-early-20s-middle-eastern-woman.jpg?s=612x612&w=0&k=20&c=Q4gBjPUfikbPtkFh3I9_CoLF53H8Bz9FAfxiMOO7eIY=",
        "shortDescription": "Yoga enthusiast and dog mom",
        "age": "21",
      },
      {
        "name": "Amira",
        "profileImage": "https://media.istockphoto.com/id/1194745993/photo/smiling-muslim-woman-wearing-hijab.jpg?s=612x612&w=0&k=20&c=8yu_OxGaAiDQas7hjLBy8-CnjY40r5Gxw06dZV8lxFs=",
        "shortDescription": "Bookworm and photographer",
        "age": "29",
      },
      {
        "name": "Salman",
        "profileImage": "https://media.istockphoto.com/id/474912698/photo/portrait-of-a-black-african-man-in-mosque.jpg?s=612x612&w=0&k=20&c=oRNqdGFBwKA_I-VkYKchJVbH10vuBFHDvTMEufR2YkU=",
        "shortDescription": "Loves hiking and art",
        "age": "26",
      },
      {
        "name": "Farrok",
        "profileImage": "https://thumbs.dreamstime.com/b/arabic-muslim-man-beard-portrait-36217895.jpg",
        "shortDescription": "Music fan and night owl",
        "age": "23",
      },
    ];
    homeController.getUserList("");
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:DI<CommonWidget>().gradientAppbar(DI<StringConst>().userListText),
        body:  Obx(
          () =>
          Column(
            children: [
              homeController.userListModel.value !=null?
              Expanded(
                child: GridView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount:homeController.userListModel.value?.data.length,
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 7.0,
                    mainAxisSpacing:7.0,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, indexInner) {
                    var listData = homeController.userListModel.value?.data;
                    return InkWell(
                      onTap: () {
                        Map<String, String>? data = {
                          "userId": listData?[indexInner].id.toString()??"",
                        "isUserDetailFilled": "true"
                        };
                        Get.toNamed(DI<RouteHelper>().getPersonDetailScreen(), parameters: data);
                      },
                      child: Stack(
                        children: [
                          Container(
                            foregroundDecoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [0, 0.9],
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: FadeInImage.assetNetwork(
                                placeholder: DI<ImageConst>().Loader_Image,
                                placeholderFit: BoxFit.scaleDown,
                                image: "${DI<WebService>().IMAGE_BASE_URL}${DI<CommonFunction>().getProfileImageFromCommaString(listData?[indexInner].profilePictures.toString()??"")}",
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 61.sp,
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    DI<ImageConst>().USER_DEFALUT,
                                    width: 50.sp,
                                    height: 50.sp,
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10.0,
                            child: Container(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${listData?[indexInner].fullName}-27",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: DI<CommonWidget>().myTextStyle(
                                      DI<ColorConst>().blackColor,
                                      17.sp,
                                      FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    listData?[indexInner].caste=="null"?"N/A":listData?[indexInner].caste??"",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: DI<CommonWidget>().myTextStyle(
                                      DI<ColorConst>().blackColor,
                                      14.sp,
                                      FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    listData?[indexInner].education=="null"?"N/A":listData?[indexInner].education??"",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    style: DI<CommonWidget>().myTextStyle(
                                      DI<ColorConst>().blackColor,
                                      15.sp,
                                      FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    listData?[indexInner].occupation=="null"?"N/A":listData?[indexInner].occupation??"",
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    style: DI<CommonWidget>().myTextStyle(
                                      DI<ColorConst>().blackColor,
                                      15.sp,
                                      FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
              ):SizedBox.shrink(),
            ],
          ),
        ),
      
      ),
    );
  }


}
