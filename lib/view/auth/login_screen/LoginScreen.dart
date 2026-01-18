import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadiviha/controller/auth/AuthController.dart';
import 'package:shaadiviha/util/CommonFunction.dart';
import 'package:shaadiviha/util/CommonWidget.dart';
import 'package:shaadiviha/util/RouteHelper.dart';
import 'package:shaadiviha/util/StringConst.dart';
import 'package:sizer/sizer.dart';

import '../../../util/ColorConst.dart';
import '../../../util/Injection.dart';
import '../../../util/local_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.find<AuthController>();

  late TextEditingController emailCtrl;
  late TextEditingController passwordCtrl;

  var obscureText = true.obs;
  var checkBoxValue = false.obs;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
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
                height: kBottomNavigationBarHeight + 30.sp,
              ),
              Center(child: DI<CommonWidget>().appNameStyleText(fontSize: 30.sp)),
              SizedBox(
                height: kBottomNavigationBarHeight,
              ),
              Text(
                  "${DI<StringConst>().pleaseText} ${DI<StringConst>().enterEmailOrMobileText}"),
              DI<CommonWidget>().myTextFormField(
                  controller: emailCtrl,
                  DI<StringConst>().enterEmailOrMobileText.toLowerCase(),
                  icon: Icons.person,
                  textInputType: TextInputType.text,
                  maxLine: 1,
                  textInputAction: TextInputAction.next),
              Text(DI<StringConst>().please_enter_password_Text),
              passwordTextFromFiled(),
              SizedBox(
                height: 10.sp,
              ),
              InkWell(
                onTap: (){
      
                  Get.toNamed(DI<RouteHelper>().getForgotPasswordScreen());
      
                },
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      DI<StringConst>().forgotPasswordText,
                    )),
              ),
              termsNConditionCheckBox(),
              SizedBox(
                height: 10.sp,
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Get.toNamed(DI<RouteHelper>().getSignupScreen());
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: DI<StringConst>().newToShaadividhaText,
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
                          text: DI<StringConst>().createAccountText,
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
                height: 10.w,
              ),
              DI<CommonWidget>().myButton(DI<StringConst>().continueText, () {
                if (validation()) {
                  authController.userLogin(
                      emailCtrl.text.trim(), passwordCtrl.text.trim());
                }
                // DI<MyLocalStorage>().setBoolValue(DI<MyLocalStorage>().isLogin,true);
                //Get.offNamed(DI<RouteHelper>().getHomeTabScreen());
              }),
            ],
          ),
        )),
      ),
    );
  }

  Widget termsNConditionCheckBox() {
    return Obx(() => CheckboxListTile(
          title: Text(
            DI<StringConst>().by_continuing_terms_and_conditions_Text,
            maxLines: 2,
            style: DI<CommonWidget>().myTextStyle(
                DI<ColorConst>().blackColor, 15.sp, FontWeight.w400),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: DI<ColorConst>().secondColorPrimary,
          contentPadding: EdgeInsets.zero,
          value: checkBoxValue.value,
          onChanged: (value) {
            checkBoxValue.value = value!;
          },
        ));
  }

  Widget passwordTextFromFiled() {
    return Obx(
      () => TextFormField(
        controller: passwordCtrl,
        obscureText: obscureText.value,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          fillColor: DI<ColorConst>().whiteColor.withOpacity(0.7),
          filled: true,
          hintText: DI<StringConst>().enter_password_Text.toLowerCase(),
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

  bool validation() {
    if (emailCtrl.text.trim().isEmpty) {
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().enterEmailOrMobileText.toLowerCase()}");
      return false;
    } else if (passwordCtrl.text.trim().isEmpty) {
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().enter_password_Text.toLowerCase()}");
      return false;
    } else if (!checkBoxValue.value) {
      DI<CommonFunction>().showSnackBar(
          "${DI<StringConst>().pleaseText} ${DI<StringConst>().selectTermsConditionText.toLowerCase()}");
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
