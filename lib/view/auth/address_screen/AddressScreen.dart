import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadiviha/controller/auth/AuthController.dart';
import 'package:shaadiviha/model/CountryModel.dart';
import 'package:sizer/sizer.dart';

import '../../../util/ColorConst.dart';
import '../../../util/CommonFunction.dart';
import '../../../util/CommonWidget.dart';
import '../../../util/Injection.dart';
import '../../../util/RouteHelper.dart';
import '../../../util/StringConst.dart';
import '../../../util/local_storage.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  AuthController authController = Get.find<AuthController>();

  late TextEditingController districtCtrl;
  late TextEditingController wardCtrl;
  late TextEditingController panchayatCtrl;
  late TextEditingController policeCtrl;

  var screenType = "";
  var dropCatDownValue = "".obs;
  var deliveryTypeList = ['City', 'Block'];
  List<String> countryNames = [

  ];
  var dropCountryDownValue = "".obs;
  var dropStateDownValue = "".obs;
  var dropDistrictDownValue = "".obs;
  var dropCityDownValue = "".obs;
  var dropBlockDownValue = "".obs;

  var county = Rxn<dynamic>();
  var state = Rxn<dynamic>();
  var district = Rxn<dynamic>();
  var city = Rxn<dynamic>();
  var block = Rxn<dynamic>();

  var countyFromProfile = "";
  var stateFromProfile = "";
  var districtFromProfile = "";
  var cityFromProfile = "";
  var blockFromProfile = "";
  var selectCityBlockFromProfile = "";
  var wardNoFromProfile = "";
  var panchayatFromProfile = "";
  var policeStationFromProfile = "";

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();

    print("screenType :- ${Get.parameters["screenType"]}");
    if (Get.parameters["screenType"] == "profile") {
      screenType = Get.parameters["screenType"]!;
      countyFromProfile = Get.parameters["country"]!;
      stateFromProfile = Get.parameters["state"]!;
      districtFromProfile = Get.parameters["district"]!;
      cityFromProfile = Get.parameters["city"]!;
      blockFromProfile = Get.parameters["block_name"]!;
      selectCityBlockFromProfile = Get.parameters["select_city_block"]!;
      wardNoFromProfile = Get.parameters["ward_no"]!;
      panchayatFromProfile = Get.parameters["panchayat"]!;
      policeStationFromProfile = Get.parameters["police_station"]!;
    }


    print("countyFromProfile :- " +countyFromProfile);
    print("cityFromProfile :- " +cityFromProfile);
    print("blockFromProfile :- " +blockFromProfile);
    print("panchayatFromProfile :- " +panchayatFromProfile);



  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    districtCtrl = TextEditingController();
    wardCtrl = TextEditingController();
    policeCtrl = TextEditingController();
    panchayatCtrl = TextEditingController();
    Future.delayed(Duration.zero,() {
      authController.getCountryList().then((value) {
        if(screenType != "profile"){
          dropCountryDownValue.value = getItemId(authController.countryModel.value,"India"); //authController.countryModel.value!.data.firstWhere((country) => country.name.toLowerCase() == "India".toLowerCase()).id;
        }else{
          dropCountryDownValue.value =getItemId(authController.countryModel.value,countyFromProfile);// authController.countryModel.value!.data.firstWhere((country) => country.name.toLowerCase() == countyFromProfile.toLowerCase()).id;
        }
        print("dropCountryDownValue.value :- ${dropCountryDownValue.value}");
          authController.getStateList(dropCountryDownValue.value).then((value) {
            if(screenType == "profile"){
              dropCatDownValue.value =  selectCityBlockFromProfile;
              dropStateDownValue.value =getItemId(authController.stateModel.value,stateFromProfile); //  authController.stateModel.value!.data.firstWhere((country) => country.name.toLowerCase() == stateFromProfile.toLowerCase()).id;
              wardCtrl.text = wardNoFromProfile;
              panchayatCtrl.text = panchayatFromProfile;
              policeCtrl.text = policeStationFromProfile;
                authController.getDistrictList(dropStateDownValue.value).then((value) {
                  dropDistrictDownValue.value = getItemId(authController.districtModel.value,districtFromProfile); //authController.districtModel.value!.data.firstWhere((country) => country.name.toLowerCase() == districtFromProfile.toLowerCase()).id;

                    if(selectCityBlockFromProfile == "City"){
                      authController.getCityList(dropDistrictDownValue.value).then((value) {
                        dropCityDownValue.value = getItemId(authController.cityModel.value,cityFromProfile); // authController.cityModel.value!.data.firstWhere((country) => country.name.toLowerCase() == cityFromProfile.toLowerCase()).id;
                      },);
                    }else{
                      authController.getBlockList(dropDistrictDownValue.value).then((value) {
                        dropBlockDownValue.value = getItemId(authController.blockModel.value,districtFromProfile);// authController.blockModel.value!.data.firstWhere((country) => country.name.toLowerCase() == districtFromProfile.toLowerCase()).id;
                      },);
                    }
                },);

            }
          },);

      },);
    },);


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DI<CommonWidget>().gradiantBackGround(
            childWidget: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                SizedBox(
                  height: kBottomNavigationBarHeight + 10.sp,
                ),
                Text(
                  DI<StringConst>().locationTxt,
                  style: DI<CommonWidget>().myTextStyle(
                      DI<ColorConst>().blackColor, 23.sp, FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                authController.countryModel.value != null
                    ? dropDownCard(county, DI<StringConst>().enterCountryText,
                        authController.countryModel.value!.data,
                        apiValue:countyFromProfile == ""?"India":countyFromProfile,
                        onChangedValue: (value) {
                          countyFromProfile = "";
                        dropCountryDownValue.value = value ?? "";
                        print("dropCountryDownValue :-- ${dropCountryDownValue.value}");
                        authController.stateModel.value = null;
                        state.value = null;
                        authController.getStateList(dropCountryDownValue.value);
                      })
                    : SizedBox(),
                SizedBox(
                  height: authController.countryModel.value != null ? 10 :0,
                ),
                authController.stateModel.value != null
                    ? dropDownCard(state, DI<StringConst>().enterStateText,
                        authController.stateModel.value!.data,
                        apiValue: stateFromProfile == ""?null:stateFromProfile,
                        onChangedValue: (value) {
                          stateFromProfile = "";
                        dropStateDownValue.value = value ?? "";
                        print("dropStateDownValue :-- ${dropStateDownValue.value}");
                        authController.districtModel.value = null;
                        district.value = null;
                        authController.getDistrictList(dropStateDownValue.value);
                      })
                    : SizedBox(),
                SizedBox(
                  height: authController.stateModel.value != null ? 10 : 0,
                ),
                authController.districtModel.value != null
                    ? dropDownCard(district, DI<StringConst>().enterDistrictText,
      
                    authController.districtModel.value!.data,
                    apiValue: districtFromProfile == ""?null:districtFromProfile,
                    onChangedValue: (value) {
                      districtFromProfile = "";
                      dropDistrictDownValue.value = value ?? "";
                      print("dropDistrictDownValue :-- ${dropDistrictDownValue.value}");
                    })
                    : SizedBox(),
      
                SizedBox(
                  height: authController.districtModel.value != null? 10:0,
                ),
                DI<CommonWidget>().dropDownCard(
                    DI<StringConst>().selectCityBlockText, deliveryTypeList,
                    dpValue: dropCatDownValue.value,
                    apiValue: selectCityBlockFromProfile ==""?null:selectCityBlockFromProfile,
                    onChangedValue: (value) {
                      selectCityBlockFromProfile ="";
                  dropCatDownValue.value = value ?? "";
                  authController.cityModel.value = null;
                  authController.blockModel.value = null;
                  city.value = null;
                  block.value = null;
                  if(value != null){
                    if(value == "City"){
                      authController.getCityList(dropDistrictDownValue.value);
                    }else{
                      authController.getBlockList(dropDistrictDownValue.value);
                    }
                  }
      
                }),
      
                SizedBox(height: 10,),
      
                authController.cityModel.value != null
                    ? dropDownCard(city, DI<StringConst>().enterCityText,
                    authController.cityModel.value!.data,
                    apiValue: cityFromProfile ==""?null:cityFromProfile,
                    onChangedValue: (value) {
                      cityFromProfile = "";
                      dropCityDownValue.value = value ?? "";
                      print("dropCityDownValue :-- ${dropCityDownValue.value}");
                    })
                    : SizedBox(),
      
                SizedBox(
                  height:authController.cityModel.value != null? 10:0,
                ),
      
                authController.blockModel.value != null
                    ? dropDownCard(city, DI<StringConst>().enterBlockText,
                    authController.blockModel.value!.data,
                    apiValue: blockFromProfile ==""?null:blockFromProfile,
                    onChangedValue: (value) {
                      dropBlockDownValue.value = value ?? "";
                      print("dropBlockDownValue :-- ${dropBlockDownValue.value}");
                    })
                    : SizedBox(),
      
                SizedBox(
                  height:authController.blockModel.value != null? 10:0,
                ),
                if(dropCatDownValue.value == "City")
               DI<CommonWidget>().myTextFormField(
                      controller: wardCtrl,
                   DI<StringConst>().enterWardNumberText,
      
                      icon: Icons.location_on,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text),
      
      
                if(dropCatDownValue.value == "Block")
      
                       DI<CommonWidget>().myTextFormField(
                      controller: panchayatCtrl,
                       DI<StringConst>().enterPanchayatText,
                      icon: Icons.location_on,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text),
      
                SizedBox(
                  height: 10,
                ),
                DI<CommonWidget>().myTextFormField(
                    controller: policeCtrl,
                    DI<StringConst>().enterPoliceStationText,
                    icon: Icons.local_police,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text),
                SizedBox(
                  height: 20.sp,
                ),
                DI<CommonWidget>().myButton(DI<StringConst>().done_txt, () {
      
      
                  if (validation()) {
      
                    print("dropCountryDownValue.value : ${dropCountryDownValue.value} \n "
                        "dropStateDownValue.value : ${dropStateDownValue.value} \n "
                        "dropDistrictDownValue.value : ${dropDistrictDownValue.value} \n "
                        "dropCatDownValue.value : ${dropCatDownValue.value} \n "
                        "dropCityDownValue.value : ${dropCityDownValue.value} \n "
                        "dropBlockDownValue.value : ${dropBlockDownValue.value} \n "
                    );
      
                    if( dropCatDownValue.value == "City"){
                      panchayatCtrl.clear();
                      dropBlockDownValue.value = "";
                    }else{
                      wardCtrl.clear();
                      dropCityDownValue.value = "";
                    }
      
                    authController
                        .updateAddress(
                            dropCountryDownValue.value,
                            dropStateDownValue.value,
                        dropDistrictDownValue.value,
                            dropCatDownValue.value,
                        dropCityDownValue.value,
                        dropBlockDownValue.value,
                           wardCtrl.text.trim(),
                            panchayatCtrl.text.trim(),
                            policeCtrl.text.trim())
                        .then(
                      (result) {
                        if (result) {
                          if (screenType != "profile") {
                            DI<MyLocalStorage>()
                                .setBoolValue(DI<MyLocalStorage>().isLogin, true);
                            Get.toNamed(DI<RouteHelper>().getHomeTabScreen());
                            return;
                          }
      
                          Get.back(result: "refresh");
                        }
                      },
                    );
                  }
                }),
                SizedBox(
                  height: 20.sp,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget dropDownCard(Rxn dropdownValue, String hint, List<Datum> items,
      {String? apiValue,void Function(String?)? onChangedValue}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      decoration: BoxDecoration(
        color: DI<ColorConst>().whiteColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: DropdownButton<Datum>(
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
              return DropdownMenuItem<Datum>(
                  value: items,
                  child: Text(
                    items.name,
                    style: DI<CommonWidget>().myTextStyle(
                        DI<ColorConst>().blackColor, 15.sp, FontWeight.w500),
                  ));
            }).toList(),
            onChanged: (Datum? newValue) {
              print("newValue :--- ${newValue?.name.toString()}");

              dropdownValue.value = newValue;
              onChangedValue!(newValue?.id.toString());
            },
          ),
        ),
      ),
    );
  }

  bool validation() {
    if (dropCountryDownValue.value.isEmpty) {
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().enterCountryText.toLowerCase()}");
      return false;
    } else if (dropStateDownValue.value.isEmpty) {
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().enterStateText.toLowerCase()}");
      return false;
    } else if (dropDistrictDownValue.value.isEmpty) {
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().enterDistrictText.toLowerCase()}");
      return false;
    } else if (dropCatDownValue.value.isEmpty) {
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().selectCityBlockText.toLowerCase()}");
      return false;
    } else if (dropCatDownValue.value != "Block" && wardCtrl.text.trim().isEmpty) {
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText}  ${DI<StringConst>().enterWardNumberText.toLowerCase()} ");
      return false;
    }
    else if (dropCatDownValue.value == "Block" && panchayatCtrl.text.trim().isEmpty) {
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText}  ${DI<StringConst>().enterPanchayatText.toLowerCase()}");
      return false;
    }else if (policeCtrl.text.trim().isEmpty) {
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().enterPoliceStationText.toLowerCase()}");
      return false;
    }

    return true;
  }

  String getItemId(CountryModel? modelData,String itemName){
    String id = "";
    if(modelData != null&& itemName.isNotEmpty){
      id =  modelData.data.firstWhere((country) =>
      country.name.toLowerCase() == itemName.toLowerCase()).id;
    }


    return id;
  }

  @override
  void dispose() {
    districtCtrl.dispose();
    wardCtrl.dispose();
    policeCtrl.dispose();
    super.dispose();
    authController.countryModel.value = null;
    authController.stateModel.value = null;
  }
}
