import 'package:get/get.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import '../../models/services/dio_service.dart';
import '../../util/common/endPoints_constant.dart';
import '../../util/common/string_constants.dart';

class ProfileManager extends GetxController {
  AuthManager authManager = Get.put(AuthManager());

  updateProfile({
    required String? name,
    required String? gid,
    required String? email,
    required String? mobileNo,
    required String? password,
    required String fName,
    required String lName,
    required String? userRole,
  }) async {
    String url = update_deleteProfileurl(
        userID: authManager.userDetails?.value?.user?.sId ?? "");
    // "/user/$id";
    Map<String, dynamic> data = {
      "name": name,
      "gid": gid,
      "email": email,
      "mobileNumber": mobileNo,
      "password": password,
      "firstName": fName,
      "lastName": lName,
      "userRole": userRole,
      "registeredBy": authManager.userDetails?.value?.user?.sId ?? ""
    };

    dynamic responseData = await getIt<DioClient>().put(
      url,
      data,
    );

    return responseData;
  }

  updatePassword({required String id}) async {
    String url = "/auth/reset-password/:id/:token";

    Map<String, dynamic> data = {
      "_id": authManager.userDetails?.value?.user?.sId ?? ""
    };
    Map<String, dynamic>? responseData = await DioClient().post(url, data);
    return responseData;
  }

  forgotPassword({required String email}) {
    String url = forgotPasswordUrl;

    Map<String, dynamic> data = {"email": email};
    dynamic responseData = DioClient().post(url, data);
    return responseData;
  }

  getTermsAndConditions() {
    String url = getTermsConditionsUrl;

    dynamic responseData = DioClient().get(url);
    ;
    if (responseData != null) {
      return responseData;
    } else {
      return {"status": false};
    }
  }

  deleteProfile() async {
    final String deleteUrl = update_deleteProfileurl(
        userID: authManager.userDetails?.value?.user?.sId ??
            ""); // "/user/$id"; //api integrate

    Map<String, dynamic> data = {
      "_id": authManager.userDetails?.value?.user?.sId ?? ""
    };
    dynamic responseData = await getIt<DioClient>().delete(
      deleteUrl,
      data,
    );
    print(responseData);
    if (responseData.statusCode == 200) {
      // Map<String, dynamic> isdDeleteCheck = responseData.data;
      if (responseData != null && responseData.data['status'] == true) {
        print("Deleted");
        return true;
      } else {
        return false;
      }
      // return responseData;
    } else {
      throw sorry_unable_to_delete_profile;
    }
  }

  getContactUs() {
    String url = getContactUsUrl;

    dynamic responseData = DioClient().get(url);
    ;
    if (responseData != null) {
      return responseData;
    } else {
      return {"status": false};
    }
  }
}
