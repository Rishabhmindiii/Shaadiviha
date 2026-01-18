import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaadiviha/util/ConstValue.dart';
import 'package:shaadiviha/view/home_screen/HomeScreen.dart';
import 'package:shaadiviha/view/profile_screen/ProfileScreen.dart';
import 'package:shaadiviha/view/search_screen/SearchScreen.dart';
import 'package:shaadiviha/view/user_list_screen/UserListScreen.dart';
import 'package:sizer/sizer.dart';

import '../../util/ColorConst.dart';
import '../../util/CommonWidget.dart';
import '../../util/Injection.dart';
import '../../util/StringConst.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {

  final List<Widget> _screens = [HomeScreen(),SearchScreen(),UserListScreen(),ProfileScreen()];
  @override
  void initState() {
   WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    DI<ConstValue>().currentIndex.value = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>  SafeArea(
        child: Scaffold(
          body: _screens[DI<ConstValue>().currentIndex.value],
          bottomNavigationBar: SizedBox(
            height: kBottomNavigationBarHeight,
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        DI<ConstValue>().currentIndex.value = 0;
                      },
                      child: bottomNavIcon(
                          DI<ConstValue>().currentIndex.value == 0
                              ? Icons.home
                              : Icons.home_outlined,
                          DI<StringConst>().homeText,
                          DI<ConstValue>().currentIndex.value == 0
                              ? DI<ColorConst>().darkPrimaryColor
                              : DI<ColorConst>().blackColor)),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        DI<ConstValue>().currentIndex.value = 1;
                      },
                      child: bottomNavIcon(
                          DI<ConstValue>().currentIndex.value == 1
                              ? Icons.grid_view_rounded
                              : Icons.grid_view,
                          DI<StringConst>().searchText,
                          DI<ConstValue>().currentIndex.value == 1
                              ? DI<ColorConst>().darkPrimaryColor
                              : DI<ColorConst>().blackColor)),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        DI<ConstValue>().currentIndex.value = 2;
                      },
                      child: bottomNavIcon(
                          DI<ConstValue>().currentIndex.value == 2
                              ? Icons.shopping_cart
                              : Icons.shopping_cart_outlined,
                          DI<StringConst>().userListText,
                          DI<ConstValue>().currentIndex.value == 2
                              ? DI<ColorConst>().darkPrimaryColor
                              : DI<ColorConst>().blackColor)),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        DI<ConstValue>().currentIndex.value = 3;
                      },
                      child: bottomNavIcon(
                          DI<ConstValue>().currentIndex.value == 3
                              ? Icons.person
                              : Icons.person_2_outlined,
                          DI<StringConst>().profileText,
                          DI<ConstValue>().currentIndex.value == 3
                              ? DI<ColorConst>().darkPrimaryColor
                              : DI<ColorConst>().blackColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomNavIcon(IconData? iconShow, String title, Color myColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconShow,
          color: myColor,
        ),
        Text(
          title,
          style:
          DI<CommonWidget>().myTextStyle(myColor, 15.sp, FontWeight.w400),
        )
      ],
    );
  }
}
