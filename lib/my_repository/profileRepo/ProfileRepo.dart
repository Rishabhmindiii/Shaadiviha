import 'dart:convert';

import 'package:get/get.dart';
import 'package:shaadiviha/model/ReligionModel.dart';
import 'package:shaadiviha/model/SubscriptionModel.dart';
import 'package:shaadiviha/model/UserDataModel.dart';
import 'package:shaadiviha/network/ApiService.dart';
import 'package:shaadiviha/network/WebService.dart';
import 'package:shaadiviha/util/Extension.dart';

import '../../util/Injection.dart';

class ProfileRepo extends GetxService{

  Future<dynamic> uploadProfileRepo(List<String> filePathList)async{
    var response = await DI<ApiService>().multipartPostMethod(DI<WebService>().updateProfilePicturesEndPoint,
        "", "", {}, mainHeader(),imagePathList: filePathList);
    print("uploadProfileRepo response :- ${response.data}");
    return response;
  }

  Future<dynamic> updatePersonalDetailRepo(Map<String,String> mapBody)async{
    var response = await DI<ApiService>().postMethod(DI<WebService>().updatePersonalDetailsEndPoint, mapBody,header: mainHeader());

    print("updatePersonalDetailRepo response :-- ${response.data}");

    return response;

  }

  Future<dynamic> deleteUserAccountRepo()async{
    var response = await DI<ApiService>().getMethod(DI<WebService>().deleteAccountApi,header: mainHeader());

    print("deleteUserAccountRepo response :-- ${response.data}");

    return response;
  }

  Future<dynamic> updateSocialInfoRepo(Map<String,String> mapBody)async{
    var response = await DI<ApiService>().postMethod(DI<WebService>().updateSocialInfoEndPoint, mapBody,header: mainHeader());
    print("updateSocialInfoRepo response :-- ${response.data}");
    return response;
  }

  Future<dynamic> getUserProfileInfoRepo(String id)async{
    var response = await DI<ApiService>().getMethod("${DI<WebService>().getUserProfileInfoEndPoint}$id",header: mainHeader());
    print("getUserProfileInfoRepo response :-- ${response.data}");
    return userDataModelFromJson(jsonEncode(response.data));
  }

  Future<dynamic> sendInterestRequestRepo(Map<String,String> mapBody)async{
    var response = await DI<ApiService>().postMethod(DI<WebService>().interestSendEndPoint, mapBody,header: mainHeader());
    print("sendInterestRequestRepo response :- ${response.data}");

    return response;
  }

  Future<dynamic> interestRespondRepo(Map<String,String> mapBody)async{
    var response = await DI<ApiService>().postMethod(DI<WebService>().requestResponseEndPoint,
        mapBody,header: mainHeader());

    print("interestRespondRepo response :- ${response.data}");

    return response;
  }

  Future<dynamic> getSubscriptionRepo()async{
    var response = await DI<ApiService>().getMethod(DI<WebService>().getAllSubscriptionPlansEndPoint,header: mainHeader());
    print("getSubscriptionRepo response :- ${response.data}");

    return subscriptionModelFromJson(jsonEncode(response.data));
  }

  Future<dynamic> purchaseSubscripationPlanRepo(Map<String,String> mapBody)async{
    var response = await DI<ApiService>().postMethod(DI<WebService>().purchaseSubscriptionPlanEndPoint,mapBody,header: mainHeader());
    print("purchaseSubscripationPlanRepo response :- ${response.data}");

    return response;
  }


/// Dynamic Social list
  Future<dynamic> getMotherTonguesRepo()async{
    var response = await DI<ApiService>().getMethod(DI<WebService>().getMotherTonguesEndPoint,header: mainHeader());
    print("getMotherTonguesRepo response :- ${response.data}");

    return religionModelFromJson(jsonEncode(response.data));
  }

  Future<dynamic> getOccupationsRepo()async{
    var response = await DI<ApiService>().getMethod(DI<WebService>().getOccupationEndPoint,header: mainHeader());
    print("getOccupationsRepo response :- ${response.data}");

    return religionModelFromJson(jsonEncode(response.data));
  }

  Future<dynamic> getEducationsRepo()async{
    var response = await DI<ApiService>().getMethod(DI<WebService>().getEducationEndPoint,header: mainHeader());
    print("getEducationsRepo response :- ${response.data}");

    return religionModelFromJson(jsonEncode(response.data));
  }

  Future<dynamic> getReligionRepo()async{
    var response = await DI<ApiService>().getMethod(DI<WebService>().getReligionEndPoint,header: mainHeader());
    print("getReligionRepo response :- ${response.data}");

    return religionModelFromJson(jsonEncode(response.data));
  }
  Future<dynamic> getCasteRepo(String id)async{
    var response = await DI<ApiService>().getMethod("${DI<WebService>().getCastesEndPoint}$id",header: mainHeader());
    print("getCasteRepo response :- ${response.data}");

    return religionModelFromJson(jsonEncode(response.data));
  }



}