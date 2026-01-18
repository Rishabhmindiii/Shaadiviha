import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:country_picker/country_picker.dart' as CP;


import 'ColorConst.dart';
import 'CommonWidget.dart';
import 'Injection.dart';
import 'StringConst.dart';

class CommonFunction {
  /// hide key board
  void hideKeyboard() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  ///Show loader
  void showLoading() {
    EasyLoading.show(
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
      indicator: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        backgroundColor: Colors.white,
      ),
    );
  }

  ///Hide loader
  void hideLoader() {
    EasyLoading.dismiss();
  }

  ///to Pick image from bottom sheet

  Future<File?> selectImage() async {
    File? imageFile;
    await showModalBottomSheet(
      context: Get.context!,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      elevation: 5.0,
      isDismissible: false,
      builder: (context) {
        return SizedBox(
          height: 20.h,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    Icons.cancel,
                    color: Colors.grey,
                    size: 22,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      var file = await DI<CommonFunction>().pickImage(ImageSource.camera);
                      print(">>>>>> $file");
                      print(">camera>>>>> ${file?.path}");
                      Get.back();
                      imageFile = File(file!.path);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          color: DI<ColorConst>().secondColorPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Icon(
                              Icons.camera_alt,
                              color: DI<ColorConst>().whiteColor,
                              size: 30,
                            ),
                          ),
                        ),
                        Text(
                          DI<StringConst>().cameraTxt,
                          style: DI<CommonWidget>().myTextStyle(
                              DI<ColorConst>().blackColor,
                              15.sp,
                              FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      var file = await DI<CommonFunction>().pickImage(ImageSource.gallery);
                      print(">>>>>> $file");
                      print(">gallery>>>>> ${file?.path}");
                      Get.back();
                      imageFile = File(file!.path);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          color:DI<ColorConst>().secondColorPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Icon(
                              Icons.image,
                              color: DI<ColorConst>().whiteColor,
                              size: 30,
                            ),
                          ),
                        ),
                        Text(
                          DI<StringConst>().galleryTxt,
                          style: DI<CommonWidget>().myTextStyle(
                              DI<ColorConst>().blackColor,
                              15.sp,
                              FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    return imageFile;
  }

  Future<CroppedFile?> pickImage(ImageSource imageSource) async {
    XFile? imageFile =
    await ImagePicker().pickImage(source: imageSource, imageQuality: 40);
    print("pickImage File :--  ${imageFile?.path}");

    if (imageFile != null) {

      // Crop the image
      CroppedFile? croppedFile = await _cropImage(imageFile.path);

      print("Cropped Image Path: ${croppedFile?.path}");

      return croppedFile;

    }
    return null;
  }


  ///For Cropping Image
  Future<CroppedFile?> _cropImage(filePath) async {
    CroppedFile? cropImage = await ImageCropper.platform.cropImage(
        sourcePath: filePath,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));

    return cropImage;
  }


  ///Show toast
  void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message,style: DI<CommonWidget>().myTextStyle(DI<ColorConst>().whiteColor,
            15.sp, FontWeight.w500),),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 5.0,
        backgroundColor: DI<ColorConst>().secondColorPrimary.withOpacity(0.5),
      ),
    );
  }

  /*///Location permission
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar('Location services are disabled. Please enable the services');

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showSnackBar('Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }


  ///To get Current Lat long
  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
     print("Current lat - long :-- $position");
     _getAddressFromLatLng(position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      print( '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}');
      DI<ConstValue>().currentAddress.value = '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
    }).catchError((e) {
      debugPrint(e);
    });
  }*/


///Country Picker
  Future<void> selectCountryPicker(void Function(CP.Country) onSelectCP) async {
    CP.showCountryPicker(
        context: Get.context!,
        showPhoneCode: true,
        countryListTheme: CP.CountryListThemeData(borderRadius: BorderRadius.circular(7),textStyle: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
            inputDecoration: InputDecoration(
              hintText: DI<StringConst>().searchTxt,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            )
        ),
        onSelect: onSelectCP);
  }

  /// To get country emoji
  String countryCodeToEmoji(String countryCode) {
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }


  ///To convert in date format
  String ddMMYYConvert(DateTime dateTime) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    var inputDate = inputFormat.format(dateTime);
    return inputDate;
  }

  ///to open date picker like ios
  void showIosDatePicker(Function(DateTime) onDateTimeChanged,Function(DateTime) onDoneClick, {Function()? selectedDate}) {
    DateTime doneDate =  DateTime.now() ;

    showCupertinoModalPopup(
      context: Get.context!,
      barrierColor: Colors.black12.withOpacity(0.5),
      builder: (_) => Container(
        height: 100.h / 3,
        color: Colors.white,
        child: Scaffold(
          backgroundColor:Colors.white ,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,top: 10),
                        child: Text(
                          DI<StringConst>().cancel_txt.tr,
                          style: DI<CommonWidget>().myTextStyle(
                              DI<ColorConst>().blackColor,
                              16.sp,
                              FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,right: 5),
                      child: Text(
                        DI<StringConst>().selectDateTxt,
                        style: DI<CommonWidget>().myTextStyle(
                            DI<ColorConst>().blackColor,
                            16.sp,
                            FontWeight.w500),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        onDoneClick(doneDate);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10,top: 10),
                        child: Text(
                          DI<StringConst>().done_txt.tr,
                          style: DI<CommonWidget>().myTextStyle(
                              DI<ColorConst>().blackColor,
                              16.sp,
                              FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  backgroundColor: DI<ColorConst>().whiteColor,
                  showDayOfWeek: true,
                  initialDateTime: DateTime.now(),
                  maximumDate: DateTime(2050, 12, 30),
                  minimumDate: DateTime(1869, 1, 1),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (value) {
                    doneDate = value;
                    onDateTimeChanged(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  ///to get zeroth index image from comma separate String
  String getProfileImageFromCommaString(String profileImage){
    String? firstImage = "";
    if(profileImage.isNotEmpty){
      List<String> imageList = profileImage
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      firstImage =  imageList.isNotEmpty ? imageList[0] : "";

      print('First image: $firstImage');
    }


    return firstImage;
  }

}
