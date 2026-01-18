import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadiviha/controller/profile_controller/ProfileController.dart';
import 'package:shaadiviha/util/CommonFunction.dart';
import 'package:shaadiviha/util/RouteHelper.dart';
import 'package:sizer/sizer.dart';

import '../../../util/ColorConst.dart';
import '../../../util/CommonWidget.dart';
import '../../../util/ConstValue.dart';
import '../../../util/Injection.dart';
import '../../../util/StringConst.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  ProfileController profileController = Get.find<ProfileController>();
  var screenType = "";
  late TextEditingController fullNameCtrl;
  late TextEditingController dobCtrl;
  late TextEditingController aboutYouCtrl;
  String dropValueApiHeight = "";

  List<String> heightList = [
    "4 ft 0.1 in",
    "4 ft 1 in",
    "4 ft 2 in",
    "4 ft 3 in",
    "4 ft 4 in",
    "4 ft 5 in",
    "4 ft 6 in",
    "4 ft 7 in",
    "4 ft 8 in",
    "4 ft 9 in",
    "4 ft 10 in",
    "4 ft 11 in",
    "5 ft 0 in",
    "5 ft 1 in",
    "5 ft 2 in",
    "5 ft 3 in",
    "5 ft 4 in",
    "5 ft 5 in",
    "5 ft 6 in",
    "5 ft 7 in",
    "5 ft 8 in",
    "5 ft 9 in",
    "5 ft 10 in",
    "5 ft 11 in",
    "6 ft 0 in",
    "6 ft 1 in",
    "6 ft 2 in",
    "6 ft 3 in",
    "6 ft 4 in",
    "6 ft 5 in",
    "6 ft 6 in",
    "6 ft 7 in",
    "6 ft 8 in",
    "6 ft 9 in",
    "6 ft 10 in",
    "6 ft 11 in",
    "7 ft 0 in",
    "7 ft 1 in",
    "7 ft 2 in",
    "7 ft 3 in",
    "7 ft 4 in",
    "7 ft 5 in",
    "7 ft 6 in",
    "7 ft 7 in",
    "7 ft 8 in",
    "7 ft 9 in",
    "7 ft 10 in",
    "7 ft 11 in",
    "8 ft 0 in",
    "8 ft 1 in",
    "8 ft 2 in",
  ];
  var heightDownValue = "".obs;

  List<String> interests = [
    "Reading books",
    "Travelling",
    "Gym/working out",
    "Yoga/meditation",
    "Coding",
    "Gaming",
    "Adventure travel",
    "Trying new cuisines",
    "Bollywood movies",
    "Animal lover",
    "Photography",
    "Blogging/vlogging",
    "Watching sports",
    "Dancing",
    "Music (listening/playing instruments)",
    "Painting/drawing",
    "Hiking/trekking",
    "Volunteering",
    "Gardening",
    "Baking/cooking",
    "Learning languages",
    "Board games",
    "Crafting/DIY projects",
    "Watching documentaries",
    "Astrology",
    "Fashion and styling",
    "Interior design",
    "Public speaking",
    "Self-improvement",
    "Podcasts/audiobooks",
    "Martial arts",
    "Surfing",
    "Camping",
    "Tech gadgets",
    "Virtual reality",
    "Wine tasting",
    "Social media content creation",
    "Stand-up comedy",
    "Bird watching"
  ];
  List<bool> selectedInterests = [];
  List<String> selectInterestsList = [];

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    DI<ConstValue>().fromProfileDetail = false;
    if (Get.parameters["screenType"] != null) {
      screenType = Get.parameters["screenType"]!;
    }
    print(screenType);
    selectedInterests = List.generate(interests.length, (index) => false);
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fullNameCtrl = TextEditingController();
    dobCtrl = TextEditingController();
    aboutYouCtrl = TextEditingController();
    if (Get.parameters["fullName"].toString() != "null") {
      fullNameCtrl.text = Get.parameters["fullName"]??"";
      dobCtrl.text = Get.parameters["dob"] == "null"?"":Get.parameters["dob"]??"";
     dropValueApiHeight = Get.parameters["height"] == "null"?"":Get.parameters["height"]??"";
      heightDownValue.value = Get.parameters["height"] == "null"?"": Get.parameters["height"]??"";
      updateSelectedInterests(Get.parameters["interest"]??"");
      aboutYouCtrl.text = Get.parameters["aboutYou"]??"";
    }
  }
  void updateSelectedInterests(String selected) {
    List<String> selectedItems = selected.split(',').map((e) => e.trim()).toList();

    for (int i = 0; i < interests.length; i++) {
      if (selectedItems.contains(interests[i])) {
        selectedInterests[i] = true;
        selectInterestsList.add(interests[i]);
      }
    }
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              SizedBox(
                height: kBottomNavigationBarHeight + 10.sp,
              ),
              Text(
                DI<StringConst>().personalDetailTxt,
                style: DI<CommonWidget>().myTextStyle(
                    DI<ColorConst>().blackColor, 23.sp, FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              DI<CommonWidget>().myTextFormField(
                  controller: fullNameCtrl,
                  DI<StringConst>().enterFullNameText,
                  icon: Icons.person,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text),
              SizedBox(
                height: 10,
              ),
              DI<CommonWidget>().myTextFormField(
                  controller: dobCtrl,
                  DI<StringConst>().enterDateOfBirthText,
                  icon: Icons.calendar_month,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  readMode: true, onClick: () {
                DI<CommonFunction>().showIosDatePicker(
                  (dateTime) {
                    print(DI<CommonFunction>().ddMMYYConvert(dateTime));
                  },
                  (doneDate) {
                    dobCtrl.text = DI<CommonFunction>().ddMMYYConvert(doneDate);
                    Get.back();
                  },
                );
              }),
              SizedBox(
                height: 10,
              ),
              DI<CommonWidget>()
                  .dropDownCard(DI<StringConst>().enterHeightText, heightList,apiValue: heightDownValue.value.isEmpty?null: heightDownValue.value,
                      onChangedValue: (value) {
                heightDownValue.value = value ?? "";
              }),
      
              SizedBox(
                height: 10,
              ),
              Text(
                DI<StringConst>().selectInterestText,
                style: DI<CommonWidget>().myTextStyle(
                    DI<ColorConst>().blackColor, 17.sp, FontWeight.w400),
              ),
              interestGridView(),
      
              SizedBox(
                height: 10,
              ),
             /* DI<CommonWidget>().myTextFormField(
                controller: aboutYouCtrl,
                DI<StringConst>().enterAboutYouText,
                icon: Icons.yard_outlined,
                maxLine: null,
                minLine: 5,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
              ),*/
              SizedBox(
                height: 20.sp,
              ),
              DI<CommonWidget>().myButton(
                  screenType == "profile"
                      ? DI<StringConst>().done_txt
                      : DI<StringConst>().continueText, () {
                if (screenType == "profile") {
                 if(validation()){
                   profileController
                       .updatePersonalDetail(
                       fullNameCtrl.text.trim(), dobCtrl.text.trim(),
                       heightDownValue.value, selectInterestsList.join(","), aboutYouCtrl.text.trim());
                 }
      
                } else {
                  Get.toNamed(DI<RouteHelper>().getSocialDetailScreen());
                }
              }),
              SizedBox(
                height: 20.sp,
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget interestGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: interests.length,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 9,
          crossAxisSpacing: 9,
          crossAxisCount: 2,
          childAspectRatio: 6),
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 0,
              child: Checkbox(
                value: selectedInterests[index],
                onChanged: (bool? value) {
                  setState(() {
                    selectedInterests[index] = value!;
                    print(interests[index]);
                    if (selectInterestsList.contains(interests[index])) {
                      selectInterestsList.remove(interests[index]);
                    } else {
                      selectInterestsList.add(interests[index]);
                    }
                  });
                },
                visualDensity: VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(
                interests[index],
                style: DI<CommonWidget>().myTextStyle(
                  DI<ColorConst>().blackColor,
                  16.sp,
                  FontWeight.w400,
                ),
                maxLines: 1,
              ),
            )
          ],
        );
      },
    );
  }

  bool validation() {
    if (fullNameCtrl.text.trim().isEmpty) {
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().enterFullNameText.toLowerCase()}");
      return false;
    } else if (dobCtrl.value.text.trim().isEmpty) {
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().enterDateOfBirthText.toLowerCase()}");
      return false;
    } else if (heightDownValue.value.isEmpty) {
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().enterHeightText.toLowerCase()}");
      return false;
    } else if (selectInterestsList.isEmpty) {
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().selectInterestText.toLowerCase()}");
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    fullNameCtrl.dispose();
    dobCtrl.dispose();
    aboutYouCtrl.dispose();
    super.dispose();
  }
}
