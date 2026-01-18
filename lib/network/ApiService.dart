import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as DIO;
import 'package:get/get.dart';
import '../util/CommonWidget.dart';
import '../util/Injection.dart';
import 'WebService.dart';

class ApiService extends GetxService {
  final DIO.Dio dio = DIO.Dio();
  final int timeoutInSeconds = 30;
  final DIO.LogInterceptor loggingInterceptor = DIO.LogInterceptor();

  //For getMethod
  Future<dynamic> getMethod(String endPoint,{Map<String, dynamic>? header}) async {
    DIO.Response? response;

    try {
      print("baseUrl --- ${DI<WebService>().BASE_URL + endPoint} ");
      response = await dio.get(DI<WebService>().BASE_URL + endPoint,
          options: DIO.Options(
          headers:header?? {
            "Content-Type": "application/json", // Ensure it's sent as raw JSON
          },
          ),);
      return returnResponse(response);
    } catch (e) {
      if (e is DIO.DioException) {
        if (e.response != null) {
          response = e.response;
          return returnResponse(e.response!);
        }
      } else {
        log("NO Dio Error: $e");
      }
    }
    return returnResponse(response!);
  }


  //For postMethod
  Future<dynamic> postMethod(
      String endPoint, Map<String, dynamic>? body,
      {Map<String, dynamic>? header}) async
  {
    DIO.Response? response;
    try {
      print("baseUrl post--- ${DI<WebService>().BASE_URL}$endPoint");

      response = await dio.post(
        "${DI<WebService>().BASE_URL}$endPoint",
        data: body,
        options: DIO.Options(
          headers:header ?? {
            "Content-Type": "application/json",
          },
        ),
      );
      return returnResponse(response);
    } catch (e) {
      if (e is DIO.DioException) {
        if (e.response != null) {
          response = e.response;
          return returnResponse(e.response!);
        } else {
          log("Error:-- ${e.message}");
        }
      } else {
        log("NO Dio Error: $e");
      }
    }
    return returnResponse(response!);
  }

  //For multipart method
  Future<dynamic> multipartPostMethod(String endPoint, String profileKeyName,
      String filePath, Map<String, dynamic> body, header,{List<String>? imagePathList})
  async {
    print("filePath2 : $profileKeyName");
    DIO.FormData? formData;

    final Map<String, dynamic> formMap = {...body};

    if (filePath.isNotEmpty && imagePathList == null) {
      formMap[profileKeyName] = await DIO.MultipartFile.fromFile(filePath, filename: filePath.split('/').last.toString(), contentType: DIO.DioMediaType('image', filePath.split('/').last.split('.').last.toString()));
    }else{
      for(int i = 0; i < imagePathList!.length; i++){
        final filePath = imagePathList[i];
        if (filePath.isNotEmpty) {
          final fileName = filePath.split('/').last;
          final fileExt = fileName.split('.').last.toString();

          formMap['profile_pictures[$i]'] = await DIO.MultipartFile.fromFile(
            filePath,
            filename: fileName,
            contentType: DIO.DioMediaType('image', fileExt)
          );
        }
      }
    }


    print("multipart formMap :-- $formMap");

    formData = DIO.FormData.fromMap(formMap);

    var response;

    try {
      response = await dio.post(
        DI<WebService>().BASE_URL + endPoint,
        data: formData,
        options: DIO.Options(headers: header),
      );
    } catch (e) {
      if (e is DIO.DioException) {
        if (e.response != null) {
          response = e.response;
          return returnResponse(e.response!);
        } else {
          log("Error: ${e.message}");
        }
      } else {
        log("NO Dio Error: $e");
      }
    }
    return returnResponse(response);
  }


  Future<DIO.Response> returnResponse(DIO.Response response) async {

    if(response.data["success"].toString() == "false"){

      if(response.data["message"].toString().toLowerCase() != "subscription required"){
        DI<CommonWidget>().errorDialog(response.data["message"], () {
          Get.back();
        });
        return response;
      }


      return response;
    }

    if (response.statusCode != 200) {
      print("response code:-- ${response.data["error"]["code"]}");
      print("response :-- ${response.data["error"]["message"]}");

      if(response.data["error"]["message"].toString().toLowerCase() != "subscription required"){
        DI<CommonWidget>().errorDialog(response.data["error"]["message"], () {
          Get.back();
        });
        return response;
      }



      return response;
    }
    return response;
  }
}

