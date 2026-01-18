import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:shaadiviha/model/ReligionModel.dart';
import 'package:shaadiviha/model/SubscriptionModel.dart';
import 'package:shaadiviha/my_repository/auth_repo/AuthRepo.dart';
import 'package:shaadiviha/my_repository/profileRepo/ProfileRepo.dart';
import 'package:shaadiviha/model/UserDataModel.dart';
import 'package:shaadiviha/network/ApiService.dart';
import 'package:shaadiviha/network/WebService.dart';
import 'package:shaadiviha/util/CommonFunction.dart';
import 'package:shaadiviha/util/CommonWidget.dart';

import '../../util/Injection.dart';
import '../../util/RouteHelper.dart';
import '../../util/local_storage.dart';

class ProfileController extends GetxController{


  // Get user Profile
  var profileLoading = false.obs;
  var tempProfileLoading = false.obs;
  var castProfileLoading = false.obs;
  var userProfileModel = Rxn<UserDataModel>();
  var casteValueDrop = Rxn<dynamic>();

  //get Religion Data
  var motherTonguesModel = Rxn<ReligionModel>();
  var occupationsModel = Rxn<ReligionModel>();
  var educationsModel = Rxn<ReligionModel>();
  var religionModel = Rxn<ReligionModel>();
  //get Caste Data
  var casteModel = Rxn<ReligionModel>();

  //get Subscripation list
  var subscripationModel = Rxn<SubscriptionModel>();

  Future<void> uploadProfile(List<File> filePath)async{
    DI<CommonFunction>().showLoading();
    try{
      List<String> filePathList = [];

      for(var value in filePath){
        filePathList.add(value.path);
      }

      var response = await DI<ProfileRepo>().uploadProfileRepo(filePathList);
      DI<CommonFunction>().hideLoader();

      var responseData = response.data;

      if(responseData["success"].toString() =="true"){
        Get.back(result: "refresh");
      }

    }catch(e){
      DI<CommonFunction>().hideLoader();
      log("Exception uploadProfile :-- ",error: e.toString());
    }
  }

  Future<void> updatePersonalDetail(String fullName,String dateOfBirth, String height, String interest, String aboutYou)async {
    DI<CommonFunction>().showLoading();
    Map<String, String> personalDetailMap = {
      "full_name": fullName,
      "date_of_birth": dateOfBirth,
      "height": height,
      "interest": interest,
      "about_you": aboutYou,
    };
    print("personalDetailMap :-- $personalDetailMap");

    try {
      var response = await DI<ProfileRepo>().updatePersonalDetailRepo(
          personalDetailMap);
      DI<CommonFunction>().hideLoader();

      var responseData = response.data;
      if(responseData["success"].toString() == "true"){
        Get.back(result: "refresh");
      }
    } catch (e) {
      DI<CommonFunction>().hideLoader();
      log("Exception :-- ", error: e.toString());
    }
  }


  Future<void> updateSocialInfo(String motherToungue,String maritalStatus,String religion,String caste,String education,String occupation,String aboutYou)async{
    DI<CommonFunction>().showLoading();
    Map<String,String> socialMap = {
      "mother_toungue":motherToungue,
      "marital_status":maritalStatus,
      "religion":religion,
      "caste":caste,
      "education":education,
      "occupation":occupation,
      "about_you":aboutYou,
    };
    print("socialMap :-- $socialMap");

    try{

      var response = await DI<ProfileRepo>().updateSocialInfoRepo(socialMap);
      DI<CommonFunction>().hideLoader();

      var responseData = response.data;

      if(responseData["success"].toString() =="true"){
        Get.back(result: "refresh");
      }

    }catch(e){
      DI<CommonFunction>().hideLoader();
      log("Exception updateSocialInfo :- ",error: e.toString());
    }
  }

