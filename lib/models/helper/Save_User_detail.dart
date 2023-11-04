// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:xuriti/logic/view_models/auth_manager.dart';
// import 'package:xuriti/models/core/user_details.dart';
// import 'package:xuriti/models/helper/service_locator.dart';

// class SaveUserDetail {
//   AuthManager authManager = Get.put(AuthManager());

//   Future<void> setUserDetail(Map<String, dynamic> userMap) async {
//     await getIt<SharedPreferences>()
//         .setString('userDetail', json.encode(userMap));
//     return;
//   }

//   void getUserDetail() {
//     String loggedUserData =
//         getIt<SharedPreferences>().getString('userDetail') ?? "";
//     if (loggedUserData == '') {
//       return;
//     }

//     authManager.userDetails?.value =
//         UserDetails.fromJson(json.decode(loggedUserData));
//   }
// }
