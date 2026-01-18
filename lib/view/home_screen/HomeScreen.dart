import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:shaadiviha/controller/home_controller/HomeController.dart';
import 'package:shaadiviha/controller/profile_controller/ProfileController.dart';
import 'package:shaadiviha/network/WebService.dart';
import 'package:shaadiviha/util/ColorConst.dart';
import 'package:shaadiviha/util/CommonFunction.dart';
import 'package:shaadiviha/util/RouteHelper.dart';
import 'package:shaadiviha/util/StringConst.dart';
import 'package:shaadiviha/util/local_storage.dart';
import 'package:shaadiviha/view/home_tab_Screen/HomeTabScreen.dart';
import 'package:sizer/sizer.dart';

import '../../util/CommonWidget.dart';
import '../../util/ConstValue.dart';
import '../../util/ImageConst.dart';
import '../../util/Injection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeController homeController = Get.find<HomeController>();
  ProfileController profileController = Get.find<ProfileController>();

  final List<String> imgList = [
    'https://legalinformation.asia/wp-content/uploads/2024/06/Nikkah.jpg',
    'https://i.pinimg.com/736x/d1/bb/61/d1bb6123899d33e63778b6195f1d6116.jpg',
    'https://t4.ftcdn.net/jpg/04/96/04/17/360_F_496041725_b3YYJICnd8H0bfEZ9RwtHOkrohpIILvQ.jpg',
    'https://media.istockphoto.com/id/1179439308/photo/national-wedding-bride-and-groom-wedding-muslim-couple-during-the-marriage-ceremony-muslim.jpg?s=612x612&w=0&k=20&c=j7Oipq2aCVCO5XqSF_sqvTl4b43SoZpPNcMNkKGGJmQ=',
  ];

  List<Map<String, dynamic>> nestedList = [
    {
      "title": "Recent Match",
      "data": [
        {
          "name": "Fatima",
          "profileImage": "https://plus.unsplash.com/premium_photo-1677966145689-2f2ba6f8782b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8bXVzbGltJTIwcGVvcGxlfGVufDB8fDB8fHww",
          "shortDescription": "Coffee lover and traveler",
        },
        {
          "name": "Sahil",
          "profileImage": "https://i.pinimg.com/736x/b0/45/9d/b0459d7b91e3a175f33846de93a252b0.jpg",
          "shortDescription": "Tech geek and foodie",
        },
        {
          "name": "Khitab",
          "profileImage": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9mkkIWGbRhO32n6VPSr50ws1k-xD6zaLVDlp4FglUd4hNW4we79WYEWzSoy-oMkzzixg&usqp=CAU",
          "shortDescription": "Tech geek and foodie",
        },
      ]
    },
    {
      "title": "Recommended Profile",
      "data": [
        {
          "name": "Jainab",
          "profileImage": "https://media.istockphoto.com/id/1394149744/photo/headshot-of-early-20s-middle-eastern-woman.jpg?s=612x612&w=0&k=20&c=Q4gBjPUfikbPtkFh3I9_CoLF53H8Bz9FAfxiMOO7eIY=",
          "shortDescription": "Yoga enthusiast and dog mom",
        },
        {
          "name": "Amira",
          "profileImage": "https://media.istockphoto.com/id/1194745993/photo/smiling-muslim-woman-wearing-hijab.jpg?s=612x612&w=0&k=20&c=8yu_OxGaAiDQas7hjLBy8-CnjY40r5Gxw06dZV8lxFs=",
          "shortDescription": "Bookworm and photographer",
        },
      ]
    },
    {
      "title": "Best Match",
      "data": [
        {
          "name": "Salman",
          "profileImage": "https://media.istockphoto.com/id/474912698/photo/portrait-of-a-black-african-man-in-mosque.jpg?s=612x612&w=0&k=20&c=oRNqdGFBwKA_I-VkYKchJVbH10vuBFHDvTMEufR2YkU=",
          "shortDescription": "Loves hiking and art",
        },
        {
          "name": "Farrok",
          "profileImage": "https://thumbs.dreamstime.com/b/arabic-muslim-man-beard-portrait-36217895.jpg",
          "shortDescription": "Music fan and night owl",
        },
      ]
    },
    {
      "title": "Just Joined",
      "data": [
        {
          "name": "Jainab",
          "profileImage": "https://media.istockphoto.com/id/1394149744/photo/headshot-of-early-20s-middle-eastern-woman.jpg?s=612x612&w=0&k=20&c=Q4gBjPUfikbPtkFh3I9_CoLF53H8Bz9FAfxiMOO7eIY=",
          "shortDescription": "Yoga enthusiast and dog mom",
        },
        {
          "name": "Amira",
          "profileImage": "https://media.istockphoto.com/id/1194745993/photo/smiling-muslim-woman-wearing-hijab.jpg?s=612x612&w=0&k=20&c=8yu_OxGaAiDQas7hjLBy8-CnjY40r5Gxw06dZV8lxFs=",
          "shortDescription": "Bookworm and photographer",
        },
      ]
    },
  ];

  var nearbyValue = false.obs;
  var myMatchValue = false.obs;
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();

    print("authToken :- ${DI<MyLocalStorage>().getStringValue(DI<MyLocalStorage>().authToken)}");
    homeController.getHomeUserData().then((value) => homeController.getHomeUserList(""));
    if(profileController.userProfileModel.value == null){
      profileController.getUserProfileInfo(DI<MyLocalStorage>().getStringValue(DI<MyLocalStorage>().userId));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Obx(
     () {
       return SafeArea(
         child: Scaffold(
           body: DI<CommonWidget>().gradiantBackGround(
               childWidget: SingleChildScrollView(
                 padding: EdgeInsets.symmetric(horizontal: 10),
                 child:homeController.loading.value?
                 SizedBox()
                     : Column(
                   children: [
                     SizedBox(
                       height: kBottomNavigationBarHeight - 10,
                     ),
                     appBarHome(),
                     sliderImage(),
                     SizedBox(
                       height: 20,
                     ),
                     doubleCardView(),
                     SizedBox(height: 5,),
                     profileController.userProfileModel.value?.data.user.isVerified != "1"?
                     verificationCard():SizedBox(),
                     SizedBox(height: 5,),
                     Row(
                       children: [
                         Expanded(
                           flex: 1,
                           child:    InkWell(
                             onTap: (){
                               myMatchValue.value = false;
                               nearbyValue.value = !nearbyValue.value;
                              if( nearbyValue.value) {
                                homeController.getHomeUserList("Nearby");
                              } else {
                                homeController.getHomeUserList("");
                              }

                             },
                             child: Container(
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(20),
                                   border: Border.all(color:
                                   nearbyValue.value?DI<ColorConst>().whiteColor:
                                   DI<ColorConst>().darkGryColor),
                                   color: nearbyValue.value?DI<ColorConst>().darkPrimaryColor: Colors.transparent
                               ),
                               alignment: Alignment.center,
                               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5.0),
                               child: Text(DI<StringConst>().nearByTxt,
                                 style: DI<CommonWidget>().myTextStyle(
                                     nearbyValue.value?DI<ColorConst>().whiteColor:
                                     DI<ColorConst>().darkGryColor, 15.sp, FontWeight.w500),),
                             ),
                           ),),
                         SizedBox(
                           width: 10,
                         ),
                         Expanded(
                           flex: 1,
                           child:    InkWell(
                             onTap: (){
                               nearbyValue.value = false;
                               myMatchValue.value = !myMatchValue.value;

                               if( myMatchValue.value) {
                                 homeController.getHomeUserList("MyMatch");
                               } else {
                                 homeController.getHomeUserList("");
                               }
                             },
                             child: Container(
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(20),
                                   border: Border.all(color:
                                   myMatchValue.value?DI<ColorConst>().whiteColor:
                                   DI<ColorConst>().darkGryColor),
                                   color: myMatchValue.value?DI<ColorConst>().darkPrimaryColor: Colors.transparent
                               ),
                               alignment: Alignment.center,
                               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5.0),
                               child: Text(DI<StringConst>().myMatchTxt,
                                 style: DI<CommonWidget>().myTextStyle(
                                     myMatchValue.value?DI<ColorConst>().whiteColor:
                                     DI<ColorConst>().darkGryColor, 15.sp, FontWeight.w500),),
                             ),
                           ),)
                       ],
                     ),
                     SizedBox(height: 5,),
                     homeController.loadingUserList.value?
                         SizedBox():
                     homeController.homeUserListModel.value !=null &&
                         homeController.homeUserListModel.value!.data.isNotEmpty?
                     showNestedList(): DI<CommonWidget>().noRecordFound()

                   ],
                 ),
               )),
         ),
       );
     }
    );
  }

  Widget appBarHome() {
    return SizedBox(
      height: kBottomNavigationBarHeight,
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Expanded(
              child: Center(
                  child: DI<CommonWidget>().appNameStyleText(fontSize: 23.sp))),
          InkWell(
            onTap: () {
              Get.toNamed(DI<RouteHelper>().getNotificationScreen());
            },
            child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color:
                    DI<ColorConst>().darkPrimaryColor,
                    borderRadius: BorderRadius.circular(7)),
                child: Icon(
                  Icons.notifications,
                  color: DI<ColorConst>().whiteColor,
                  size: 19.sp,
                )),
          )
        ],
      ),
    );
  }

  Widget sliderImage() {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayCurve: Curves.easeIn,
        padEnds: true,
        height: 27.w,
        pauseAutoPlayOnTouch: true,
        animateToClosest: true,
        autoPlayInterval: Duration(seconds: 3),
      ),
      items: homeController.homeUserDataModel.value?.data.banners
          .map(
            (item) => InkWell(
              onTap: () {},
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: DI<ImageConst>().Loader_Image,
                    placeholderFit: BoxFit.scaleDown,
                    image: "${DI<WebService>().IMAGE_BASE_URL}${item.image}",
                    fit: BoxFit.cover,
                    width: 100.w,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(DI<ImageConst>().USER_DEFALUT,
                          height: 30.sp);
                    },
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget doubleCardView(){
    return  Row(
      children: [
        Expanded(
            flex: 1,
            child: Card(
              color: DI<ColorConst>().whiteColor,
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      DI<StringConst>().matchesProfileText,
                      style: DI<CommonWidget>().myTextStyle(
                          DI<ColorConst>().darkPrimaryColor,
                          18.sp,
                          FontWeight.w500),
                    ),
                    Text(
                      homeController.homeUserDataModel.value?.data.matchesProfile??"",
                      style: DI<CommonWidget>().myTextStyle(
                          DI<ColorConst>().blackColor,
                          17.sp,
                          FontWeight.w400),
                    ),
                  ],
                ),
              ),
            )),
        SizedBox(
          width: 3,
        ),
        Expanded(
            flex: 1,
            child: Card(
              color: DI<ColorConst>().whiteColor,
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      DI<StringConst>().justJoinedText,
                      style: DI<CommonWidget>().myTextStyle(
                          DI<ColorConst>().darkPrimaryColor,
                          18.sp,
                          FontWeight.w500),
                    ),
                    Text(
                      homeController.homeUserDataModel.value?.data.justJoined??"",
                      style: DI<CommonWidget>().myTextStyle(
                          DI<ColorConst>().blackColor,
                          17.sp,
                          FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }

  Widget verificationCard(){
    return  Card(
      color: DI<ColorConst>().whiteColor,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search_rounded,size: 22.sp,color: DI<ColorConst>().redColor ,),
            SizedBox(width: 5,),
            Expanded(
              child: Text(
                DI<StringConst>().yourProfileIsUnderVerificationText,
                maxLines: 5,
                style: DI<CommonWidget>().myTextStyle(
                    DI<ColorConst>().redColor,
                    16.sp,
                    FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showNestedList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: homeController.homeUserListModel.value!.data.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
       var nestedList = homeController.homeUserListModel.value!.data;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nestedList[index].title,
                style: DI<CommonWidget>().myTextStyle(
                    DI<ColorConst>().blackColor, 17.sp, FontWeight.w500),
              ),
              SizedBox(
                height: 5.sp,
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount:nestedList[index].data.length,
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
                  var listData = nestedList[index].data;
                  return InkWell(
                    onTap: ()async {
                      print("isUserDetailFilled :- ${isUserDetailFilled()}");
                      var data = {
                        "userId": listData[indexInner].id.toString(),
                        "isUserDetailFilled": isUserDetailFilled().toString()
                      };
                    var result = await  Get.toNamed(DI<RouteHelper>().getPersonDetailScreen(), parameters: data);

                    if(result == "Complete"){
                      Future.delayed(Duration.zero,() {
                        DI<ConstValue>().fromProfileDetail = true;
                        DI<ConstValue>().currentIndex.value = 3;
                      },);

                    }else if(result == "subscription"){
                      Future.delayed(Duration.zero,() {
                        DI<ConstValue>().fromSubscription = true;
                        DI<ConstValue>().currentIndex.value = 3;
                      },);
                    }
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
                              image: "${DI<WebService>().IMAGE_BASE_URL}${DI<CommonFunction>().getProfileImageFromCommaString(listData[indexInner].profilePictures.toString())}",
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
                                 listData[indexInner].fullName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: DI<CommonWidget>().myTextStyle(
                                    DI<ColorConst>().blackColor,
                                    17.sp,
                                    FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  listData[indexInner].education=="null"?"N/A":listData[indexInner].education,
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: DI<CommonWidget>().myTextStyle(
                                    DI<ColorConst>().blackColor,
                                    15.sp,
                                    FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  listData[indexInner].occupation=="null"?"N/A":listData[indexInner].occupation,
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

            ],
          ),
        );
      }, separatorBuilder: (BuildContext context, int index) {
        return SizedBox();
    },
    );
  }

  bool isUserDetailFilled(){
    var userData = homeController.homeUserDataModel.value?.data.user;
    if(userData?.fullName.toString() != "null"&& userData!.fullName.isNotEmpty &&
        userData.dateOfBirth.toString() != "null"&& userData.dateOfBirth.isNotEmpty &&
        userData.motherToungue.toString() != "null"&& userData.motherToungue.isNotEmpty &&
        userData.maritalStatus.toString() != "null"&& userData.maritalStatus.isNotEmpty &&
        userData.religion.toString() != "null"&& userData.religion.isNotEmpty &&
        userData.country.toString() != "null"&& userData.country.isNotEmpty &&
        userData.state.toString() != "null"&& userData.state.isNotEmpty ){
      return true;
    }

    return false;
  }
}
