import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadiviha/util/ColorConst.dart';
import 'package:shaadiviha/util/CommonFunction.dart';
import 'package:shaadiviha/util/CommonWidget.dart';
import 'package:shaadiviha/util/ImageConst.dart';
import 'package:shaadiviha/util/Injection.dart';
import 'package:shaadiviha/util/RouteHelper.dart';
import 'package:shaadiviha/util/StringConst.dart';
import 'package:sizer/sizer.dart';

import '../../util/local_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  bool isLogin = false;
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    isLogin = DI<MyLocalStorage>().getBoolValue(DI<MyLocalStorage>().isLogin);
    print(isLogin);

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    timer =  Timer(Duration(seconds: 3), ()async {
      if(isLogin){
        Get.offAllNamed(DI<RouteHelper>().getHomeTabScreen());
      }else{
        Get.offAllNamed(DI<RouteHelper>().getLoginScreen());
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
              DI<ColorConst>().colorPrimary,
            DI<ColorConst>().darkPrimaryColor,


          ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.w),
            child: Image.asset(DI<ImageConst>().APP_ICON,
            height: 50.w,
                width: 50.w,),
          ),
          DI<CommonWidget>().appNameStyleText()
        ],
      ),
    );
  }
}
