import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shaadiviha/controller/auth/AuthController.dart';
import 'package:shaadiviha/util/RouteHelper.dart';
import 'package:sizer/sizer.dart';

import '../../../util/ColorConst.dart';
import '../../../util/CommonFunction.dart';
import '../../../util/CommonWidget.dart';
import '../../../util/Injection.dart';
import '../../../util/StringConst.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {

  AuthController authController = Get.find<AuthController>();
  String userEmail= "",otp = "";

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();

    if(Get.parameters["userEmail"] != null){
      userEmail = Get.parameters["userEmail"]??"";
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
      
                  Text(DI<StringConst>().otpVerificationText,
                    style: DI<CommonWidget>().myTextStyle(
                        DI<ColorConst>().blackColor, 21.sp, FontWeight.w600),),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      DI<StringConst>().otpVerificationMsgText),
                  SizedBox(
                    height: 15.sp,
                  ),
      
                  OtpTextField(
                    numberOfFields: 6,
                    borderRadius: BorderRadius.circular(7.0),
                    showFieldAsBox: true,
                    fieldHeight: 13.w,
                    fieldWidth: 13.w,
                    enabledBorderColor:DI<ColorConst>().whiteColor ,
                    focusedBorderColor: DI<ColorConst>().darkPrimaryColor ,
                    onSubmit: (value) {
      
                      otp = value;
                    },
                     // end onSubmit
                  ),
      
                  SizedBox(
                    height: 10.w,
                  ),
                  DI<CommonWidget>().myButton(DI<StringConst>().done_txt, () {
      
                    print("Otp value :-- $otp");
      
                    if(otp.isNotEmpty && otp.length >5){
                      authController.sendVerifyOtp(userEmail, otp);
                    }else{
                      DI<CommonFunction>().showSnackBar("${DI<StringConst>().validOtpText} ");
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
