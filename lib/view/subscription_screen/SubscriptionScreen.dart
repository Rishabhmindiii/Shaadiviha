import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shaadiviha/controller/profile_controller/ProfileController.dart';
import 'package:shaadiviha/util/ColorConst.dart';
import 'package:shaadiviha/util/CommonFunction.dart';
import 'package:shaadiviha/util/RouteHelper.dart';
import 'package:shaadiviha/util/StringConst.dart';
import 'package:sizer/sizer.dart';

import '../../services/RazorPayInterIntegration.dart';
import '../../util/CommonWidget.dart';
import '../../util/ConstValue.dart';
import '../../util/Injection.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen>
    implements RazorPayIntegration {
  ProfileController profileController = Get.find<ProfileController>();
  final String _razorpayKey = "rzp_test_SyCcTGb6Mes0lx";
  final Razorpay _razorpay = Razorpay();
  String orderId = "";

  var currentIndex = 0.obs;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    DI<ConstValue>().fromSubscription = false;
    profileController.getSubscripationList();
    currentIndex.value = -1;
    initiateRazorPay();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DI<CommonWidget>().gradiantBackGround(
            childWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Obx(() {
            if (profileController.profileLoading.value) {
              return SizedBox();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: kTextTabBarHeight,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: DI<ColorConst>().blackColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  DI<StringConst>().subscripationHeadingTxt,
                  style: DI<CommonWidget>().myTextStyle(
                      DI<ColorConst>().blackColor, 17.sp, FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  DI<StringConst>().subscripationDataTxt,
                  style: DI<CommonWidget>().myTextStyle(
                      DI<ColorConst>().blackColor, 15.sp, FontWeight.w400),
                  maxLines: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                profileController.subscripationModel.value != null
                    ? Expanded(
                        child: GridView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: profileController
                            .subscripationModel.value?.data.length,
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 7.0,
                          mainAxisSpacing: 7.0,
                          childAspectRatio: 0.98,
                        ),
                        itemBuilder: (context, indexInner) {
                          var listData =
                              profileController.subscripationModel.value?.data;
                          return Obx(
                            () => InkWell(
                              onTap: () {
                                currentIndex.value = indexInner;
                              },
                              child: Card(
                                color: currentIndex.value == indexInner
                                    ? DI<ColorConst>()
                                        .darkBlueColor
                                        .withOpacity(0.3)
                                    : DI<ColorConst>().whiteColor,
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    side: BorderSide(
                                        color: currentIndex.value == indexInner
                                            ? DI<ColorConst>().lightGreenColor
                                            : Colors.transparent)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7.w, vertical: 3.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        listData?[indexInner].name ?? "",
                                        style: DI<CommonWidget>().myTextStyle(
                                            DI<ColorConst>().blackColor,
                                            18.sp,
                                            FontWeight.w700),
                                        maxLines: 1,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "${listData?[indexInner].duration ?? ""} months",
                                        style: DI<CommonWidget>().myTextStyle(
                                            DI<ColorConst>().blackColor,
                                            17.sp,
                                            FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        listData?[indexInner].description ?? "",
                                        style: DI<CommonWidget>().myTextStyle(
                                            DI<ColorConst>().blackColor,
                                            15.sp,
                                            FontWeight.w500),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "₹${listData?[indexInner].price ?? ""}",
                                        style: DI<CommonWidget>().myTextStyle(
                                            DI<ColorConst>().blackColor,
                                            15.sp,
                                            FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ))
                    : SizedBox.shrink(),
              ],
            );
          }),
        )),
        bottomNavigationBar: Obx(
          () => currentIndex.value != -1
              ? Container(
                  color: DI<ColorConst>().darkPrimaryColor,
                  height: kBottomNavigationBarHeight + 15,
                  width: 100.w,
                  alignment: Alignment.center,
                  child: Container(
                    width: 100.sp,
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (currentIndex.value != -1) {
                          openRazorPaySession(
                              int.parse(profileController.subscripationModel.value
                                      ?.data[currentIndex.value].price ??
                                  "0"),
                              profileController.subscripationModel.value
                                      ?.data[currentIndex.value].name ??
                                  "",
                              profileController.subscripationModel.value
                                      ?.data[currentIndex.value].description ??
                                  "");
                        } else {
                          DI<CommonFunction>()
                              .showSnackBar("Please Select Plain");
                        }
                      },
                      style: ButtonStyle(
                          elevation: WidgetStatePropertyAll(3.0),
                          padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 15)),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(
                                  color: DI<ColorConst>().whiteColor, width: 1.3),
                            ),
                          ),
                          backgroundColor: WidgetStatePropertyAll(DI<ColorConst>()
                              .darkPrimaryColor
                              .withOpacity(0.7))),
                      child: Text(
                        DI<StringConst>().purchaseText,
                        style: DI<CommonWidget>().myTextStyle(
                            DI<ColorConst>().colorPrimary,
                            16.sp,
                            FontWeight.w500),
                      ),
                    ),
                  )
      
                  /* InkWell(
            onTap: (){
              if(currentIndex.value != -1){
      
                // Test Card :-- 4718 6091 0820 4366
      
              */ /*  Map<String, String>? data = {
                  "subId" : profileController.subscripationModel.value?.data[currentIndex.value].id??"",
                  "amount" : profileController.subscripationModel.value?.data[currentIndex.value].price??"",
                };
                Get.toNamed(DI<RouteHelper>().getPaymentScreen(),parameters: data);*/ /*
      
                openRazorPaySession(
                    int.parse(profileController.subscripationModel.value?.data[currentIndex.value].price??"0"),
                    profileController.subscripationModel.value?.data[currentIndex.value].name??"",
                    profileController.subscripationModel.value?.data[currentIndex.value].description??"");
              }else{
                DI<CommonFunction>().showSnackBar("Please Select Plain");
              }
      
            },
            child: Text(DI<StringConst>().purchaseText ,
              style: DI<CommonWidget>().myTextStyle(
                  DI<ColorConst>().whiteColor, 17.sp, FontWeight.w400),),
          ),*/
                  )
              : SizedBox.shrink(),
        ),
      ),
    );
  }

  @override
  void handleExternalWallet(ExternalWalletResponse externalWalletResponse) {
    String chosenWallet =
        externalWalletResponse.walletName ?? ""; // Capture chosen wallet name
    switch (chosenWallet) {
      case 'paytm':
        // Display specific information for Paytm
        break;
      case 'freecharge':
        // Display specific information for Freecharge
        break;
      default:
      // Handle other wallets
    }
  }

  @override
  void handlePaymentError(PaymentFailureResponse paymentFailureResponse) {
    // TODO: implement handlePaymentFailureEvent

    print('PaymentFailureResponse ${paymentFailureResponse.error}');
    print('PaymentFailureResponse ${paymentFailureResponse.code}');
    print('PaymentFailureResponse ${paymentFailureResponse.message}');

    /// here just show the payment failure message with the help of snackbar.
    DI<CommonFunction>()
        .showSnackBar(paymentFailureResponse.message.toString());
  }

  @override
  void handlePaymentSuccess(PaymentSuccessResponse successResponse) {
    // TODO: implement handlePaymentSuccessEvent
    print('successResponse paymentId:- ${successResponse.paymentId}');
    print('successResponse orderId:- ${successResponse.orderId}');
    print('successResponse signature:-  ${successResponse.signature}');

    /// here is i just show snackBar with provided success response message, you can add here verify signature code.
    DI<CommonFunction>().showSnackBar(
      successResponse.orderId == null ||
              successResponse.orderId.toString() == ""
          ? "Payment Successfully Done"
          : successResponse.orderId.toString(),
    );

    profileController.purchaseSubscripation(
        profileController
                .subscripationModel.value?.data[currentIndex.value].id ??
            "",
        successResponse.paymentId ?? "N/A",
        orderId,
        successResponse.signature ?? "N/A");
  }

  @override
  initiateRazorPay() {
    // TODO: implement initializeRazorpay
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  void openRazorPaySession(
      int price, String productName, String productDescription) {
    print('price $price');
    print('productName $productName');
    print('productDescription $productDescription');

    orderId = "order_${generateRandomOrderId(10)}";

    print('orderId $orderId');

    try {
      var options = {
        'key': _razorpayKey,
        'amount': price * 100,
        'currency': 'INR',
        'name': productName,
        'description': productDescription,
        // "order_id":orderId, -- when we use live setup .....
        'prefill': {'contact': '+918109628458', 'email': 'rishabh@yopmail.com'},
      };
      _razorpay.open(options);
    } catch (error) {
      print("error ==>$error");
    }
  }

  String generateRandomOrderId(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();
    return List.generate(length, (index) => chars[rand.nextInt(chars.length)])
        .join();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
}
