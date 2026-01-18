import 'package:get/get.dart';

import '../view/auth/add_photo_screen/AddPhotoScreen.dart';
import '../view/auth/address_screen/AddressScreen.dart';
import '../view/auth/change_password_screen/ChangePasswordScreen.dart';
import '../view/auth/forgot_password_module/ForgotPasswordScreen.dart';
import '../view/auth/login_screen/LoginScreen.dart';
import '../view/auth/otp_verification_screen/OtpVerificationScreen.dart';
import '../view/auth/personal_info/PersonalInfoScreen.dart';
import '../view/auth/signup_screen/SignupScreen.dart';
import '../view/auth/social_details/SocialDetailsScreen.dart';
import '../view/home_screen/HomeScreen.dart';
import '../view/home_tab_Screen/HomeTabScreen.dart';
import '../view/notification_screen/NotificationScreen.dart';
import '../view/person_detail_screen/PersonDetailScreen.dart';
import '../view/profile_screen/ProfileScreen.dart';
import '../view/search_screen/SearchScreen.dart';
import '../view/splash_screen/SplashScreen.dart';
import '../view/subscription_screen/PaymentScreen.dart';
import '../view/subscription_screen/SubscriptionScreen.dart';
import '../view/user_list_screen/UserListScreen.dart';
import '../view/webview_screen/WebViewScreen.dart';


class RouteHelper {
  String splashscreen = "/Splashscreen";
  String loginScreen = "/LoginScreen";
  String signupScreen = "/SignupScreen";
  String personalInfoScreen = "/PersonalInfoScreen";
  String socialDetailScreen = "/SocialDetailScreen";
  String addPhotoScreen = "/AddPhotoScreen";
  String homeTabScreen = "/HomeTabScreen";
  String homeScreen = "/HomeScreen";
  String profileScreen = "/ProfileScreen";
  String searchScreen = "/SearchScreen";
  String userListScreen = "/UserListScreen";
  String notificationScreen = "/NotificationScreen";
  String personDetailScreen = "/PersonDetailScreen";
  String webViewScreen = "/WebViewScreen";
  String addressScreen = "/AddressScreen";
  String subscriptionScreen = "/SubscriptionScreen";
  String paymentScreen = "/PaymentScreen";
  String forgotPasswordScreen = "/ForgotPasswordScreen";
  String otpVerificationScreen = "/OtpVerificationScreen";
  String changePasswordScreen = "/ChangePasswordScreen";





  String getSplashscreen() => splashscreen;
  String getLoginScreen() => loginScreen;
  String getSignupScreen() => signupScreen;
  String getPersonalInfoScreen() => personalInfoScreen;
  String getSocialDetailScreen() => socialDetailScreen;
  String getAddPhotoScreen() => addPhotoScreen;
  String getHomeTabScreen() => homeTabScreen;
  String getHomeScreen() => homeScreen;
  String getProfileScreen() => profileScreen;
  String getSearchScreen() => searchScreen;
  String getUserListScreen() => userListScreen;
  String getNotificationScreen() => notificationScreen;
  String getPersonDetailScreen() => personDetailScreen;
  String getWebViewScreen() => webViewScreen;
  String getAddressScreen() => addressScreen;
  String getSubscriptionScreen() => subscriptionScreen;
  String getPaymentScreen() => paymentScreen;
  String getForgotPasswordScreen() => forgotPasswordScreen;
  String getOtpVerificationScreen() => otpVerificationScreen;
  String getChangePasswordScreen() => changePasswordScreen;





  List<GetPage>  get routes => [
    GetPage(name: splashscreen, page: () => SplashScreen(),),
    GetPage(name: loginScreen, page: () => LoginScreen(),),
    GetPage(name: signupScreen, page: () => SignupScreen(),),
    GetPage(name: personalInfoScreen, page: () => PersonalInfoScreen(),),
    GetPage(name: socialDetailScreen, page: () => SocialDetailScreen(),),
    GetPage(name: addPhotoScreen, page: () => AddPhotoScreen(),),
    GetPage(name: homeTabScreen, page: () => HomeTabScreen(),),
    GetPage(name: homeScreen, page: () => HomeScreen(),),
    GetPage(name: profileScreen, page: () => ProfileScreen(),),
    GetPage(name: searchScreen, page: () => SearchScreen(),),
    GetPage(name: userListScreen, page: () => UserListScreen(),),
    GetPage(name: notificationScreen, page: () => NotificationScreen(),),
    GetPage(name: personDetailScreen, page: () => PersonDetailScreen(),),
    GetPage(name: webViewScreen, page: () => WebViewScreen(),),
    GetPage(name: addressScreen, page: () => AddressScreen(),),
    GetPage(name: subscriptionScreen, page: () => SubscriptionScreen(),),
    GetPage(name: paymentScreen, page: () => PaymentScreen(),),
    GetPage(name: forgotPasswordScreen, page: () => ForgotPasswordScreen(),),
    GetPage(name: otpVerificationScreen, page: () => OtpVerificationScreen(),),
    GetPage(name: changePasswordScreen, page: () => ChangePasswordScreen(),),

  ];
}