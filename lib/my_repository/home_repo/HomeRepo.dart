import 'dart:convert';

import 'package:get/get.dart';
import 'package:shaadiviha/model/HomeScreenDataModel.dart';
import 'package:shaadiviha/model/HomeScreenUserListMode.dart';
import 'package:shaadiviha/model/NotificationModel.dart';
import 'package:shaadiviha/model/UserListModel.dart';
import 'package:shaadiviha/network/ApiService.dart';
import 'package:shaadiviha/network/WebService.dart';
import 'package:shaadiviha/util/Extension.dart';

import '../../util/Injection.dart';

class HomeRepo extends GetxService{


  Future<dynamic> getHomeUserDataRepo()async{
    var response = await DI<ApiService>().getMethod(DI<WebService>().getHomeDataEndPoint,header: mainHeader());
    print("getHomeUserDataRepo response :- ${response.data}");
    return homeScreenDataModelFromJson(jsonEncode(response.data));
  }

  Future<dynamic> getHomeUserListRepo(String filterBy)async{
    var response = await DI<ApiService>().getMethod("${DI<WebService>().getHomeScreenUserListEndPoint}$filterBy",header: mainHeader());
    print("getHomeUserListRepo response :- ${response.data}");
    return homeScreenUserListModelFromJson(jsonEncode(response.data));
  }

  Future<dynamic> getUserListRepo(Map<String,String> mapBody)async{
    var response = await DI<ApiService>().postMethod(DI<WebService>().getUserListEndPoint,mapBody,header: mainHeader());
    print("getUserListRepo response :- ${response.data}");
    return userListModelFromJson(jsonEncode(response.data));
  }

  Future<dynamic> getNotificationListRepo()async{
    var response = await DI<ApiService>().getMethod(DI<WebService>().getNotificationEndPoint,header: mainHeader());
    print("getNotificationListRepo response :- ${response.data}");
    return notificationModelFromJson(jsonEncode(response.data));
  }

}