import 'dart:io';
import 'package:dio/dio.dart';
import '../models/helper/service_locator.dart';
import '../models/services/dio_service.dart';
import '../util/common/endPoints_constant.dart';
import '../util/common/string_constants.dart';

class KycController {
  adhaarDetails(String? companyId, File front, File back) async {
    String url = aadhaarVerifyUrl;

    var map = new Map<String, dynamic>();

    map['companyId'] = companyId;
    map['front'] = await MultipartFile.fromFile(front as String);
    map['back'] = await MultipartFile.fromFile(back as String);

    // FormData formData = MapToFormData().mapToFormData(map);

    dynamic responseData =
        await getIt<DioClient>().aadhaar_captured_data(url, map);

    if (responseData['status'] == true) {
      Map<String, dynamic> successMessage = {
        'msg': details_saved_successfully,
      };
      return successMessage;
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': something_went_wrong,
      };
      return errorMessage;
    }
  }
}
