import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/models/core/CompanyInfo_model.dart';
import 'package:xuriti/models/core/EntityModel.dart';
import 'package:xuriti/models/core/seller_id_model.dart';
import 'package:xuriti/models/core/seller_info_model.dart';
import 'package:xuriti/models/services/dio_service.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';

import '../../util/common/endPoints_constant.dart';
import '../../util/common/string_constants.dart';

class CompanyDetailsManager extends GetxController {
  CompanyInfo? companyinfo;
  Rx<CompanyInfoV2?> companyInfoV2 = RxNullable<CompanyInfoV2?>().setNull();

  Rx<SellerInfo?>? sellerInfo = RxNullable<SellerInfo?>().setNull();
  Rx<SellerInfo?>? sellerInfoForPartPay = RxNullable<SellerInfo?>().setNull();
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());

  AuthManager authManager = Get.put(AuthManager());

  Rx<SellerIdModel?>? sellerIdModel = RxNullable<SellerIdModel?>().setNull();

  BussinessDetails bussinessDetails = BussinessDetails();

  RxBool isChecked = false.obs;

  String? validateSettleAmount(String settleAMount) {
    if (settleAMount.isNotEmpty) {
      String pattern = r"^\-?[0-9]+(?:\.[0-9]{1,2})?$";
      RegExp regExp = RegExp(pattern);
      return regExp.hasMatch(settleAMount) ? "" : please_enter_valid_amount;
    } else {
      return please_enter_settle_amount;
    }
  }

  isValidateSettleAmount(String settleAMount) {
    bool isValidate;

    String pattern = r"^\-?[0-9]+(?:\.[0-9]{1,2})?$";
    RegExp regExp = RegExp(pattern);
    regExp.hasMatch(settleAMount) ? isValidate = true : isValidate = false;
    return isValidate;
  }

  Future<CompanyInfoV2?> gstSearch2({
    required String gstNo,
  }) async {
    try {
      Map<String, dynamic>? responseData = await DioClient().post(
        searchGstUrl,
        {
          "gstin": gstNo,
        },
      );

      if (responseData != null) {
        if (responseData["status"] == false) {
          companyInfoV2.value = CompanyInfoV2.fromJson(responseData);
        } else if (responseData["status"] == true) {
          companyInfoV2.value = CompanyInfoV2.fromJson(responseData);
        }
      }
      return companyInfoV2.value;
    } catch (e) {
      print(e);
    }
    return null;
  }

  addEntity({
    required dynamic gstNo,
    required String tan,
    required String cin,
    required dynamic adminMobile,
    required String pan,
    required String annualTurnover,
    required String selectedId,
    required dynamic adminEmail,
    required dynamic companyName,
    required dynamic userId,
    required String address,
    required String district,
    required String state,
    required String state1,
    required String pincode,
  }) async {
    String url = addEntityurl;

    List<String> stateList = [];
    stateList.add(state); //"Maharashtra"
    stateList.add(state1); //"MH"
    Map<String, dynamic> registrationData = {};
    registrationData['gstin'] = gstNo;
    registrationData['consent_gst_defaultFlag'] =
        true; //TODO : Check for consent
    registrationData['tan'] = tan;
    registrationData['cin'] = cin;
    registrationData['pan'] = pan;
    registrationData['annual_Turnover'] = annualTurnover;
    registrationData['associated_seller'] = selectedId;
    registrationData['seller_flag'] = false;
    registrationData['admin_mobile'] = adminMobile;
    registrationData['admin_email'] = adminEmail;
    registrationData['companyName'] = companyName;
    registrationData['address'] = address;
    registrationData['district'] = district;
    registrationData['state'] = stateList;
    registrationData['pincode'] = pincode;
    registrationData['userID'] =
        authManager.userDetails?.value?.user?.sId ?? "";

    Map<String, dynamic>? responseData =
        await DioClient().post(url, registrationData);

    if (responseData != null) {
      if (responseData['status'] == true) {
        companyinfo = null;
        return responseData;
      } else {
        return responseData;
      }
    } else {
      return responseData;

      // "errors": {"message": "Entity GSTIN Already Exist"},
      // "status": false
    }
  }

  manualAddEntity({
    required dynamic gstNo,
    required dynamic adminMobile,
    required dynamic pan,
    required dynamic adminEmail,
    required dynamic companyName,
    required dynamic selectedId,
    required dynamic userId,
  }) async {
    String url = addEntityurl;
    Map<String, dynamic> registrationData = {};
    registrationData['consent_gst_defaultFlag'] =
        true; // TODO : Check for the consent
    registrationData['userID'] = userId;
    registrationData['pan'] = pan;
    registrationData['admin_mobile'] = adminMobile;
    registrationData['admin_email'] = adminEmail;
    registrationData['gstin'] = gstNo;
    registrationData['companyName'] = companyName;
    registrationData['associated_seller'] = selectedId;

    Map<String, dynamic>? responseData =
        await DioClient().post(url, registrationData);
    if (responseData != null) {
      if (responseData['status'] == true) {
        companyinfo = null;
        return responseData;
      } else {
        return responseData;
      }
    } else {
      return responseData;

      // "errors": {"message": "Entity GSTIN Already Exist"},
      // "status": false
    }
  }

  Future<Map<String, dynamic>?> getPaymentSummaryDataForPayNowAndPartPay(
      companyId, sellerId,
      [String? partPayAmount]) async {
    if (companyId != null && sellerId != null) {
      //  String url = "/invoice/paymentsummary/?buyer=$companyId&seller=$sellerId";
      String url = paymentSummaryUrl(
          companyID: companyId, sellerPan: sellerId, payAmount: partPayAmount);

      dynamic responseData = await DioClient().get(url);

      if (responseData != null) {
        if (responseData['status'] == true) {
          if (partPayAmount == null) {
            sellerInfo?.value = SellerInfo.fromJson(responseData);
            sellerInfo?.value?.panNo = sellerId;
          } else {
            sellerInfoForPartPay?.value = SellerInfo.fromJson(responseData);
            sellerInfoForPartPay?.value?.panNo = sellerId;
          }
        } else {
          Map<String, dynamic> errorMessage = {
            "msg": somethingWentWrongPlzTryAgain,
          };
          return errorMessage;
        }
      } else {
        Map<String, dynamic> errorMessage = {
          "msg": somethingWentWrongPlzTryAgain,
        };
        return errorMessage;
      }
      return responseData;
    }
    return null;
  }

  Future<SellerIdModel?> getSellerDetails() async {
    try {
      String url = sellerListUrl;

      dynamic responseData = await DioClient().get(url);
      print('000000 $responseData');
      if (responseData != null && responseData['status'] == true) {
        sellerIdModel?.value = SellerIdModel.fromJson(responseData);

        return sellerIdModel?.value;
      } else if (responseData == null) {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  sendPayment({
    required String? buyerId,
    required String? sellerId,
    required String? sellerPan,
    required String orderAmount,
    required String outStandingAmount,
    required String discount,
    required String settle_amount,
  }) async {
    String url = vouchPaymentUrl;

    Map<String, dynamic> data = {
      "buyerid": buyerId,
      "sellerid": sellerId,
      "seller_pan": sellerPan,
      "order_currency": "INR",
      "settle_amount": settle_amount,
      "order_amount": orderAmount,
      "outstanding_amount": outStandingAmount,
      "discount": discount,
      "customer_details": {
        "customer_id": authManager.userDetails?.value?.user?.sId ?? "",
        "customer_email": authManager.userDetails?.value?.user?.email ?? "",
        "customer_phone":
            authManager.userDetails?.value?.user?.mobileNumber ?? "",
      }
    };

    dynamic responseData = await DioClient().post(url, data);
    print('Data.....${responseData}');
    return responseData;
  }
}
