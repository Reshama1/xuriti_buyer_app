import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/core/user_details.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/models/services/dio_service.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/ui/screens/signup_and_login_screens/login_screen.dart';
import 'package:xuriti/util/common/key_value_sharedpreferences.dart';
import '../../util/common/endPoints_constant.dart';
import '../../util/common/string_constants.dart';

class OTPVerificationStatus extends GetxController {
  RxBool otpSent = false.obs;
  RxBool numberVerified = false.obs;
  RxBool isPinError = false.obs;
  RxBool isConfirmPinError = false.obs;
  RxBool pinValidated = false.obs;
}

class AuthManager extends GetxController {
  Rx<UserDetails?>? userDetails = RxNullable<UserDetails?>().setNull();
  bool userCreated = false;
  Rx<OTPVerificationStatus> otpVerificationStatusForMobileNumber =
      OTPVerificationStatus().obs;
  String platformVersion = 'Unknown';
  String? appdata = 'Unknown';
  String? fcmToken;

  Future<Map<String, dynamic>?> registerUser(
      {required String firstName,
      required String lastName,
      required String mobileNumber,
      required String email,
      required String password,
      required String confirmPassword,
      // required String loginPin,
      String? googleUserId}) async {
    String url = registerUserUrl;
    Map<String, dynamic> data = {
      "firstName": firstName,
      "lastName": lastName,
      "mobileNumber": mobileNumber,
      "gid": googleUserId ?? "",
      "email": email,
      "password": password,
      // "pin": loginPin,
    };

    Map<String, dynamic>? responseData = await DioClient().post(url, data);
    if (responseData != null) {
      userDetails?.value = UserDetails.fromJson(responseData);

      // if (userDetails != null) {
      //   SaveUserDetail().setUserDetail(responseData);
      // }
    }
    return responseData;
  }

  forgotPassword({required String email}) async {
    String url = forgotPasswordUrl;
    Map<String, dynamic> data = {
      "email": email,
    };
    Map<String, dynamic>? responseData = await DioClient().post(url, data);
    print(responseData);
    return responseData;
  }

  sendVerificationCodeTo({required String phoneNumber}) async {
    if (phoneNumber.length != 10) {
      return;
    } else {
      String url = otpSendUrl;
      Map<String, dynamic> data = {"recipient": phoneNumber};
      Map<String, dynamic>? responseData = await DioClient().post(url, data);
      if (responseData?['status'] == true) {
        otpVerificationStatusForMobileNumber.value.otpSent.value = true;
      } else {}

      return responseData;
    }
  }

  Future<Map<String, dynamic>?> verifyOTPCodeWithForgetPinFlow({
    required String emailId,
    required String otp,
  }) async {
    Map<String, dynamic> data = {"email": emailId, "otp": otp};
    Map<String, dynamic>? responseData =
        await DioClient().put(verifyOTPForPinURL, data);

    return responseData;
  }

  Future<Map<String, dynamic>?> setNewPinForGivenEmail({
    required String emailId,
    required String pin,
    String? currentPin,
  }) async {
    Map<String, dynamic> requestBody = {
      "email": emailId,
      "pin": pin,
      "cpin": pin,
    };

    if (currentPin != null) {
      requestBody["currentpin"] = currentPin;
    }

    Map<String, dynamic>? responseData =
        await DioClient().post(resetPinForURL, requestBody);

    return responseData;
  }

  Future<Map<String, dynamic>?> verifyOTPCode(
      {required String mobileNumber, required String otp}) async {
    Map<String, dynamic> data = {
      "mobileNumber": mobileNumber,
      "otp": otp,
    };
    Map<String, dynamic>? responseData =
        await DioClient().post(otpVerifyUrl, data);
    if (responseData?["status"] == true) {
      otpVerificationStatusForMobileNumber.value.numberVerified.value = true;
    }
    return responseData;
  }

  signInWithEmailAndPassword({
    required String email,
    required String password,
    required LoginOption loginOption,
  }) async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    print('device tkn ;;;;;;;;;;; $deviceToken');

    late Map<String, dynamic> response;

    Map<String, dynamic> data = {
      "${int.tryParse(email) != null ? "mobile" : "email"}": email,
      "${LoginOption.password == loginOption ? "password" : "pin"}": password,
      "recaptcha": "test_recaptcha",
      "login_type": 'mobile_app',
      "device_id": deviceToken
      //"fcm_token": deviceToken
    };

    Map<String, dynamic>? responseData =
        await DioClient().post(userLoginUrl, data);

