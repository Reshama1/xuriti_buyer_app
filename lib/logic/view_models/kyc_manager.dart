import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/Model/KycStatusDetails.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';

import 'package:xuriti/models/core/captcha/captcha_data_model.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/models/core/mobile_verification_model.dart';
import 'package:xuriti/models/helper/Map_To_FormData.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/models/services/dio_service.dart';
import 'package:xuriti/utility_extension/file+multipart.dart';
import '../../new modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import '../../util/common/endPoints_constant.dart';
import 'package:dio/dio.dart' as dio;

import '../../util/common/string_constants.dart';

class KycManager extends GetxController {
  MapToFormData convert = MapToFormData();

  MobileVerificationModel mobileVerificationModel = MobileVerificationModel();
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  AuthManager authManager = Get.put(AuthManager());

  Rx<CaptchaDataModel?> captchaDataModel =
      RxNullable<CaptchaDataModel?>().setNull();
  Rx<KYCStatusModel?>? kycStatusModel = RxNullable<KYCStatusModel?>().setNull();

  dynamic otpReferenceId = '';
  bool? flag;

  String? userID = getIt<SharedPreferences>().getString('id');

  storePanCardDetails(String panNo, {required String filePath}) async {
    dynamic panfile = filePath;

    final panNumberRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    if ((panfile != "") &&
        panNo.isNotEmpty &&
        panNo != '' &&
        panNumberRegex.hasMatch(panNo)) {
      var body = new Map<String, dynamic>();
      body['company_id'] =
          companyListViewModel.selectedCompany.value?.companyId;
      body['pan_number'] = panNo;
      // body["pan"] = await File(filePath).getMultipartDatafromFile();

      var ocr = new Map<String, dynamic>();
      ocr['company_id'] = companyListViewModel.selectedCompany.value?.companyId;
      ocr['pan'] = await File(filePath).getMultipartDatafromFile();

      dynamic responseData =
          await getIt<DioClient>().pan_captured_data(panOcrUrl, ocr);
      if (responseData != null && responseData.runtimeType != String) {
        if (responseData['status'] == true) {
          dynamic verifyresponseData =
              await DioClient().verify_pan(panVerifyUrl, body);
          if (verifyresponseData == null) {
            return;
          }
          if (verifyresponseData['status'] == true) {
            Map<String, dynamic> successMessage = {
              'msg': pan_details_saved_successfully,
              'error': false
            };
            return successMessage;
          } else {
            Map<String, dynamic> errorMessage = {
              'msg': enter_all_mandatory_field,
              'error': true
            };
            return errorMessage;
          }
        } else {
          Map<String, dynamic> errorMassage = {
            'msg': unable_to_capture_data,
            'error': true
          };
          print("error:--$errorMassage");
          return errorMassage;
        }
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': unable_to_proceed,
        };
        print("error:--$errorMessage");
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMassage = {
        'msg': plzUploadPanImage,
        'error': true
      };
      print("errorMassage:---$errorMassage");
      return errorMassage;
    }
  }

