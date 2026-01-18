import 'package:get/get.dart';


class WebService extends GetxService{


  ///String BASE_URL = "https://admissions-direct.in/shaadiviha-backend/api/v2/";
  String BASE_URL = "https://shaadiviha.com/api/v2/";

  ///String IMAGE_BASE_URL = "https://admissions-direct.in/shaadiviha-backend/storage/";
  String IMAGE_BASE_URL = "https://shaadiviha.com/storage/";


 String registerEndPoint = "register";
 String loginEndPoint = "login";
 String sendVerifyOtpEndPoint = "send-and-verify-otp";
 String resetPasswordEndPoint = "reset-password";

 String getCountryEndPoint = "get-countries";
 String getStateEndPoint = "get-states/";
 String getCityEndPoint = "get-cities/";
 String getDistrictEndPoint = "get-districts/";
 String updateAddressEndPoint = "update-address";
 String updatePersonalDetailsEndPoint = "update-personal-detail";
 String updateProfilePicturesEndPoint = "update-profile-pictures";
 String updateSocialInfoEndPoint = "update-social-information";
 String getUserProfileInfoEndPoint = "user-profile/";
 String getHomeDataEndPoint = "home-page";
 String getHomeScreenUserListEndPoint = "home-page/get-profiles/";
 String interestSendEndPoint = "interest-send";
 String interestResponseEndPoint = "interest-respond";
 String getUserListEndPoint = "get-users";
 String getNotificationEndPoint = "get-notifications";

 String getBlockEndPoint = "get-blocks/";
 String requestResponseEndPoint = "interest-respond";
 String getAllSubscriptionPlansEndPoint = "get-subscription-plans";
 String getMySubscriptionPlansEndPoint = "my-subscription-plans";
 String purchaseSubscriptionPlanEndPoint = "purchase-subscription-plan";
 String deleteAccountApi = "delete-account";

  String getMotherTonguesEndPoint = "get-mother-tongues";
  String getOccupationEndPoint = "get-occupations";
  String getEducationEndPoint = "get-educations";
  String getReligionEndPoint = "get-religions";
  String getCastesEndPoint = "get-castes/";



 

}