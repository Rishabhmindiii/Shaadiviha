import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadiviha/controller/auth/AuthController.dart';
import 'package:sizer/sizer.dart';

import '../../../util/ColorConst.dart';
import '../../../util/CommonFunction.dart';
import '../../../util/CommonWidget.dart';
import '../../../util/Injection.dart';
import '../../../util/StringConst.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  AuthController authController = Get.find<AuthController>();
  var obscureText = true.obs;
  var obscureConfirmText = true.obs;
  late  TextEditingController newPasswordCtrl;
  late  TextEditingController confirmPasswordCtrl;
  String userEmail = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newPasswordCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();

    if(Get.parameters["userEmail"] != null){
      userEmail = Get.parameters["userEmail"]??"";
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        body:  DI<CommonWidget>().gradiantBackGround(
        childWidget:SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kBottomNavigationBarHeight,
              ),
              InkWell(
                onTap: (){
                  Get.back();
                }
                ,
                child:  Icon(Icons.arrow_back_ios,color: DI<ColorConst>().blackColor,),
              ),
              SizedBox(
                height: 20,
              ),
              Text(DI<StringConst>().updatePasswordText,
                style: DI<CommonWidget>().myTextStyle(
                    DI<ColorConst>().blackColor, 21.sp, FontWeight.w600),),

              SizedBox(
                height: 15.w,
              ),
              Text(
                  "${DI<StringConst>().pleaseText} ${DI<StringConst>().enterNewPasswordText}"),
              passwordTextFromFiled(newPasswordCtrl, obscureText,DI<StringConst>().enter_new_password_Text.toLowerCase()),
              SizedBox(
                height: 20,
              ),
              Text(
                  "${DI<StringConst>().pleaseText} ${DI<StringConst>().enterConformPasswordText}"),
              passwordTextFromFiled(confirmPasswordCtrl, obscureConfirmText,DI<StringConst>().enter_new_password_Text.toLowerCase()),



              SizedBox(
                height: 15.w,
              ),
              DI<CommonWidget>().myButton(DI<StringConst>().done_txt, () {
                if(validation()){
                  authController.resetPassword(userEmail, newPasswordCtrl.text.trim(), confirmPasswordCtrl.text.trim());
                }
              }),
            ],
          ),

        )),
      ),
    );
  }


  Widget passwordTextFromFiled(TextEditingController passwordCtrl, obscureText,String hint) {
    return Obx(
          () => TextFormField(
        controller: passwordCtrl,
        obscureText: obscureText.value,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          fillColor: DI<ColorConst>().whiteColor.withOpacity(0.7),
          filled: true,
          hintText:hint ,
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


  bool validation(){

    if(newPasswordCtrl.text.trim().isEmpty){
      DI<CommonFunction>().showSnackBar(" ${DI<StringConst>().pleaseText} ${DI<StringConst>().enterNewPasswordText}");
      return false;
    }else if(confirmPasswordCtrl.text.trim().isEmpty){
      DI<CommonFunction>().showSnackBar(" ${DI<StringConst>().please_enter_confim_password_Text}");
      return false;
    }else if(confirmPasswordCtrl.text.trim() != newPasswordCtrl.text.trim()){
      DI<CommonFunction>().showSnackBar(" ${DI<StringConst>().bothPasswordShouldSameText}");
      return false;
    }else{

      return true;
    }
  }
}
