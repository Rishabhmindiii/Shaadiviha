import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:shaadiviha/util/CommonFunction.dart';
import 'package:sizer/sizer.dart';

import '../../controller/home_controller/HomeController.dart';
import '../../network/WebService.dart';
import '../../util/ColorConst.dart';
import '../../util/CommonWidget.dart';
import '../../util/ImageConst.dart';
import '../../util/Injection.dart';
import '../../util/RouteHelper.dart';
import '../../util/StringConst.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  HomeController homeController = Get.find<HomeController>();

  final Debouncer _debouncer = Debouncer(delay: Duration(milliseconds: 500));
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    homeController.userListModel.value = null;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Expanded(
                flex: 1,
                child: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: DI<ColorConst>().gryLightColor,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: "${DI<StringConst>().searchText}..."),
                  onChanged: (value){
                    _debouncer.call(() {
                      print("value :--- $value");
                      if(value.isNotEmpty){
                        homeController.getUserList(value);
                      }else{
                        homeController.userListModel.value = null;
                      }
                    },);
      
                  },
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  flex: 0,
                  child: InkWell(
                    onTap: () {
                      DI<CommonFunction>().hideKeyboard();
                    },
                    child: Icon(Icons.search_rounded),
                  ))
            ],
          ),
        ),
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
                                      image: "${DI<WebService>().IMAGE_BASE_URL}""${DI<CommonFunction>().getProfileImageFromCommaString(listData?[indexInner].profilePictures.toString()??"")}",
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
