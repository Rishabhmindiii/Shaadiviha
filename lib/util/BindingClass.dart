import 'package:get/get.dart';

import '../controller/auth/AuthController.dart';
import '../controller/home_controller/HomeController.dart';
import '../controller/profile_controller/ProfileController.dart';

class BindingClass extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(()=> AuthController(),fenix: true);
    Get.lazyPut<ProfileController>(()=> ProfileController(),fenix: true);
    Get.lazyPut<HomeController>(()=> HomeController(),fenix: true);

  }

}