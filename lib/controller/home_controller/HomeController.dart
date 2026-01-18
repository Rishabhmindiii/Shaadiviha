import 'dart:developer';

import 'package:get/get.dart';
import 'package:shaadiviha/model/HomeScreenDataModel.dart';
import 'package:shaadiviha/model/HomeScreenUserListMode.dart';
import 'package:shaadiviha/model/NotificationModel.dart';
import 'package:shaadiviha/model/UserListModel.dart';
import 'package:shaadiviha/my_repository/home_repo/HomeRepo.dart';
import 'package:shaadiviha/util/CommonFunction.dart';

import '../../util/Injection.dart';

class HomeController extends GetxService {
  var loading = false.obs;
  var loadingUserList = false.obs;

  /// get Home top data
  var homeUserDataModel = Rxn<HomeScreenDataModel>();

  /// getHome User List
  var homeUserListModel = Rxn<HomeScreenUserListModel>();

  /// get User list
  var userListModel = Rxn<UserListModel>();

  /// getNotification list
  var notificationListModel = Rxn<NotificationModel>();

  Future<dynamic> getHomeUserData() async {
    DI<CommonFunction>().showLoading();
    loading.value = true;

    try {
      var response = await DI<HomeRepo>().getHomeUserDataRepo();
      DI<CommonFunction>().hideLoader();
      loading.value = false;
      homeUserDataModel.value = response;
    } catch (e) {
      DI<CommonFunction>().hideLoader();
      loading.value = false;
      log("Exception getHomeUserData :-- ", error: e.toString());
    }
  }

  Future<dynamic> getHomeUserList(String filterBy) async {
    DI<CommonFunction>().showLoading();
    loadingUserList.value = true;
    homeUserListModel.value = null;

    try {
      var response = await DI<HomeRepo>().getHomeUserListRepo(filterBy);
      DI<CommonFunction>().hideLoader();
      loadingUserList.value = false;
      homeUserListModel.value = response;
    } catch (e) {
      DI<CommonFunction>().hideLoader();
      loadingUserList.value = false;
      log("Exception getHomeUserList :-- ", error: e.toString());
    }
  }

  Future<void> getUserList(String searchKey) async {
    DI<CommonFunction>().showLoading();
    loadingUserList.value = true;
   Map<String,String> userListMapBody ={
     "searchKey":searchKey
   };
   print("getUserListMapBody :- $userListMapBody");

    try {
      var response = await DI<HomeRepo>().getUserListRepo(userListMapBody);
      DI<CommonFunction>().hideLoader();
      loadingUserList.value = false;
      userListModel.value = response;
    } catch (e) {
      DI<CommonFunction>().hideLoader();
      loadingUserList.value = false;
      log("Exception getUserList :-- ", error: e.toString());
    }
  }

  Future<void> getNotificationList()async{
    DI<CommonFunction>().showLoading();
    notificationListModel.value = null;
    try{
      var response = await DI<HomeRepo>().getNotificationListRepo();
      DI<CommonFunction>().hideLoader();
      notificationListModel.value = response;
    }catch(e){
      DI<CommonFunction>().hideLoader();
      log("Exception getNotificationList:-  ",error: e.toString());
    }
  }
}