    if (responseData != null) {
      if (responseData["status"] == false) {
        return responseData;
      } else {
        // responseData["login_pin"] = false;
        userDetails?.value = UserDetails.fromJson(responseData);

        await getIt<SharedPreferences>().setString(
            SharedPrefKeyValue.loggedUserEmail,
            userDetails?.value?.user?.email ?? "");

        await getIt<SharedPreferences>().setBool(
            SharedPrefKeyValue.recentLoggedUserIsPinSet,
            userDetails?.value?.login_pin ?? false);

        await getIt<SharedPreferences>().setString(
            SharedPrefKeyValue.recentLoggedUserName,
            userDetails?.value?.user?.name ?? "");

        // notification code after app terminated

        await getIt<SharedPreferences>().getBool("isPushNotificationFlow");

        if (userDetails?.value?.user?.userRole == "xuritiAdmin") {
          return response = {
            'status': false,
            'message': youAreNotAllowedToAccessThisPanel
          };
        }
        if (userDetails != null) {
          // SaveUserDetail().setUserDetail(responseData);

          return responseData;
        }
        response = {'status': false, 'message': unexpectedErrorOccuredMes};

        return response;
        // notifyListeners();
      }
    } else {
      response = {'status': false, 'message': unexpectedErrorOccuredMes};
      return response;
    }
  }

  /// API for forgot PIN
  Future<Map<String, dynamic>?> forgotPin({required String email}) async {
    Map<String, dynamic>? forgotPinResponse =
        await DioClient().post(forgotPinURL, {"email": email});

    return forgotPinResponse;
  }

  logOut() async {
    String url = userLogoutUrl;

    await DioClient().post(
      url,
      {"userID": userDetails?.value?.user?.sId ?? ""},
    );
    //before clear local storage
    String? savedEmail = getIt<SharedPreferences>().getString(
      SharedPrefKeyValue.loggedUserEmail,
    );

    String? lastGreetTimeStamp = getIt<SharedPreferences>().getString(
      SharedPrefKeyValue.greetTimeStampShownAt,
    );

    String? userName = getIt<SharedPreferences>().getString(
      SharedPrefKeyValue.recentLoggedUserName,
    );

    bool? isPinSet = getIt<SharedPreferences>().getBool(
      SharedPrefKeyValue.recentLoggedUserIsPinSet,
    );

    String? lastGreetDateTime = getIt<SharedPreferences>()
        .getString(SharedPrefKeyValue.greetTimeStampShownAt);

    //clear local storage
    getIt<SharedPreferences>().clear();

    //after clear local storage
    getIt<SharedPreferences>()
        .setString(SharedPrefKeyValue.loggedUserEmail, savedEmail ?? "");

    await getIt<SharedPreferences>().setBool(
        SharedPrefKeyValue.recentLoggedUserIsPinSet, isPinSet ?? false);

    await getIt<SharedPreferences>()
        .setString(SharedPrefKeyValue.recentLoggedUserName, userName ?? "");

    await getIt<SharedPreferences>().setString(
        SharedPrefKeyValue.greetTimeStampShownAt, lastGreetTimeStamp ?? "");

    await getIt<SharedPreferences>().setString(
        SharedPrefKeyValue.greetTimeStampShownAt, lastGreetDateTime ?? "");
    await getIt<SharedPreferences>().setString('onboardViewed', 'true');
    await FirebaseMessaging.instance.deleteToken();
    userDetails?.value = null;
    if (getIt<SharedPreferences>().getBool('isgLogin') == true) {
      await googleSignIn.signOut();
    }
  }

  final googleSignIn = GoogleSignIn(signInOption: SignInOption.standard);
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  googleLogin({required bool isSignIn}) async {
    if (googleSignIn.currentUser != null) {
      await googleSignIn.signOut();
    }
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    String? idToken = googleAuth.idToken ?? '';

    Map<String, dynamic> gResponse =
        await apiGoogleLogin(_user!.email, _user!.id, idToken);

    if (gResponse['status'] == false) {
      if (isSignIn == true) {
        await googleSignIn.signOut();
      } else {
        return gResponse;
      }
    } else {
      userDetails?.value = UserDetails.fromJson(gResponse);

      await getIt<SharedPreferences>().setString(
          SharedPrefKeyValue.loggedUserEmail,
          userDetails?.value?.user?.email ?? "");

      await getIt<SharedPreferences>().setBool(
          SharedPrefKeyValue.recentLoggedUserIsPinSet,
          userDetails?.value?.login_pin ?? false);

      await getIt<SharedPreferences>().setString(
          SharedPrefKeyValue.recentLoggedUserName,
          userDetails?.value?.user?.name ?? "");

      // notification code after app terminated

      await getIt<SharedPreferences>().getBool("isPushNotificationFlow");

      // uInfo = userDetails;
      // SaveUserDetail().setUserDetail(gResponse);
      // await getIt<UserInfoService>().addData(userDetails);
      return gResponse;
    }
  }

  apiGoogleLogin(email, gid, String idToken) async {
    String url = googleLoginUrl;
    // "/auth/google-login";
    Map<String, dynamic> data = {
      "email": email,
      "gid": gid,
      "id_token": idToken
    };

    Map<String, dynamic>? responseData = await DioClient().post(url, data);

    return responseData;
  }

  // logInViaApple() async {
  //   final AuthorizationResult result = await TheAppleSignIn.performRequests([
  //     AppleIdRequest(requestedScopes: [
  //       Scope.email,
  //       Scope.fullName,
  //     ]),
  //   ]);

  //   switch (result.status) {
  //     case AuthorizationStatus.authorized:
  //       print(result.credential?.user);
  //       break;
  //     case AuthorizationStatus.error:
  //       print("Sign in failed: ${result.error?.localizedDescription}");
  //       break;
  //     case AuthorizationStatus.cancelled:
  //       print("User cancelled");
  //       break;

  //       break;
  //     default:
  //   }
  // }

  getIPAddress(String url) async {
    try {
      String finalUrl = "https://biz.xuriti.app/api";
      String urlLink = finalUrl + url;

      final response = await DioClient().get(urlLink);
      return response;
    } catch (e) {
      return null;
    }
  }
}
