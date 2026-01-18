import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shaadiviha/util/CommonFunction.dart';
import 'package:sizer/sizer.dart';
import 'package:country_picker/country_picker.dart' as CP;

import 'ColorConst.dart';
import 'ImageConst.dart';
import 'Injection.dart';
import 'StringConst.dart';

class CommonWidget {
  CP.Country? countryPicker;

  TextStyle myTextStyle(Color txtColor, double size, FontWeight fw) {
    return TextStyle(
        color: txtColor,
        fontSize: size,
        fontWeight: fw,
        overflow: TextOverflow.ellipsis);
  }

  TextFormField myTextFormField(String hintText,
      {TextEditingController? controller,
      TextInputAction? textInputAction,
      TextInputType? textInputType,
      IconData? icon,
        bool? readMode,
      int? maxLine,int? minLine,
        void Function()? onClick
      }) {
    return TextFormField(
      controller: controller,
      readOnly: readMode??false,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      maxLines: maxLine,
      minLines: minLine,
      onTap: onClick,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        fillColor: DI<ColorConst>().whiteColor.withOpacity(0.7),
        filled: true,
        hintText: hintText,
        border: InputBorder.none,
        hintStyle: DI<CommonWidget>()
            .myTextStyle(DI<ColorConst>().darkGryColor, 15.sp, FontWeight.w400),
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        prefixIcon:icon==null?null: Icon(icon),
      ),
    );
  }

  Widget myButton(String buttonText, void Function() onClick) {
    return SizedBox(
      width: 100.sp,
      child: ElevatedButton(
        onPressed: onClick,
        style: ButtonStyle(
            elevation: WidgetStatePropertyAll(3.0),
            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 15)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side:
                    BorderSide(color: DI<ColorConst>().whiteColor, width: 1.3),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(
                DI<ColorConst>().darkPrimaryColor.withOpacity(0.7))),
        child: Text(
          buttonText,
          style: DI<CommonWidget>().myTextStyle(
              DI<ColorConst>().colorPrimary, 16.sp, FontWeight.w500),
        ),
      ),
    );
  }


  ///Gradient Appbar
  PreferredSizeWidget gradientAppbar(String title,{Widget? backIcon,Widget? search,}){
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [DI<ColorConst>().secondColorPrimary, DI<ColorConst>().darkPrimaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      leading: backIcon,
      title: Text(
        title,
        style: DI<CommonWidget>().myTextStyle(
            DI<ColorConst>().whiteColor, 20.sp, FontWeight.w700),
      ),
      centerTitle: true,
      actions: [
        search==null?IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: () {

          },
        ):Icon(null),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  ///To Show Alert Dialog
  Future errorDialog(String errorMsg, Function() onClick) {
    return showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 3,
              insetPadding: EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              child: Container(
                width: 100.w,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DI<StringConst>().alert_txt,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.cancel,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 17.sp,
                    ),
                    Image.asset(
                      DI<ImageConst>().ALERT_ICON,
                      height: 35.sp,
                    ),
                    SizedBox(
                      height: 17.sp,
                    ),
                    Text(
                      errorMsg,
                      maxLines: 10,
                      textAlign: TextAlign.center,
                      style: DI<CommonWidget>().myTextStyle(
                          DI<ColorConst>().blackColor, 15.sp, FontWeight.w500),
                    ),
                    SizedBox(
                      height: 17.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 46.sp),
                      child: DI<CommonWidget>()
                          .myButton(DI<StringConst>().okText, onClick),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  ///To Show No Record Found
  Widget noRecordFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(DI<ImageConst>().NO_RECORD_FOUND),
        Center(
          child: Text(
            DI<StringConst>().no_result_found_txt,
            style: DI<CommonWidget>().myTextStyle(
                DI<ColorConst>().blackColor, 17.sp, FontWeight.w500),
          ),
        )
      ],
    );
  }

  ///Gradiant BackGround
  Widget gradiantBackGround({Widget? childWidget}) {
    return Container(
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            DI<ColorConst>().colorPrimary,
            DI<ColorConst>().darkPrimaryColor,
          ])),
      child: childWidget,
    );
  }

  ///To show app name
  Widget appNameStyleText({double? fontSize}) {
    return Text(
      DI<StringConst>().appName,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: DI<ColorConst>().darkPrimaryColor,
          fontWeight: FontWeight.w800,
          fontFamily: "WinkyRough",
          fontSize: fontSize,
          decoration: TextDecoration.none),
    );
  }

  ///textField for password
  Widget passwordTextFromFiled(String hint, RxBool obscureText,
      {TextEditingController? controller, TextInputAction? textInputAction}) {
    return Obx(
      () => TextFormField(
        controller: controller,
        obscureText: obscureText.value,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          fillColor: DI<ColorConst>().whiteColor.withOpacity(0.7),
          filled: true,
          hintText: hint,
          border: InputBorder.none,
          hintStyle: DI<CommonWidget>().myTextStyle(
              DI<ColorConst>().darkGryColor, 15.sp, FontWeight.w400),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          prefixIcon: Icon(Icons.password),
          suffixIcon: InkWell(
              onTap: () {
                obscureText.value = !obscureText.value;
              },
              child: Icon(
                obscureText.value ? Icons.visibility : Icons.visibility_off,
                size: 23,
              )),
        ),
      ),
    );
  }

  ///Country picker text From
  Widget countryPickerTextFrom() {
    return SizedBox(
        height: 29.sp,
        child: StatefulBuilder(
          builder: (context, setState) {
            return Card(
              color: DI<ColorConst>().whiteColor.withOpacity(0.7),
              elevation: 0.0,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 0,
                      child: InkWell(
                        onTap: () {
                          DI<CommonFunction>().selectCountryPicker(
                            (country) {
                              countryPicker = country;
                              setState(
                                () {},
                              );
                            },
                          );
                        },
                        child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              countryPicker == null
                                  ? Text(
                                      "${DI<CommonFunction>().countryCodeToEmoji("IN")} +91",
                                      style: TextStyle(fontSize: 16.sp),
                                    )
                                  : Text(
                                      "${DI<CommonFunction>().countryCodeToEmoji(countryPicker?.countryCode ?? "IN")} ${countryPicker!.phoneCode}",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                              Icon(
                                Icons.arrow_drop_down_sharp,
                                size: 22.sp,
                                color: DI<ColorConst>().darkGryColor,
                              ),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10.0, 10.0, 10.0),
                      child: VerticalDivider(
                        color: DI<ColorConst>().darkGryColor,
                        thickness: 1,
                        width: 0,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        cursorColor: DI<ColorConst>().gryColor,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: DI<StringConst>()
                                .enter_mobile_Text
                                .toLowerCase(),
                            hintStyle: DI<CommonWidget>().myTextStyle(
                                DI<ColorConst>().darkGryColor,
                                15.sp,
                                FontWeight.w400),
                            contentPadding: EdgeInsets.symmetric(vertical: 0)),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }


  ///Custom Drop-down
  Widget dropDownCard(String hint,List<dynamic> items,{String? apiValue,String? dpValue,void Function(String?)? onChangedValue}){
    String? dropdownValue =dpValue ?? "";
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
      decoration: BoxDecoration(
        color:DI<ColorConst>().whiteColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(0.0),

      ),
      child: StatefulBuilder(
          builder: (context, setState) {
            return DropdownButtonHideUnderline(
              child: DropdownButton(
                elevation: 0,
                isExpanded: true,
                value: dropdownValue!.isEmpty?null:dropdownValue,
                hint: Text(apiValue??hint,style:  DI<CommonWidget>()
                    .myTextStyle(DI<ColorConst>().darkGryColor, 15.sp, FontWeight.w500)),
                icon: Icon(Icons.keyboard_arrow_down,color: DI<ColorConst>().darkGryColor,),
                items:items.map((items) {
                  return DropdownMenuItem(
                      value: items,
                      child: Text(items.toString(),style:  DI<CommonWidget>()
                          .myTextStyle(DI<ColorConst>().blackColor, 15.sp, FontWeight.w500),)
                  );
                }
                ).toList(),
                onChanged: (newValue){
                  print("newValue :--- $newValue");
                  apiValue ="";
                  setState(() {
                    dropdownValue = newValue.toString();
                  });
                  onChangedValue!(newValue.toString());
                },

              ),
            );
          }
      ),
    );
  }



}
