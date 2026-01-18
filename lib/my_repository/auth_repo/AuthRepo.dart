import 'dart:convert';

import 'package:get/get.dart';
import 'package:shaadiviha/model/CityModel.dart';
import 'package:shaadiviha/model/CountryModel.dart';
import 'package:shaadiviha/model/StateModel.dart';
import 'package:shaadiviha/network/ApiService.dart';
import 'package:shaadiviha/network/WebService.dart';
import 'package:shaadiviha/util/Extension.dart';

import '../../util/Injection.dart';

class AuthRepo extends GetxService{


  Future<dynamic> userSignupRepo(Map<String,String> mapBody)async{
    var response = await DI<ApiService>().postMethod(DI<WebService>().registerEndPoint, mapBody);
   print("user signup response :-- ${response.data}");

    return response;
  }

  Future<dynamic> userLoginRepo(Map<String,String> mapBody)async{
    var response = await DI<ApiService>().postMethod(DI<WebService>().loginEndPoint, mapBody);
    print("userLoginRepo response :-- ${response.data}");
    return response;
  }

  //getCountyList
 Future<dynamic> getCountryListRepo()async{
    var response = await DI<ApiService>().getMethod(DI<WebService>().getCountryEndPoint,
        header:mainHeader());
    print("getCountryListRepo response :-- ${response.data}");
    return countryModelFromJson(jsonEncode(response.data));
 }

  //getStateList
  Future<dynamic> getStateListRepo(String id)async{
    var response = await DI<ApiService>().getMethod("${DI<WebService>().getStateEndPoint}$id",
        header:mainHeader());
    print("getStateListRepo response :-- ${response.data}");
    return countryModelFromJson(jsonEncode(response.data));
  }

  //getDistrictList
  Future<dynamic> getDistrictListRepo(String id)async{
    var response = await DI<ApiService>().getMethod("${DI<WebService>().getDistrictEndPoint}$id",
        header:mainHeader());
    print("getDistrictListRepo response :-- ${response.data}");
    return countryModelFromJson(jsonEncode(response.data));
  }

  //getCityList
  Future<dynamic> getCityListRepo(String id)async{
    var response = await DI<ApiService>().getMethod("${DI<WebService>().getCityEndPoint}$id",
        header:mainHeader());
    print("getCityListRepo response :-- ${response.data}");
    return countryModelFromJson(jsonEncode(response.data));
  }

  //getBlockList
  Future<dynamic> getBlockListRepo(String id)async{
    var response = await DI<ApiService>().getMethod("${DI<WebService>().getBlockEndPoint}$id",
        header:mainHeader());
    print("getBlockListRepo response :-- ${response.data}");
    return countryModelFromJson(jsonEncode(response.data));
  }

  //update Address
 Future<dynamic> updateAddressRepo(Map<String,String> mapBody)async{

    print(mainHeader());
    var response = await DI<ApiService>().postMethod(DI<WebService>().updateAddressEndPoint, mapBody,header: mainHeader());
    print("updateAddressRepo response :-- ${response.data}");

    return response;
 }


  //sendOtp
  Future<dynamic> sendVerifyOtpRepo(Map<String,String> mapBody)async{

    print(mainHeader());
    var response = await DI<ApiService>().postMethod(DI<WebService>().sendVerifyOtpEndPoint, mapBody);
    print("sendVerifyOtpRepo response :-- ${response.data}");

    return response;
  }


  //Reset Password
  Future<dynamic> resetPasswordRepo(Map<String,String> mapBody)async{

    print(mainHeader());
    var response = await DI<ApiService>().postMethod(DI<WebService>().resetPasswordEndPoint, mapBody);
    print("resetPasswordRepo response :-- ${response.data}");

    return response;
  }


}
