import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaadiviha/controller/profile_controller/ProfileController.dart';
import 'package:shaadiviha/util/RouteHelper.dart';
import 'package:sizer/sizer.dart';

import '../../../util/ColorConst.dart';
import '../../../util/CommonFunction.dart';
import '../../../util/CommonWidget.dart';
import '../../../util/Injection.dart';
import '../../../util/StringConst.dart';

class AddPhotoScreen extends StatefulWidget {
  const AddPhotoScreen({super.key});

  @override
  State<AddPhotoScreen> createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  ProfileController profileController = Get.find<ProfileController>();
  var screenType = "";
  var imageFile = Rxn<File>();
  var imageList = <File>[].obs;
  String profileImage = "";

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    if (Get.parameters["screenType"] != null) {
      screenType = Get.parameters["screenType"]!;
      profileImage = Get.parameters["profile_image"]??"";

    }
    print(screenType);
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DI<CommonWidget>().gradiantBackGround(
            childWidget: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 5,
            children: [
              SizedBox(
                height: kBottomNavigationBarHeight + 10.sp,
              ),
              Text(
                DI<StringConst>().addPhotoText,
                style: DI<CommonWidget>().myTextStyle(
                    DI<ColorConst>().blackColor, 23.sp, FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                DI<StringConst>().addPhotoInfoText,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: DI<CommonWidget>().myTextStyle(
                    DI<ColorConst>().blackColor, 17.sp, FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => InkWell(
                  onTap: () async {
                    /*   print("Pick image");
                        await DI<CommonFunction>().selectImage().then(
                        (value) {
                        if(value!=null ){
                        imageFile.value = value;
                        }},);*/
                  },
                  child: Stack(children: [
                    Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: DI<ColorConst>().darkGryColor,
                          )),
                      child: imageList.isNotEmpty
                          ? Image.file(
                              imageList[0],
                              height: 45.sp,
                              width: 45.sp,
                              fit: BoxFit.contain,
                            )
                          : Center(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 35.sp,
                                color: DI<ColorConst>().darkGryColor,
                              ),
                            ),
                    ),
                    imageList.isNotEmpty?
                    Positioned(
                        top: 2,
                        right: 2,
                        child: InkWell(
                            onTap: () {
                              imageList.removeAt(0);
                            },
                            child: CircleAvatar(
                                radius: 11,
                                backgroundColor: DI<ColorConst>().whiteColor,
                                child: Icon(
                                  Icons.delete,
                                  color: DI<ColorConst>().redDulColor,
                                  size: 17,
                                )))):SizedBox(),
                  ]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              addImageCard(),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 100.sp,
                child: ElevatedButton(
                  onPressed: () async {
                    if (imageList.isNotEmpty) {
                      profileController.uploadProfile(imageList.value);
                    } else {
                      DI<CommonFunction>()
                          .showSnackBar(DI<StringConst>().pleaseSelectImageText);
                    }
                  },
                  style: ButtonStyle(
                      elevation: WidgetStatePropertyAll(3.0),
                      padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 15)),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(
                              color: DI<ColorConst>().whiteColor, width: 1.3),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                          DI<ColorConst>().lightGreenColor.withOpacity(0.7))),
                  child: Text(
                    DI<StringConst>().uploadFromPhoneText,
                    style: DI<CommonWidget>().myTextStyle(
                        DI<ColorConst>().colorPrimary, 16.sp, FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        )),
        floatingActionButton: FloatingActionButton(onPressed: (){
          DI<CommonFunction>().selectImage().then(
                (valueFile) {
              if (valueFile != null) {
                imageList.add(valueFile!);
              }
            },
          );
        },child: Icon(
          Icons.add,
          color: DI<ColorConst>().blackColor,
        ),),
        bottomNavigationBar: Container(
          color: DI<ColorConst>().darkPrimaryColor,
          height: kBottomNavigationBarHeight,
          width: 100.w,
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              screenType == "profile"
                  ? Get.back()
                  : Get.offAllNamed(DI<RouteHelper>().getLoginScreen());
            },
            child: Text(
              DI<StringConst>().iWillDoThisLaterText,
              style: DI<CommonWidget>().myTextStyle(
                  DI<ColorConst>().whiteColor, 17.sp, FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }

  Widget addImageCard() {
    return SizedBox(
      height: 40.sp,
      child: Obx(
        () =>  Row(
          children: [
            Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount:imageList.isNotEmpty? imageList.length - 1:imageList.length,
                  itemBuilder: (context, index) {
                    return Stack(children: [
                      Image.file(imageList[index + 1]),
                      Positioned(
                          top: 2,
                          right: 2,
                          child: InkWell(
                              onTap: () {
                                imageList.removeAt(index + 1);
                              },
                              child: CircleAvatar(
                                  radius: 11,
                                  backgroundColor: DI<ColorConst>().whiteColor,
                                  child: Icon(
                                    Icons.delete,
                                    color: DI<ColorConst>().redDulColor,
                                    size: 17,
                                  )))),
                    ]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 5,
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  void stringToImageList(){
    List<String> imageList = profileImage
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();


  }
}
