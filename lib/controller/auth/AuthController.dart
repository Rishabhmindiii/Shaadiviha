import 'dart:developer';

import 'package:get/get.dart';
import 'package:shaadiviha/model/CountryModel.dart';
import 'package:shaadiviha/model/StateModel.dart';
import 'package:shaadiviha/my_repository/auth_repo/AuthRepo.dart';
import 'package:shaadiviha/util/CommonFunction.dart';
import 'package:shaadiviha/util/CommonWidget.dart';

import '../../util/Injection.dart';
import '../../util/RouteHelper.dart';
import '../../util/local_storage.dart';

class AuthController extends GetxService{

  var locationLoader = false.obs;

  //get Country list
  var countryModel = Rxn<CountryModel>();
  //get State list
  var stateModel = Rxn<CountryModel>();
  var districtModel = Rxn<CountryModel>();
  var cityModel = Rxn<CountryModel>();
  var blockModel = Rxn<CountryModel>();


  Future<void> userRegister(String email,String mobile,String gender,String profileFor ,String password)async{
    DI<CommonFunction>().showLoading();
    Map<String,String> userRegisterMap = {
      "email":email,
      "mobile":mobile,
      "gender":gender,
      "profile_for":profileFor,
      "password":password,
    };

    print("userRegisterMap :- $userRegisterMap");

    try{
      var response = await DI<AuthRepo>().userSignupRepo(userRegisterMap);
      DI<CommonFunction>().hideLoader();

      print("userRegister :-- ${response.data}");
      var responseData = response.data;
      if(responseData["success"].toString() =="true"){

        var user = responseData["data"]["user"];
        DI<MyLocalStorage>().setStringValue(DI<MyLocalStorage>().userName,user["full_name"].toString());
        DI<MyLocalStorage>().setStringValue(DI<MyLocalStorage>().userProfile,user["profile_pictures"].toString());
        DI<MyLocalStorage>().setStringValue(DI<MyLocalStorage>().userId,user["id"].toString());
        DI<MyLocalStorage>().setStringValue(DI<MyLocalStorage>().emailOrPhone,user["email"].toString());

        DI<MyLocalStorage>().setStringValue(DI<MyLocalStorage>().authToken,responseData["data"]["token"].toString());

        DI<MyLocalStorage>().setBoolValue(DI<MyLocalStorage>().isLogin,true);
        Get.toNamed(DI<RouteHelper>().getAddressScreen());

      }


    }catch(e){
      DI<CommonFunction>().hideLoader();
      log("Exception userRegister:-- ",error: e.toString());
    }
  }

  Future<void> userLogin(String email,String password)async{
    DI<CommonFunction>().showLoading();
    Map<String, String> mapLogin = {
      "emailOrMobile" : email,
      "password" : password
    };
    try{
      var response = await DI<AuthRepo>().userLoginRepo(mapLogin);
      DI<CommonFunction>().hideLoader();

      var responseBody = response.data;
      if(responseBody["success"].toString() == "true"){
        var user = responseBody["data"]["user"];
        DI<MyLocalStorage>().setStringValue(DI<MyLocalStorage>().userName,user["full_name"].toString());
        DI<MyLocalStorage>().setStringValue(DI<MyLocalStorage>().userProfile,user["profile_pictures"].toString());
        DI<MyLocalStorage>().setStringValue(DI<MyLocalStorage>().userId,user["id"].toString());
        DI<MyLocalStorage>().setStringValue(DI<MyLocalStorage>().emailOrPhone,user["email"].toString());

        DI<MyLocalStorage>().setStringValue(DI<MyLocalStorage>().authToken,responseBody["data"]["token"].toString());

         DI<MyLocalStorage>().setBoolValue(DI<MyLocalStorage>().isLogin,true);
        Get.offNamed(DI<RouteHelper>().getHomeTabScreen());
      }

    }catch(e){
      DI<CommonFunction>().hideLoader();
      log("Exception login :-- ",error: e.toString());
    }
  }


  Future<void> getCountryList()async{
    locationLoader.value = true;
    DI<CommonFunction>().showLoading();
    try{
      var response = await DI<AuthRepo>().getCountryListRepo();
      DI<CommonFunction>().hideLoader();
      countryModel.value = response;
    }catch(e){
      locationLoader.value = false;
      DI<CommonFunction>().hideLoader();
      log("Exception getCountryList :- ",error: e.toString());
    }
  }

  Future<void> getStateList(String id)async{
    locationLoader.value = true;
    DI<CommonFunction>().showLoading();
    try{
      var response = await DI<AuthRepo>().getStateListRepo(id);
      DI<CommonFunction>().hideLoader();
      stateModel.value = response;
    }catch(e){
      locationLoader.value = false;
      DI<CommonFunction>().hideLoader();
      log("Exception getStateList :- ",error: e.toString());
    }
  }