  Future<void> getUserProfileInfo(String id)async{
    DI<CommonFunction>().showLoading();
    profileLoading.value = true;
    print("User id :- $id");

    try{
      var response = await DI<ProfileRepo>().getUserProfileInfoRepo(id.toString());
      DI<CommonFunction>().hideLoader();
      profileLoading.value = false;
      userProfileModel.value = response;

    }catch(e){
      DI<CommonFunction>().hideLoader();
      profileLoading.value = false;
      log("Exception getUserProfileInfo :-- ",error: e.toString());
    }

  }

  Future<void> deleteUserAccount()async{
    DI<CommonFunction>().showLoading();
    try{
      var response = await DI<ProfileRepo>().deleteUserAccountRepo();
      DI<CommonFunction>().hideLoader();

      var responseData = response.data;

      if(responseData["success"].toString() =="true"){
        DI<MyLocalStorage>().clearLocalStorage();
        DI<MyLocalStorage>()
            .setBoolValue(DI<MyLocalStorage>().isLogin, false);
        Get.offNamed(DI<RouteHelper>().getLoginScreen());
      }

     /* DI<MyLocalStorage>().clearLocalStorage();
      DI<MyLocalStorage>()
          .setBoolValue(DI<MyLocalStorage>().isLogin, false);
      Get.offNamed(DI<RouteHelper>().getLoginScreen());*/

    }catch(e){
      DI<CommonFunction>().hideLoader();
      log("Exception deleteUserAccount :-- ",error: e.toString());
    }
  }

  Future<bool> sendInterestRequest(String id)async{

    DI<CommonFunction>().showLoading();
    Map<String,String> requestBody = {
      "to_user_id":id
    };
    print("requestBody :- $requestBody");
    try{
      var response = await DI<ProfileRepo>().sendInterestRequestRepo(requestBody);
      DI<CommonFunction>().hideLoader();
      var responseData = response.data;

      if(responseData["success"].toString() =="true"){
        return true;
      }else{
        DI<CommonWidget>().errorDialog(response.data["message"], () {
          Get.back();
          Get.back(result: "subscription");
        });
      }
    }catch(e){
      DI<CommonFunction>().hideLoader();
      log("Exception sendInterestRequest :- ",error: e.toString());
    }

    return false;
  }

  Future<void> interestRespond(String fromUserId, String status)async{

    DI<CommonFunction>().showLoading();

    Map<String,String> mapBody = {
      "from_user_id":fromUserId,
      "status" : status
    };
    print("interest response :- $mapBody}");

    try{
      var response = await DI<ProfileRepo>().interestRespondRepo(mapBody);
      DI<CommonFunction>().hideLoader();
      var responseData = response.data;
      if(responseData["success"].toString() == "true"){
        if(status == "rejected"){
          userProfileModel.value?.data.interestStatus = "0";
        }else{
          userProfileModel.value?.data.interestStatus = "3";
        }

        userProfileModel.refresh();
      }
    }catch(e){
      DI<CommonFunction>().hideLoader();
      log("Exception :-- ",error: e.toString());
    }
  }

  Future<void> getSubscripationList()async{
    DI<CommonFunction>().showLoading();
    profileLoading.value = true;

    try{
      var response = await DI<ProfileRepo>().getSubscriptionRepo();
      profileLoading.value = false;
      DI<CommonFunction>().hideLoader();
      subscripationModel.value = response;

    }catch(e){
      profileLoading.value = false;
      DI<CommonFunction>().hideLoader();
      log("Exception getSubscripationList :- ",error: e.toString());
    }
  }

