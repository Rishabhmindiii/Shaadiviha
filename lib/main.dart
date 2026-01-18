import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaadiviha/util/BindingClass.dart';
import 'package:shaadiviha/util/ColorConst.dart';
import 'package:shaadiviha/util/CommonFunction.dart';
import 'package:shaadiviha/util/Injection.dart';
import 'package:shaadiviha/util/RouteHelper.dart';
import 'package:shaadiviha/util/StringConst.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await GetStorage.init();
  setup();
  configLoading();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return GestureDetector(
        onTap: () => DI<CommonFunction>().hideKeyboard(),
        child: GetMaterialApp(
          title: DI<StringConst>().appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: DI<ColorConst>().colorPrimary),
              useMaterial3: true,
              fontFamily: "Poppins",
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hintColor: DI<ColorConst>().gryColor),
          initialBinding: BindingClass(),
          initialRoute: DI<RouteHelper>().getSplashscreen(),
          getPages: DI<RouteHelper>().routes,
          builder: EasyLoading.init(),
        ),
      );
    });
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}