  generateAdharOtp(String? uid, String security_code,
      {required String captchaSessionId}) async {
    String url = captchaVerifyUrl;

    if (uid != null &&
        security_code.isNotEmpty &&
        int.tryParse(uid) != null &&
        uid.length == 12) {
      // var map = new Map<String, dynamic>();

      // map['companyId'] = companyId;

      Map<String, dynamic> data = {
        'uid': uid,
        'security_code': security_code,
        'sessionId': captchaSessionId
      };

      dynamic responseData = await DioClient().aadhaar_otp(url, data);
      print("a otp $responseData");
      if (responseData != null && responseData.runtimeType != String) {
        print(responseData);
        if (responseData['status'] == true) {
          Map<String, dynamic> successMessage = {
            'msg': otp_sent_to_registered_mobile_number,
          };
          return successMessage;
        } else {
          Map<String, dynamic> errorMessage = {
            'msg': please_enter_all_mandatory_fields,
          };
          return errorMessage;
        }
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': unable_to_proceed,
        };
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': please_enter_valid_document_number,
      };
      return errorMessage;
    }
  }

  storeOwnershipProof(String? docNo, String? docType,
      {required String filePath}) async {
    // kycModel.propertyOwnership = filePath;
    // kycModel.ownershipDocNumber = docNo;
    // kycModel.ownershipDocType = docType;

    // Map<String, dynamic> data = kycModel.toJson();
    final allowedDocCharacters = RegExp(r'^[a-zA-Z0-9_-]*$');
    if (docNo != null &&
        docNo != '' &&
        docType != null &&
        filePath.isNotEmpty &&
        allowedDocCharacters.hasMatch(docNo)) {
      var map = new Map<String, dynamic>();
      dynamic userID = authManager.userDetails?.value?.user?.sId ?? "";
      map['companyId'] = companyListViewModel.selectedCompany.value?.companyId;
      map['ownershipDocType'] = docType;
      map['ownershipDocNumber'] = docNo;
      map['propertyOwnership'] =
          await File(filePath).getMultipartDatafromFile();
      map['userID'] = userID;

      dynamic responseData =
          await DioClient().postFormData(entityOnboardUrl, map);

      if (responseData != null && responseData.runtimeType != String) {
        if (responseData['status'] == true) {
          Map<String, dynamic> successMessage = {
            'msg': details_saved_successfully,
            'error': false
          };
          return successMessage;
        } else {
          Map<String, dynamic> errorMessage = {
            'msg': enter_all_mandatory_field,
            'error': true
          };
          return errorMessage;
        }
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': enter_all_mandatory_field,
          'error': true
        };
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': plzUploadDocImgAndValidDocNo,
        'error': true
      };
      return errorMessage;
    }
  }

  storeResidenceProof(String? docType, {required List<String> filePath}) async {
    var data = Map<String, dynamic>();
    String url = entityOnboardUrl;

    if (docType != null && docType != "" && filePath.length != 0) {
      dynamic userID = authManager.userDetails?.value?.user?.sId ?? "";
      data['userID'] = userID;
      data['companyId'] =
          Get.put(CompanyListViewModel()).selectedCompany.value?.companyId ??
              "";
      data['residenceDocType'] = docType;

      List<dio.MultipartFile> listProofImg = [];
      for (var i in filePath) {
        dio.MultipartFile? file = await File(i).getMultipartDatafromFile();
        if (file != null) {
          listProofImg.add(file);
        }
      }
      // int counter = 0;
      // listProofImg.forEach((element) {
      //   data['ResidenceProof[$counter]'] = element;
      //   counter++;
      // });
      data['ResidenceProof'] = listProofImg;

      dynamic responseData = await DioClient().postFormData(url, data);

      if (responseData != null && responseData.runtimeType != String) {
        if (responseData['status']) {
          Map<String, dynamic> successMsg = {
            'msg': details_saved_successfully,
            'error': false
          };
          return successMsg;
        } else {
          Map<String, dynamic> errMsg = {
            'msg': unable_to_proceed,
            'error': true
          };
          return errMsg;
        }
      } else {
        Map<String, dynamic> errMsg = {'msg': unable_to_proceed, 'error': true};
        return errMsg;
      }
    } else {
      Map<String, dynamic> errMsg = {
        'msg': enter_all_mandatory_field,
        'error': true
      };
      return errMsg;
    }
  }

  storeBusinessProof(String? docNo, String? docType,
      {required String filePath}) async {
    // kycModel.businessProof = filePath;
    // kycModel.businessDocNumber = docNo;
    // kycModel.businessDocType = docType;

    final allowedDocCharacters = RegExp(r'^[a-zA-Z0-9_-]*$');
    if (docNo != null &&
        docNo != '' &&
        docType != null &&
        filePath.isNotEmpty &&
        allowedDocCharacters.hasMatch(docNo)) {
      var map = new Map<String, dynamic>();
      print('    1   ///////////');
      dynamic userID = authManager.userDetails?.value?.user?.sId ?? "";
      map['userID'] = userID;
      map['companyId'] =
          companyListViewModel.selectedCompany.value?.companyId ?? "";
      map['businessDocType'] = docType;
      map['businessDocNumber'] = docNo;

      map['BusinessProof'] = await File(filePath).getMultipartDatafromFile();

      print('     2  ///////////');

      dynamic responseData =
          await DioClient().postFormData(entityOnboardUrl, map);

      print('     err?//???  ///////////$responseData');

      if (responseData != null && responseData.runtimeType != String) {
        if (responseData['status'] == true) {
          print('     3  ///////////');
          Map<String, dynamic> successMessage = {
            'msg': details_saved_successfully,
            'error': false
          };
          print("errorMassage:---non");
          return successMessage;
        } else {
          Map<String, dynamic> errorMessage = {
            'msg': enter_all_mandatory_field,
            'error': true
          };
          print("errorMassage:---$errorMessage");
          return errorMessage;
        }
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': unable_to_proceed,
        };
        print("errorMassage:---$errorMessage");
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': plzUploadDocImgAndValidDocNo,
        'error': true
      };
      print("errorMassage:---$errorMessage");
      return errorMessage;
    }
  }

  storeVintageProof({required String filePath}) async {
    if (filePath == "") {
      Map<String, dynamic> errorMessage = {
        'msg': please_upload_image,
        'error': true
      };
      return errorMessage;
    }

    // Map<String, dynamic> data = kycModel.toJson();
    var map = new Map<String, dynamic>();

    map['companyId'] =
        companyListViewModel.selectedCompany.value?.companyId ?? "";
    //map['VintageProof'] = await MultipartFile.fromFile(filePath);
    dynamic userID = authManager.userDetails?.value?.user?.sId ?? "";
    map['VintageProof'] = await File(filePath).getMultipartDatafromFile();
    map['userID'] = userID;

    dynamic responseData =
        await DioClient().postFormData(entityOnboardUrl, map);

    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': details_saved_successfully,
          'error': false
        };
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': enter_all_mandatory_field,
          'error': true
        };
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': unable_to_proceed,
      };
      return errorMessage;
    }
  }

  storeFirmDetails({required String filePath}) async {
    if (filePath == "") {
      Map<String, dynamic> errorMessage = {
        'msg': please_upload_image,
        'error': true
      };
      return errorMessage;
    }

    // Map<String, dynamic> data = kycModel.toJson();
    var map = new Map<String, dynamic>();

    map['companyId'] =
        companyListViewModel.selectedCompany.value?.companyId ?? "";
    // map['companyId'] = compId;
    dynamic userID = authManager.userDetails?.value?.user?.sId ?? "";
    map['PartnershipDetails'] = await File(filePath).getMultipartDatafromFile();
    map['userID'] = userID;

    dynamic responseData =
        await DioClient().postFormData(entityOnboardUrl, map);

    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': details_saved_successfully,
          'error': false
        };
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': enter_all_mandatory_field,
          'error': true
        };
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': unable_to_proceed,
      };
      return errorMessage;
    }
  }

  storeBankDetails(
      {required List<String> bankStatementImage,
      required String password}) async {
    if (!(bankStatementImage.isNotEmpty || bankStatementImage.length <= 3)) {
      Map<String, dynamic> errorMessage = {
        'msg': plzGiveAtleastOnePdfAndNotMoreThanThree,
        'error': true
      };
      print("failed ");
      return errorMessage;
    }

    // Map<String, dynamic> data = kycModel.toJson();
    var map = new Map<String, dynamic>();

    List uploadPdf = [];
    dynamic userID = authManager.userDetails?.value?.user?.sId ?? "";
    map['companyId'] =
        companyListViewModel.selectedCompany.value?.companyId ?? "";
    map['userID'] = userID;
    for (var file in bankStatementImage) {
      var multipartFile = await File(file).getMultipartDatafromFile();
      uploadPdf.add(multipartFile);
    }

    map['BankStatementDetails'] = uploadPdf;

    map['bankStatementPassword'] = password;

    dynamic responseData =
        await DioClient().postFormData(entityOnboardUrl, map);

    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': details_saved_successfully,
          'error': false
        };
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': enter_all_mandatory_field,
          'error': true
        };
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': unable_to_proceed,
      };
      return errorMessage;
    }
  }

  chequeImages({required List<String> filePath}) async {
    if (!(filePath.isNotEmpty || filePath.length <= 3)) {
      Map<String, dynamic> errorMessage = {
        'msg': plzGiveAtleastOneImgAndNotMoreThanThree,
        'error': true
      };
      print("failed ");
      return errorMessage;
    }

    var map = new Map<String, dynamic>();
    List uploadImages = [];
    // map['_id'] = userID;
    dynamic userID = authManager.userDetails?.value?.user?.sId ?? "";
    map['companyId'] =
        companyListViewModel.selectedCompany.value?.companyId ?? "";
    map['userID'] = userID;
    // int indexCounter = 0;
    // for (; indexCounter < filePath.length;) {
    //   print(filePath);
    for (var file in filePath) {
      var multipartFile = await File(file).getMultipartDatafromFile();
      uploadImages.add(multipartFile);
    }
    print(uploadImages);
    // }

    map["ChequeImages"] = uploadImages;

    print(map);

    dynamic responseData =
        await DioClient().postFormData(entityOnboardUrl, map);

    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': details_saved_successfully,
          'error': false
        };
        print("success ");
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': enter_all_mandatory_field,
          'error': true
        };
        print("failed ");
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': unable_to_proceed,
        'error': true
      };
      print("failed ");
      return errorMessage;
    }
  }

  storeGstDetails(
      {
      //   required List<String> gstImage,
      // required List<String> financialDetailsImage,
      required List<String> filePath,
      required List<String> filePath1}) async {
    if (filePath.isEmpty || filePath1.isEmpty) {
      Map<String, dynamic> errorMessage = {
        'msg': atLeastOneImgNeeded,
        'error': true
      };
      print("failed ");
      return errorMessage;
    }

    var map = new Map<String, dynamic>();
    List uploadImages = [];
    List uploadImages1 = [];
    map['_id'] = userID;
    map['companyId'] =
        companyListViewModel.selectedCompany.value?.companyId ?? "";
    map['userID'] = authManager.userDetails?.value?.user?.sId ?? "";
    ;
    // int indexCounter = 0;
    // for (; indexCounter < filePath.length;) {
    //   print(filePath);
    for (var file in filePath) {
      var multipartFile = await File(file).getMultipartDatafromFile();
      uploadImages.add(multipartFile);
    }
    for (var file in filePath1) {
      var multipartFile = await File(file).getMultipartDatafromFile();
      uploadImages1.add(multipartFile);
    }
    print(uploadImages);
    // }

    map["FinancialDetails"] = uploadImages;
    map["GstDetails"] = uploadImages1;

    print(map);

    dynamic responseData =
        await DioClient().postFormData(entityOnboardUrl, map);

    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': details_saved_successfully,
          'error': false
        };
        print("success ");
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': enter_all_mandatory_field,
          'error': true
        };
        print("failed ");
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': unable_to_proceed,
      };
      print("failed ");
      return errorMessage;
    }
  }

  generateOTP(String mobile) async {
    if (int.tryParse(mobile) == null || mobile.length != 10) {
      Map<String, dynamic> errorMessage = {
        'msg': enter_valid_mobile_number,
      };
      print('OTP : $errorMessage');
      return errorMessage;
    }

    // KycModel kycModel = KycModel();
    // MobileVerificationModel mobileVerificationModel = MobileVerificationModel();
    // //Map<String, dynamic> data = kycModel.toJson();
    //  mobileVerificationModel.mobileNumber = mobile;

    dynamic responseData = await DioClient()
        .mobile_verfication(phoneRequestOTPUrl, {'mobile_number': mobile});

    print('Response Data : ------> $responseData');
    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        var rest = responseData["data"];
        this.otpReferenceId = rest['referenceId'];

        print('Referenece ID : ${otpReferenceId}');
        Map<String, dynamic> successMessage = {
          'msg': otp_sent_successfully,
        };
        print('OTP : $successMessage');
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': responseData["data"].toString(),
        };
        print('OTP : $errorMessage');
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': unable_to_proceed,
      };
      print('OTP : $errorMessage');
      return errorMessage;
    }
  }

  verifyOTP(String otp, String mobileNumber) async {
    String url = phoneVerifyOTPUrl;

    Map data = {
      'mobile_number': mobileNumber,
      'company_id': companyListViewModel.selectedCompany.value?.companyId ?? "",
      'otp': otp,
      'referenceId': this.otpReferenceId
    };

    dynamic responseData = await getIt<DioClient>().otp_verfication(url, data);
    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': otp_verified,
          'error': false
        };
        print('OTP : $successMessage');
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': something_went_wrong,
          'error': true
        };
        print('msg: $errorMessage');
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': unable_to_proceed,
        'error': true
      };
      print('msg: $errorMessage');
      return errorMessage;
    }
  }

  adhaarDetails(String? companyId, File frontFile, File backFile) async {
    String url = aadhaarVerifyUrl;
    String front = frontFile.path;
    String back = backFile.path;

    // KycModel kycModel = KycModel();
    //Map<String, dynamic> data = kycModel.toJson();

    var map = new Map<String, dynamic>();

    map['company_id'] =
        companyListViewModel.selectedCompany.value?.companyId ?? "";
    map['front'] = await File(front).getMultipartDatafromFile();
    // await MultipartFile.fromFile(front as String);
    map['back'] = await File(back).getMultipartDatafromFile();
    // await MultipartFile.fromFile(back as String);

    dynamic responseData =
        await getIt<DioClient>().aadhaar_captured_data(url, map);
    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        // Map<String, dynamic> successMessage = {
        //   'msg': 'Details saved successfully',
        // };
        return responseData;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': something_went_wrong,
        };
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': unable_to_proceed,
      };
      return errorMessage;
    }
    // throw Exception();
  }

  storeImages({required List<String> filePath}) async {
    if (!(filePath.isNotEmpty || filePath.length <= 3)) {
      Map<String, dynamic> errorMessage = {
        'msg': plzGiveAtleastOneImgAndNotMoreThanThree,
        'error': true
      };
      print("failed ");
      return errorMessage;
    }

    // Map<String, dynamic> data = kycModel.toJson();
    var map = new Map<String, dynamic>();
    List uploadImages = [];
    // map['_id'] = userID;
    dynamic userID = authManager.userDetails?.value?.user?.sId ?? "";
    map['companyId'] =
        companyListViewModel.selectedCompany.value?.companyId ?? "";
    map['userID'] = userID;
    // int indexCounter = 0;
    // for (; indexCounter < filePath.length;) {
    //   print(filePath);
    for (var file in filePath) {
      var multipartFile = await File(file).getMultipartDatafromFile();
      uploadImages.add(multipartFile);
    }
    print(uploadImages);
    // }

    map["StoreImages"] = uploadImages;

    print(map);

    dynamic responseData =
        await DioClient().postFormData(entityOnboardUrl, map);

    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': details_saved_successfully,
          'error': false
        };
        print("success ");
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': enter_all_mandatory_field,
          'error': true
        };
        print("failed ");
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': unable_to_proceed,
      };
      print("failed ");
      return errorMessage;
    }
  }

  Future<CaptchaDataModel?> getCaptcha() async {
    dynamic responseData = await getIt<DioClient>().getCaptcha(
      eKycGetCaptchaUrl,
    );

    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        captchaDataModel.value = CaptchaDataModel.fromJson(responseData);
        return captchaDataModel.value;
      } else {
        return null;
      }
    } else {
      Fluttertoast.showToast(msg: unable_to_proceed);
      return null;
    }
  }

  verifyAdharOtp(String? otp, {required String captchaSessionId}) async {
    print("OTP----$otp");

    if (otp != null) {
      // var map = new Map<String, dynamic>();

      Map data = {'otp': otp, 'sessionId': captchaSessionId};

      dynamic responseData =
          await getIt<DioClient>().aadhaar_otp_verify(eKycVerifyOTPUrl, data);
      print("a otp $responseData");
      if (responseData != null && responseData.runtimeType != String) {
        if (responseData['status'] == true) {
          Map<String, dynamic> successMessage = {
            'msg': otp_verified,
            'error': false
          };
          return successMessage;
        } else {
          Map<String, dynamic> errorMessage = {
            'msg': enter_all_mandatory_field,
            'error': true
          };
          print("otp $errorMessage");
          return errorMessage;
        }
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': unable_to_proceed,
        };
        print("otp $errorMessage");
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': plzCaptureAdharImgAndEnterValidAdharNum,
        'error': true
      };
      return errorMessage;
    }
  }

  // getKycSubmission() async {
  //   if (kycModel.businessProof != null &&
  //       kycModel.businessDocType != null &&
  //       kycModel.businessDocNumber != null &&
  //       kycModel.userID != null &&
  //       kycModel.companyId != null) {
  //
  //
  //     Map<String, dynamic> data = kycModel.toJson();
  //     print('Data : ${data}');
  //
  //     Map<String, dynamic> map = {
  //       'businessDocType': data['businessDocType'],
  //       'businessDocNumber': data['businessDocNumber'],
  //       'BusinessProof': await dio.MultipartFile.fromFile(data['businessProof'],
  //           filename: 'BusinessProof.png'),
  //       'userID': data['userID'],
  //       'companyId': data['companyId']
  //     };
  //     dynamic responseData = await DioClient.postFormData(entityOnboardUrl, map);
  //     print('Form Data-->>>>---->${map}----->>>>>---->');
  //     print('-->>>>---->${responseData}----->>>>>---->');
  //     if (responseData['status'] == true) {
  //       Map<String, dynamic> successMessage = {
  //         'msg': 'Details saved successfully',
  //       };
  //       return successMessage;
  //     }
  //   } else {
  //     Map<String, dynamic> errorMessage = {
  //       'msg': 'Enter all mandatory fields',
  //     };
  //     return errorMessage;
  //   }
  // }

  Future<File?> getImage({required BuildContext context}) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      return File(image.path);
    }

    return null;
  }

  Future<bool> requestPermission() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    late final Map<Permission, PermissionStatus> statusess;

    if (androidInfo.version.sdkInt <= 32) {
      statusess = await [
        Permission.storage,
      ].request();
    } else {
      statusess = await [Permission.photos].request();
    }

    var allAccepted = true;
    statusess.forEach((permission, status) {
      if (status != PermissionStatus.granted) {
        allAccepted = false;
      }
    });

    return allAccepted;
  }

  Future<List<File>?> selectFile(
      bool? flag, List<String>? allowedExtension) async {
    final result = await requestPermission()
        ? await FilePicker.platform.pickFiles(
            allowMultiple: true,
            allowedExtensions: allowedExtension,
            type: allowedExtension != null ? FileType.custom : FileType.image)
        : null;
    // final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    print("filepath:----$result");
    if (result == null) {
      // Map<String, dynamic> errorMessage = {
      //   'msg': 'File selection failed',
      //   'status': false
      // };
      // return errorMessage;
      return null;
    } else {
      // final path = result.files.single.
      //
      return result.paths
          .where((element) => (element?.length ?? 0) != 0)
          .map((e) => File(e!))
          .toList();
    }
  }

  Future<List<File?>?> selectPdfFile(bool? flag) async {
    final result =
        await FilePicker.platform.pickFiles(allowMultiple: flag ?? false);
    print("filepath:----$result");
    if (result == null) {
      // Map<String, dynamic> errorMessage = {
      //   'msg': 'File selection failed',
      //   'status': false
      // };
      // return errorMessage;
      return null;
    } else {
      // final path = result.files.single.
      //
      return result.paths
          .where((element) => (element?.length ?? 0) != 0)
          .map((e) => File(e!))
          .toList();
    }
  }

  Future uploadFile({required File? file}) async {
    if (file == null) {
      Map<String, dynamic> errorMessage = {
        'msg': file_upload_failed,
        'status': false
      };
      return errorMessage;
    } else {
      //final fileName = basename(file.path);
      //final destination = 'files/$fileName';
    }
  }

  ///Get KYC Details
  Future<KYCStatusModel?> getKycStatusDetails() async {
    String endUrl = kycStatusUrl(
        companyid: companyListViewModel.selectedCompany.value?.companyId ?? "");
    kycStatusModel?.value = null;
    try {
      Map<String, dynamic>? kycStatusDetailResponse =
          await DioClient().get(endUrl);
      if (kycStatusDetailResponse != null) {
        kycStatusModel?.value =
            KYCStatusModel.fromJson(kycStatusDetailResponse);
        return kycStatusModel?.value;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  bool isKycStatusVerified() {
    if (kycStatusModel?.value?.data == null) {
      return false;
    } else if (kycStatusModel?.value?.data?.pan?.status == 'Approved' &&
        kycStatusModel?.value?.data?.aadhar?.status == 'Approved' &&
        kycStatusModel?.value?.data?.mobile?.status == 'Approved' &&
        kycStatusModel?.value?.data?.bankStatement?.status == 'Approved' &&
        kycStatusModel?.value?.data?.business?.status == 'Approved' &&
        kycStatusModel?.value?.data?.financial?.status == 'Approved' &&
        kycStatusModel?.value?.data?.gst?.status == 'Approved' &&
        kycStatusModel?.value?.data?.ownership?.status == 'Approved' &&
        kycStatusModel?.value?.data?.partnership?.status == 'Approved' &&
        kycStatusModel?.value?.data?.vintage?.status == 'Approved' &&
        kycStatusModel?.value?.data?.storeImages?.status == 'Approved' &&
        kycStatusModel?.value?.data?.residence?.status == 'Approved' &&
        kycStatusModel?.value?.data?.chequeImages?.status == "Approved") {
      return true;
    } else {
      return false;
    }
  }
}
