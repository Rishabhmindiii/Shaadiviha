import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadiviha/controller/profile_controller/ProfileController.dart';
import 'package:sizer/sizer.dart';

import '../../../model/ReligionModel.dart';
import '../../../util/ColorConst.dart';
import '../../../util/CommonFunction.dart';
import '../../../util/CommonWidget.dart';
import '../../../util/Injection.dart';
import '../../../util/StringConst.dart';

class SocialDetailScreen extends StatefulWidget {
  const SocialDetailScreen({super.key});

  @override
  State<SocialDetailScreen> createState() => _SocialDetailScreenState();
}

class _SocialDetailScreenState extends State<SocialDetailScreen> {

  ProfileController profileController = Get.find<ProfileController>();
  String motherToungeDownValue = "";
  String maritalStatusDownValue = "";
  String religionDownValue = "";
  String educationValue = "";
  String occupationValue = "";
  String aboutYouValue = "";

 late TextEditingController otherTextCtrl;
 late TextEditingController casteTextCtrl;
 late TextEditingController aboutYouCtrl;

  var casteValue = "".obs;
  List<String> castesList = [
    "Brahmin",
    "Kshatriya",
    "Vaishya",
    "Shudra",
    "Kayastha",
    "Rajput",
    "Yadav",
    "Maratha",
    "Jat",
    "Nair",
    "Reddy",
    "Kamma",
    "Kapoor",
    "Gupta",
    "Agarwal",
    "Baniya",
    "Lingayat",
    "Patel",
    "Naidu",
    "Pandit",
    "Iyer",
    "Iyengar",
    "Kurmi",
    "Scheduled Caste (SC)",
    "Scheduled Tribe (ST)",
    "Other Backward Class (OBC)"
  ];

  List<Map<String, dynamic>>  userInfoList = [
    {
      "title": "Mother Tounge",
      "data": ['Hindi', 'Urdu', 'English', 'Bengali', 'other'],
    },
    {
      "title": "Marital Status",
      "data": [
        'Single',
        'Widower',
        'Divorced',
        'Awaiting Divorce',
        'Separated',
        'Married',
        'Annulled',
        'Other'
      ],
    },
    {
      "title": "Religion",
      "data": [
        'Hindu',
        'Muslim',
        'Jain',
        'Sikh',
        'Parsi',
        'Christian',
        'Buddist',
        'other'
      ],
    },
    {
      "title": "Education",
      "data": [
        '8th Stander',
        '10th Stander',
        '12th Stander',
        'Diploma',
        'Bachelor Degree',
        'Master Degree',
        'Ph.D',
        'Other degree',
      ],
    },
    {
      "title": "Occupation",
      "data": [
        'Student',
        'Not working',
        'Private job',
        'Goverment job',
        'Business',
        'Other work'
      ],
    },
    {
      "title": "About you",
      "data": [
      ],
    }
  ];

  var currentIndex = 0.obs;
  var currentReligionIndex = 0.obs;
  var currentEducationIndex = 0.obs;
  var currentOccupationIndex = 0.obs;
  var screenType = "";
  late PageController _pageController;
  int _activePage = 0;


  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    currentIndex.value = -1;
    currentReligionIndex.value = -1;
    currentOccupationIndex.value = -1;
    currentEducationIndex.value = -1;

    if (Get.parameters["screenType"] != null) {
      screenType = Get.parameters["screenType"]!;
    }

