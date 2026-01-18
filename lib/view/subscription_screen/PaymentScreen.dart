import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shaadiviha/util/CommonFunction.dart';
import 'package:sizer/sizer.dart';

import '../../controller/profile_controller/ProfileController.dart';
import '../../util/ColorConst.dart';
import '../../util/CommonWidget.dart';
import '../../util/ImageConst.dart';
import '../../util/Injection.dart';
import '../../util/StringConst.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  ProfileController profileController = Get.find<ProfileController>();
  TextEditingController controller = TextEditingController();
  var subId = "",price = "";
  var imageFile = Rxn<File>();
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    controller.text = "810628458@ibl";
    if(Get.parameters["subId"] != null){
      subId = Get.parameters["subId"]??"";
      price = Get.parameters["amount"]??"";
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: DI<ColorConst>().darkPrimaryColor,
       body:  DI<CommonWidget>().gradiantBackGround(
            childWidget: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: kTextTabBarHeight,
                  ),
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios,color: DI<ColorConst>().blackColor,),),
                  SizedBox(
                    height: 10,
                  ),
                  Text(DI<StringConst>().makePaymentHeadingTxt,style: DI<CommonWidget>().myTextStyle(DI<ColorConst>().blackColor,
                      17.sp, FontWeight.w500),
                    maxLines: 3,),
                  Text(DI<StringConst>().makePaymentTxt,style: DI<CommonWidget>().myTextStyle(DI<ColorConst>().blackColor,
                      15.sp, FontWeight.w400),
                    maxLines: 10,),
                  SizedBox(
                    height: 10,
                  ),
      
                  SizedBox(
                    height: 100.w,
                    width: 100.w,
                    child:  FadeInImage.assetNetwork(
                      placeholder: DI<ImageConst>().Loader_Image,
                      placeholderFit: BoxFit.scaleDown,
                      image: "https://miro.medium.com/v2/resize:fit:789/1*A9YcoX1YxBUsTg7p-P6GBQ.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 61.sp,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          DI<ImageConst>().USER_DEFALUT,
                          width: 50.sp,
                          height: 50.sp,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
      
                  TextFormField(
                    controller: controller,
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      border:OutlineInputBorder(borderSide: BorderSide.none),
                      fillColor: DI<ColorConst>().gryLightColor,
                      contentPadding: EdgeInsets.only(right: 10,left:10,bottom:30),
                      prefix: Text("UPI : ",
                        style: DI<CommonWidget>().myTextStyle(DI<ColorConst>().greenColor, 17.sp, FontWeight.w500),),
                      suffix: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: InkWell(
                          onTap: (){
                            Clipboard.setData(ClipboardData(text: controller.text))
                                .then((_) {
                             DI<CommonFunction>().showSnackBar("'Copied to your clipboard !'");
      
                            });
                          },
                          child: Icon(Icons.copy,size: 20,),
                        ),
                      )
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
      
                  Obx(
                    () {
                      return InkWell(
                        onTap: ()async{
                          print("Pick image");
                          await DI<CommonFunction>().selectImage().then(
                          (value) {
                          if(value!=null ){
                          imageFile.value = value;
                          }},);
                        },
                        child: SizedBox(
                          child:  imageFile.value != null? SizedBox(
                              height: 50.w,
                              width: 50.w,
                              child: Image.file(imageFile.value!)):Container(
      
                              color: DI<ColorConst>().lightYellowColor,
                              height: 50.w,
                              width: 50.w,
                              child:Icon(Icons.add,size: 20.w,)
                          ),
                        ),
                      );
                    }
                  ),
      
                ],
              )
            )),
        bottomNavigationBar: SizedBox(
          height: kBottomNavigationBarHeight+20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 7),
            child: DI<CommonWidget>().myButton(
             DI<StringConst>().uploadSSTxt, () {
               if(imageFile.value != null){
                 //profileController.purchaseSubscripation(imageFile.value?.path??"", subId, price);
               }else{
                 DI<CommonFunction>().showSnackBar("Please select screen shot");
               }
      
            }),
          ),
        ),
      ),
    );
  }
}
