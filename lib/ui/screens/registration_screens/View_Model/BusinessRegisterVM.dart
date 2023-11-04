// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../../models/core/CompanyInfo_model.dart';
// import '../../../../models/core/seller_id_model.dart';
// import '../../../../models/core/user_details.dart';
// import '../../../../models/helper/service_locator.dart';
// import '../../../../models/services/dio_service.dart';

// class RxNullable<T> {
//   Rx<T> setNull() {
//     return (null as T).obs;
//   }
// }

// class BusinessRegisterVM extends GetxController {
//   RxBool showDetails = false.obs;
//   RxBool showButton = false.obs;
//   Rx<SellerIdModel?> sellerIdModel = RxNullable<SellerIdModel?>().setNull();
//   RxString selectedId = "".obs;
//   Rx<CompanyInfoV2?> companyInfoV2 = RxNullable<CompanyInfoV2?>().setNull();
//   RxString? pan = "".obs;

//   Future<CompanyInfoV2?> gstSearch2({
//     required String gstNo,
//     required UserDetails? uInfo,
//   }) async {
//     if (gstNo.isNotEmpty) {
//       pan?.value = gstNo.substring(2, 12);
//     }

//     String url = "/entity/search-gst";
//     Map<String, dynamic> data = {
//       "gstin": gstNo,
//     };

//     try {
//       Map<String, dynamic> responseData =
//           await getIt<DioClient>().post(url, data, token);

//       Map<String, dynamic> registrationData = {};

//       if (responseData["status"] == false) {
//         companyInfoV2.value = CompanyInfoV2.fromJson(responseData);

//         registrationData['industryType'] = "IT";
//         registrationData['annual_Turnover'] = "";
//         registrationData['companyMobile'] = uInfo?.user!.mobileNumber ?? "";
//         registrationData['companyEmail'] = uInfo?.user!.email ?? "";
//         registrationData['admin_mobile'] = uInfo?.user!.mobileNumber ?? "";
//         registrationData['admin_email'] = uInfo?.user!.email ?? "";
//         registrationData['userID'] = uInfo?.user!.sId ?? "";
//         registrationData['dealerName'] = uInfo?.user!.name ?? "";
//         // status = 1;
//       } else if (responseData["status"] == true) {
//         companyInfoV2.value = CompanyInfoV2.fromJson(responseData);

//         registrationData['industryType'] = "IT";
//         registrationData['annual_Turnover'] = "";
//         registrationData['companyMobile'] = uInfo?.user!.mobileNumber ?? "";
//         registrationData['companyEmail'] = uInfo?.user!.email ?? "";
//         registrationData['admin_mobile'] = uInfo?.user!.mobileNumber ?? "";
//         registrationData['admin_email'] = uInfo?.user!.email ?? "";
//         registrationData['userID'] = uInfo?.user!.sId ?? "";
//         registrationData['dealerName'] = uInfo?.user!.name ?? "";
//         // status = 1;
//       }
//       return companyInfoV2.value;
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }

//   addEntity({
//     required dynamic gstNo,
//     required String tan,
//     required String cin,
//     required dynamic adminMobile,
//     required String pan,
//     required String annualTurnover,
//     required String selectedId,
//     required dynamic adminEmail,
//     required dynamic companyName,
//     required dynamic userId,
//     required String address,
//     required String district,
//     required String state,
//     required String pincode,
//   }) async {
//     String url = "/entity/add-entity";
//     Map<String, dynamic> registrationData = {};
//     registrationData['gstin'] = gstNo;
//     registrationData['consent_gst_defaultFlag'] = isChecked;
//     registrationData['tan'] = tan;
//     registrationData['cin'] = cin;
//     registrationData['pan'] = pan;
//     registrationData['annual_Turnover'] = annualTurnover;
//     registrationData['associated_seller'] = selectedId;
//     registrationData['seller_flag'] = false;
//     registrationData['admin_mobile'] = adminMobile;
//     registrationData['admin_email'] = adminEmail;
//     registrationData['companyName'] = companyName;
//     registrationData['address'] = address;
//     registrationData['district'] = district;
//     registrationData['state'] = state;
//     registrationData['pincode'] = pincode;

//     Map<String, dynamic> responseData =
//         await getIt<DioClient>().post(url, registrationData, token);
//     if (responseData != null) {
//       if (responseData['status'] == true) {
//         // companyinfo = null;
//         return responseData;
//       } else {
//         return responseData;
//       }
//     } else {
//       return responseData;

//       // "errors": {"message": "Entity GSTIN Already Exist"},
//       // "status": false
//     }
//   }
// }