    Future.delayed(Duration.zero,() {

      profileController.getMotherTonguesList();


    },);
    print(screenType);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pageController = PageController();
    otherTextCtrl = TextEditingController();
    casteTextCtrl = TextEditingController();
    aboutYouCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DI<CommonWidget>().gradiantBackGround(
            childWidget: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Obx(
                 () =>  profileController.tempProfileLoading.value?SizedBox.shrink(): Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: kBottomNavigationBarHeight + 10.sp,
                      ),
                      SizedBox(
                        height: 15,
                      ),
      
                      profileController.tempProfileLoading.value?SizedBox.shrink():
                      Expanded(
                        child: PageView.builder(
                            controller: _pageController,
                            itemCount: userInfoList.length,
                            physics: NeverScrollableScrollPhysics(),
                            onPageChanged: (int page) {
                              setState(() {
                                _activePage = page;
                              });
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return gridviewQuestion(
                                userInfoList[index]["title"],
                                _activePage,
                                0,
                                getDynamicList(userInfoList[index]["title"],index),
                                /*userInfoList[index]["title"] == "Religion"?
                                    profileController.religionModel.value?.data
                                    :
                                userInfoList[index]["data"],*/
                                userInfoList.length - 1,
                                onNext: () => onNextPage(),
                                onPrevious: () => onBackPage(),
                              );
                            }),
                      ),
                    ],
                  ),
                ))),
      ),
    );
  }




  ///Gridview select Type
  Widget gridviewQuestion(String title, int currentPageIndex, int currentIndex,
      List<dynamic> dataList, int mainArrayLength,
      {Function()? onNext, Function()? onPrevious}) {

    return StatefulBuilder(builder: (context, setState) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body:  SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  title,
                  style: DI<CommonWidget>().myTextStyle(
                      DI<ColorConst>().blackColor, 23.sp, FontWeight.w500),
                ),
                SizedBox(
                  height: 7,
                ),

               if(title == "Marital Status" && title != "About you")              //other
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dataList.length,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 9,
                      crossAxisSpacing: 9,
                      crossAxisCount: 2,
                      childAspectRatio: 6),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 0,
                            child: Container(
                              height: 19,
                              width: 19,
                              decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? DI<ColorConst>()
                                          .greenColor
                                          .withOpacity(0.5)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: DI<ColorConst>().darkGryColor)),
                            ),
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "${dataList[index]}",
                              style: DI<CommonWidget>().myTextStyle(
                                DI<ColorConst>().blackColor,
                                16.sp,
                                FontWeight.w400,
                              ),
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                //Religion

                if(title != "Marital Status" && dataList.length>1)
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dataList.length,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 9,
                      crossAxisSpacing: 9,
                      crossAxisCount: 2,
                      childAspectRatio: 6),
                  itemBuilder: (context, index) {
                    List<Religion> data = dataList  as List<Religion>;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = index;
                        });
                        if(currentIndex != dataList.length - 1){
                          profileController.getCasteList(data[index].id).then((value) => setState((){}),);
                        }

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 0,
                            child: Container(
                              height: 19,
                              width: 19,
                              decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? DI<ColorConst>()
                                      .greenColor
                                      .withOpacity(0.5)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: DI<ColorConst>().darkGryColor)),
                            ),
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "${data[index].name}",
                              style: DI<CommonWidget>().myTextStyle(
                                DI<ColorConst>().blackColor,
                                16.sp,
                                FontWeight.w400,
                              ),
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),

                if(title == "About you")
                 DI<CommonWidget>().myTextFormField(
                controller: aboutYouCtrl,
                DI<StringConst>().enterAboutYouText,
                icon: Icons.yard_outlined,
                maxLine: null,
                minLine: 5,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
              ),

                SizedBox(
                  height: 7,
                ),
                currentIndex == dataList.length - 1 && dataList.length>1
                    ? DI<CommonWidget>().myTextFormField(
                  controller: otherTextCtrl,
                        DI<StringConst>().pleaseEnterValueTxt,
                        maxLine: null)
                    : SizedBox(),
                SizedBox(
                  height: 20.sp,
                ),
                if (title == "Religion" &&  currentIndex != dataList.length - 1)
                  Text(
                    "Caste",
                    style: DI<CommonWidget>().myTextStyle(
                        DI<ColorConst>().blackColor, 23.sp, FontWeight.w500),
                  ),
                SizedBox(
                  height: 10,
                ),
                if (title == "Religion" &&  currentIndex != dataList.length - 1)
                  DI<CommonWidget>().myTextFormField(
                    controller: casteTextCtrl,
                      DI<StringConst>().pleaseEnterCasteTxt,
                      maxLine: null)
                /*profileController.castProfileLoading.value?SizedBox.shrink():
                  dropDownCard(profileController.casteValueDrop, DI<StringConst>().selectCasteText,
                      profileController.casteModel.value!.data,
                      onChangedValue: (value) {
                        casteValue.value = value ?? "";
                        print("dropCountryDownValue :-- ${  casteValue.value}");
                      })*/
              ],
            ),
          ),

        bottomNavigationBar: SizedBox(
          height: kBottomNavigationBarHeight + 20.sp,
          child: Obx(
           () =>  profileController.tempProfileLoading.value?SizedBox.shrink():Column(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    spacing: 5,
                    children: [
                      currentPageIndex > 0
                          ? Expanded(
                              flex: 1,
                              child: DI<CommonWidget>()
                                  .myButton(DI<StringConst>().previousText, () {
                                onPrevious!();
                              }),
                            )
                          : SizedBox(),
                      Expanded(
                        flex: 1,
                        child: DI<CommonWidget>().myButton(
                            currentPageIndex < mainArrayLength
                                ? DI<StringConst>().nextText
                                : DI<StringConst>().continueText, () {

                          if (currentPageIndex < mainArrayLength) {


                            if(title == "Mother Tounge"){
                              if(currentIndex == dataList.length - 1){
                                motherToungeDownValue = otherTextCtrl.text.trim();
                              }else{
                                motherToungeDownValue = profileController.motherTonguesModel.value?.data[currentIndex].name??"";//dataList[currentIndex];
                              }
                            }
                            else if(title == "Marital Status"){
                              if(currentIndex == dataList.length - 1){
                                maritalStatusDownValue = otherTextCtrl.text.trim();
                              }else{
                                maritalStatusDownValue = dataList[currentIndex];
                              }
                            }
                            else if(title == "Religion"){
                              if(currentIndex == dataList.length - 1){
                                religionDownValue = otherTextCtrl.text.trim();
                              }else{
                                religionDownValue = profileController.religionModel.value?.data[currentIndex].name??"";
                              }


                            }
                            else if(title == "Education"){
                              if(currentIndex == dataList.length - 1){
                                educationValue = otherTextCtrl.text.trim();
                              }else{
                                educationValue =profileController.educationsModel.value?.data[currentIndex].name??""; //dataList[currentIndex];
                              }
                            }
                            else if(title == "Occupation"){
                                if(currentIndex == dataList.length - 1){
                                  occupationValue = otherTextCtrl.text.trim();
                                }else{
                                  occupationValue = profileController.occupationsModel.value?.data[currentIndex].name??"";//dataList[currentIndex];
                                }

                                aboutYouCtrl.text ="We are seeking a suitable match for our son. He is a $maritalStatusDownValue $religionDownValue ${casteValue.value}, fluent in $motherToungeDownValue, educated up to $educationValue, and currently ${occupationValue.toLowerCase().startsWith('a') ? 'an' : 'a'} $occupationValue.";
                              }

                            onNext!();
                          } else {

                            casteValue.value = casteTextCtrl.text.trim();
                            print("$motherToungeDownValue\n $maritalStatusDownValue\n $religionDownValue\n ${casteValue.value}\n $educationValue\n $occupationValue");



                            if(validation()){
                              profileController.updateSocialInfo(
                                  motherToungeDownValue,
                                  maritalStatusDownValue,
                                  religionDownValue,
                                  casteValue.value, educationValue, occupationValue, aboutYouCtrl.text.trim());
                            }

                           // Get.back();
                          }
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  bool validation(){

    if(motherToungeDownValue.isEmpty){
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().motherToungeTxt.toLowerCase()}");
      return false;
    }else if(maritalStatusDownValue.isEmpty){
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().maritalStatusTxt.toLowerCase()}");
      return false;
    }
    else if(religionDownValue.isEmpty){
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().religionTxt.toLowerCase()}");
      return false;
    }else if(educationValue.isEmpty){
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().educationText.toLowerCase()}");
      return false;
    }else if(occupationValue.isEmpty){
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().occupationText.toLowerCase()}");
      return false;
    }

    return true;
  }

  void onNextPage() {
    if (_activePage < userInfoList.length - 1) {
      otherTextCtrl.clear();
      profileController.casteValueDrop.value= null;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
  }

  void onBackPage() {
    if (_activePage > 0) {
      otherTextCtrl.clear();
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
  }


  Widget dropDownCard(Rxn dropdownValue, String hint, List<Religion> items,
      {String? apiValue,void Function(String?)? onChangedValue}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: BoxDecoration(
        color: DI<ColorConst>().whiteColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Obx(
            () => DropdownButtonHideUnderline(
          child: DropdownButton<Religion>(
            elevation: 0,
            isExpanded: true,
            value: dropdownValue.value,
            hint: Text(apiValue??hint,
                style: DI<CommonWidget>().myTextStyle(
                    DI<ColorConst>().darkGryColor, 15.sp, FontWeight.w500)),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: DI<ColorConst>().darkGryColor,
            ),
            items: items.map((items) {
              return DropdownMenuItem<Religion>(
                  value: items,
                  child: Text(
                    items.name,
                    style: DI<CommonWidget>().myTextStyle(
                        DI<ColorConst>().blackColor, 15.sp, FontWeight.w500),
                  ));
            }).toList(),
            onChanged: (Religion? newValue) {
              print("newValue :--- ${newValue?.name.toString()}");

              dropdownValue.value = newValue;
              onChangedValue!(newValue?.name.toString());
            },
          ),
        ),
      ),
    );
  }


  List<dynamic> getDynamicList(String title,int index){
    if(title == "Mother Tounge"){
      return profileController.motherTonguesModel.value?.data??[];
    }else if(title == "Religion"){
      return profileController.religionModel.value?.data??[];
    }else if(title == "Education"){
      return profileController.educationsModel.value?.data??[];
    }else if(title == "Occupation"){
      return profileController.occupationsModel.value?.data??[];
    }
    else{

      print(title);
      return  userInfoList[index]["data"];
    }

  }

  @override
  void dispose() {
    otherTextCtrl.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