  Future<void> purchaseSubscripation(String subPlainId, String paymentId, String orderId,String signature)async{
    DI<CommonFunction>().showLoading();

    Map<String,String> mapBody = {
      "subscription_plan_id" : subPlainId,
      "razorpay_payment_id" : paymentId,
      "razorpay_order_id" : orderId,
      "razorpay_signature" : signature,
     // "amount" : amount
    };

    print("purchaseSubscripation mapBody :- $mapBody");
    try{

      var response = await DI<ProfileRepo>().purchaseSubscripationPlanRepo(mapBody);
      DI<CommonFunction>().hideLoader();

      var responseData = response.data;

      if(responseData["success"].toString() =="true"){
       DI<CommonWidget>().errorDialog(responseData["message"].toString(), (){
         Get.back();
         Get.back();
       });
      }

    }catch(e){
      DI<CommonFunction>().hideLoader();
      log("Exception purchaseSubscripation :-- ",error: e.toString());
    }
  }

  Future<void> getMotherTonguesList()async{
    DI<CommonFunction>().showLoading();
    tempProfileLoading.value = true;
    motherTonguesModel.value = null;
    try{
      var response = await DI<ProfileRepo>().getMotherTonguesRepo();
      //DI<CommonFunction>().hideLoader();
      //profileLoading.value = false;
      motherTonguesModel.value = response;
      motherTonguesModel.value?.data.add(Religion(id: "-1", name: "Other"));
      motherTonguesModel.refresh();
     getOccupationsList();

    }catch(e){
      DI<CommonFunction>().hideLoader();
      tempProfileLoading.value = false;
      log("Exception getReligionList :-- ",error: e.toString());
    }

  }
  Future<void> getOccupationsList()async{
    //DI<CommonFunction>().showLoading();
    tempProfileLoading.value = true;
    occupationsModel.value = null;
    try{
      var response = await DI<ProfileRepo>().getOccupationsRepo();
      //DI<CommonFunction>().hideLoader();
      //profileLoading.value = false;
      occupationsModel.value = response;
      occupationsModel.value?.data.add(Religion(id: "-1", name: "Other"));
      occupationsModel.refresh();
      getEducationsList();
    }catch(e){
      DI<CommonFunction>().hideLoader();
      tempProfileLoading.value = false;
      log("Exception getReligionList :-- ",error: e.toString());
    }

  }
  Future<void> getEducationsList()async{
    //DI<CommonFunction>().showLoading();
    educationsModel.value = null;
    tempProfileLoading.value = true;
    try{
      var response = await DI<ProfileRepo>().getEducationsRepo();
      //DI<CommonFunction>().hideLoader();
      //profileLoading.value = false;
      educationsModel.value = response;
      educationsModel.value?.data.add(Religion(id: "-1", name: "Other"));
      educationsModel.refresh();
      getReligionList();
    }catch(e){
      DI<CommonFunction>().hideLoader();
      tempProfileLoading.value = false;
      log("Exception getReligionList :-- ",error: e.toString());
    }

  }
  Future<void> getReligionList()async{
    //DI<CommonFunction>().showLoading();
    tempProfileLoading.value = true;
    religionModel.value = null;
    try{
      var response = await DI<ProfileRepo>().getReligionRepo();
      DI<CommonFunction>().hideLoader();
      tempProfileLoading.value = false;
      religionModel.value = response;
      religionModel.value?.data.add(Religion(id: "-1", name:"Other"));
     //
      // getCasteList(religionModel.value?.data[0].id??"");
    }catch(e){
      DI<CommonFunction>().hideLoader();
      tempProfileLoading.value = false;
      log("Exception getReligionList :-- ",error: e.toString());
    }

  }
  Future<void> getCasteList(String id)async{
    DI<CommonFunction>().showLoading();
    castProfileLoading.value = true;
    casteModel.value = null;
    casteValueDrop.value = null;
    print("User id :- $id");

    try{
      var response = await DI<ProfileRepo>().getCasteRepo(id.toString());
      DI<CommonFunction>().hideLoader();
      castProfileLoading.value = false;
      casteModel.value = response;
      casteModel.refresh();

    }catch(e){
      DI<CommonFunction>().hideLoader();
      castProfileLoading.value = false;
      log("Exception getCasteList :-- ",error: e.toString());
    }

  }

}