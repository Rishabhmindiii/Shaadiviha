import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadiviha/controller/auth/AuthController.dart';
import 'package:shaadiviha/util/ColorConst.dart';
import 'package:shaadiviha/util/CommonFunction.dart';
import 'package:shaadiviha/util/StringConst.dart';
import 'package:sizer/sizer.dart';

import '../../../util/CommonWidget.dart';
import '../../../util/Injection.dart';
import '../../../util/RouteHelper.dart';

class SignupScreen extends StatefulWidget {

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  AuthController authController = Get.find<AuthController>();
  var obscureText = true.obs;
  var obscureText2 = true.obs;
  var _groupValue = 0.obs;
  var dropProfileForDownValue = "".obs;
  var deliveryTypeList =  ['Self','Son','Daughter','Brother','Sister','Friend','Relative'];

  late TextEditingController emailCtrl;
  late TextEditingController mobileCtrl;
  late TextEditingController passwordCtrl;
  late TextEditingController confirmPasswordCtrl;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    _groupValue.value = -1;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();
    mobileCtrl = TextEditingController();
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
                  Text(DI<StringConst>().signupTxt,
                    style: DI<CommonWidget>().myTextStyle(
                        DI<ColorConst>().blackColor, 23.sp, FontWeight.w600),),
                  Text(DI<StringConst>().signUpInfoText,
                    style: DI<CommonWidget>().myTextStyle(
                        DI<ColorConst>().blackColor, 17.sp, FontWeight.w400),),
      
                  SizedBox(
                    height: 10,
                  ),
      
                  DI<CommonWidget>().myTextFormField(
                    controller: emailCtrl,
                      DI<StringConst>().enterEmailText,
                      icon: Icons.person,
                      textInputType: TextInputType.text,
                      maxLine: 1,
                      textInputAction: TextInputAction.next),
                  SizedBox(
                    height: 10,
                  ),
                  DI<CommonWidget>().myTextFormField(
                      controller: mobileCtrl,
                      DI<StringConst>().mobileText,
                      icon: Icons.phone,
                      textInputType: TextInputType.text,
                      maxLine: 1,
                      textInputAction: TextInputAction.next),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: _myRadioButton(
                          DI<StringConst>().maleText,
                          0,
                              (newValue) {
                          print(newValue);
                          _groupValue.value = newValue as int;
                        },),
                      ),
                      Expanded(
                        flex: 1,
                        child: _myRadioButton(
                          DI<StringConst>().femaleText, 1, (newValue) {
                          print(newValue);
                          _groupValue.value = newValue as int;
                        },),
                      ),
                    ],
                  ),
      
                  SizedBox(
                    height: 10,
                  ),
      
                  DI<CommonWidget>().dropDownCard(DI<StringConst>().profileIsForText,deliveryTypeList,onChangedValue: (value){
                   if(value!= "" && value != null){
                     dropProfileForDownValue.value = value;
                   }
      
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  DI<CommonWidget>().passwordTextFromFiled(
                      controller: passwordCtrl,
                      DI<StringConst>().please_enter_password_Text, obscureText,
                      textInputAction: TextInputAction.next),
                  SizedBox(
                    height: 10,
                  ),
                  DI<CommonWidget>().passwordTextFromFiled(
                      controller: confirmPasswordCtrl,
                      DI<StringConst>().please_enter_confim_password_Text,
                      obscureText2, textInputAction: TextInputAction.next),
                  SizedBox(
                    height: 20.sp,
                  ),
                  DI<CommonWidget>().myButton(DI<StringConst>().continueText, () {
                    if(validation()){
                      String gender =   _groupValue.value == 0? DI<StringConst>().maleText: DI<StringConst>().femaleText;
                      authController.userRegister(emailCtrl.text.trim(),
                          mobileCtrl.text.trim(),
                          gender, dropProfileForDownValue.value, confirmPasswordCtrl.text.trim());
      
                    }
      
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: DI<StringConst>().alreadyHaveAccount_Text,
                              style: DI<CommonWidget>().myTextStyle(
                                  DI<ColorConst>().blackColor,
                                  16.sp,
                                  FontWeight.w400),
                            ),
                            TextSpan(
                              text: " ",
                              style: DI<CommonWidget>().myTextStyle(
                                  DI<ColorConst>().blackColor,
                                  16.sp,
                                  FontWeight.w400),
                            ),
                            TextSpan(
                              text: DI<StringConst>().signIn_Text,
                              style: DI<CommonWidget>().myTextStyle(
                                  DI<ColorConst>().whiteColor,
                                  16.sp,
                                  FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )),
      ),
    );
  }


  Widget _myRadioButton(String title, int value, Function(Object?) onChanged) {
    return Obx(
     () =>  RadioListTile(
        value: value,
        groupValue: _groupValue.value,
        onChanged: onChanged,
        title: Text(title),
      ),
    );
  }

  bool validation(){
    if(emailCtrl.text.trim().isEmpty){
      DI<CommonFunction>()
          .showSnackBar("${DI<StringConst>().pleaseText} ${DI<StringConst>().enterEmailText.toLowerCase()}");
      return false;
    } else  if(mobileCtrl.text.trim().isEmpty){
      DI<CommonFunction>()
          .showSnackBar("${DI<StringConst>().pleaseText} ${DI<StringConst>().enter_mobile_Text.toLowerCase()}");
      return false;
    }

    else if(_groupValue.value == -1){
      DI<CommonFunction>()
          .showSnackBar("${DI<StringConst>().pleaseText} ${DI<StringConst>().select_gender_Text.toLowerCase()}");
      return false;
    }
    else if(dropProfileForDownValue.value == ""){
      DI<CommonFunction>()
          .showSnackBar("${DI<StringConst>().pleaseText} ${DI<StringConst>().select_profile_for_Text.toLowerCase()}");
      return false;
    }
    else if(passwordCtrl.text.trim().isEmpty){
      DI<CommonFunction>()
          .showSnackBar("${DI<StringConst>().pleaseText} ${DI<StringConst>().enter_password_Text.toLowerCase()}");
      return false;
    }if(confirmPasswordCtrl.text.trim().isEmpty){
      DI<CommonFunction>()
          .showSnackBar("${DI<StringConst>().pleaseText} ${DI<StringConst>().please_enter_confim_password_Text.toLowerCase()}");
      return false;
    }
    else if(passwordCtrl.text.trim() != confirmPasswordCtrl.text.trim()){
      DI<CommonFunction>()
          .showSnackBar("${DI<StringConst>().pleaseText} ${DI<StringConst>().enterSamePasswordText.toLowerCase()}");
      return false;
    }

    return true;

  }

  @override
  void dispose() {
    super.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    mobileCtrl.dispose();
  }

}
