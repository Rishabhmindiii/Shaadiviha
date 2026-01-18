import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shaadiviha/util/RouteHelper.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth/AuthController.dart';
import '../../../util/ColorConst.dart';
import '../../../util/CommonFunction.dart';
import '../../../util/CommonWidget.dart';
import '../../../util/Injection.dart';
import '../../../util/StringConst.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  AuthController authController = Get.find<AuthController>();

  late TextEditingController emailCtrl;
  @override
  void initState() {
    super.initState();

    emailCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DI<CommonWidget>().gradiantBackGround(
          childWidget: SingleChildScrollView(
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
      
                Center(child: DI<CommonWidget>().appNameStyleText(fontSize: 30.sp)),
                SizedBox(
                  height: kBottomNavigationBarHeight,
                ),
      
                Text(DI<StringConst>().forgotPasswordAppBarText,
                  style: DI<CommonWidget>().myTextStyle(
                      DI<ColorConst>().blackColor, 21.sp, FontWeight.w600),),
                SizedBox(
                  height: 5,
                ),
                Text(
                    DI<StringConst>().forgotPasswordMsgText),
                SizedBox(
                  height: 15.sp,
                ),
                DI<CommonWidget>().myTextFormField(
                  controller: emailCtrl,
                    "${DI<StringConst>().enterEmailText.toLowerCase()}",
                    icon: Icons.person,
                    textInputType: TextInputType.emailAddress,
                    maxLine: 1,
                    textInputAction: TextInputAction.done),
      
                SizedBox(
                  height: 10,
                ),
      
                SizedBox(
                  height: 10.w,
                ),
                DI<CommonWidget>().myButton(DI<StringConst>().sendOtpText, () {
      
                  if(emailCtrl.text.trim().isNotEmpty){
                    authController.sendVerifyOtp(emailCtrl.text.trim(), "");
                  }else{
                    DI<CommonFunction>().showSnackBar(
                        "${DI<StringConst>().pleaseText} ${DI<StringConst>().enterEmailText.toLowerCase()}");
                  }
      
      
                }),
              ],
            ),
          ),
        )
      ),
    );
  }



}