  Future<void> getDistrictList(String id)async{
    locationLoader.value = true;
    print("getDistrictList :- $id");
    DI<CommonFunction>().showLoading();
    try{
      locationLoader.value = false;
      var response = await DI<AuthRepo>().getDistrictListRepo(id);
      DI<CommonFunction>().hideLoader();
      districtModel.value = response;
    }catch(e){
      locationLoader.value = false;
      DI<CommonFunction>().hideLoader();
      log("Exception getDistrictList :- ",error: e.toString());
    }
  }

  Future<void> getCityList(String id)async{
    print("getCityList :- $id");
    DI<CommonFunction>().showLoading();
    try{
      var response = await DI<AuthRepo>().getCityListRepo(id);
      DI<CommonFunction>().hideLoader();
      cityModel.value = response;
    }catch(e){
      DI<CommonFunction>().hideLoader();
      log("Exception getCityList :- ",error: e.toString());
    }
  }

  Future<void> getBlockList(String id)async{
    print("getBlockList :- $id");
    DI<CommonFunction>().showLoading();
    try{
      var response = await DI<AuthRepo>().getBlockListRepo(id);
      DI<CommonFunction>().hideLoader();
      blockModel.value = response;
    }catch(e){
      DI<CommonFunction>().hideLoader();
      log("Exception getBlockList :- ",error: e.toString());
    }
  }


  ///update Address
 Future<bool> updateAddress(String countryId,String stateId,String districtId,String selectCityBlock,
  String cityId,String blockId,String wardNo,String panchayat,String policeStation)async{
    DI<CommonFunction>().showLoading();
    Map<String,String> addressMap = {
      "country_id" : countryId.toString(),
      "state_id" : stateId.toString(),
      "district_id" : districtId.toString(),
      "select_city_block" : selectCityBlock.toString(),
      "city_id" : cityId.toString(),
      "block_id" : blockId.toString(),
      "ward_no" : wardNo.toString(),
      "panchayat" : panchayat.toString(),
      "police_station" : policeStation.toString(),
    };
    print("addressMap :-  $addressMap");

    try{

      var response = await DI<AuthRepo>().updateAddressRepo(addressMap);

      DI<CommonFunction>().hideLoader();

      var responseBody = response.data;
      if(responseBody["success"].toString() == "true"){
        return true;
      }

    }catch(e){
      DI<CommonFunction>().hideLoader();
      log("Exception updateAddress :- ",error: e.toString());
      return false;
    }

    return false;

 }

 ///Send or Verify Otp
 Future<void> sendVerifyOtp(String userEmail, String otp)async{
    DI<CommonFunction>().showLoading();

    try{
      Map<String,String> otpMap = {
      "email" : userEmail,
      "otp_code" : otp
    };
    print(" SendVerifyOtp Map : $otpMap");


    var response = await DI<AuthRepo>().sendVerifyOtpRepo(otpMap);
      DI<CommonFunction>().hideLoader();

      var responseBody = response.data;

      if(otp.isEmpty){
        if(responseBody["success"].toString() == "true"){
          var data = {
            "userEmail" : userEmail
          };
          Get.toNamed(DI<RouteHelper>().getOtpVerificationScreen(),parameters: data);
        }
      }else{
        if(responseBody["success"].toString() == "true"){
          var data = {
            "userEmail" : userEmail
          };
          Get.toNamed(DI<RouteHelper>().getChangePasswordScreen(),parameters: data);
        }
      }



    }catch(e){
      DI<CommonFunction>().hideLoader();
      log("sendVerifyOtp map:-- ",error:  e.toString());
    }

 }

  ///Send or Verify Otp
  Future<void> resetPassword(String userEmail, String password,String conformPassword)async{
    DI<CommonFunction>().showLoading();

    try{
      Map<String,String> resetPasswordMap = {
        "email" : userEmail,
        "password" : password,
        "password_confirmation" : conformPassword
      };
      print(" resetPassword Map : $resetPasswordMap");


      var response = await DI<AuthRepo>().resetPasswordRepo(resetPasswordMap);
      DI<CommonFunction>().hideLoader();

      var responseBody = response.data;
      if(responseBody["success"].toString() == "true"){
        DI<MyLocalStorage>().clearLocalStorage();
        DI<MyLocalStorage>()
            .setBoolValue(DI<MyLocalStorage>().isLogin, false);
        Get.offNamed(DI<RouteHelper>().getLoginScreen());
      }

    }catch(e){
      DI<CommonFunction>().hideLoader();
      log("resetPassword map:-- ",error:  e.toString());
    }

  }

}