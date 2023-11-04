import 'package:get/get.dart';
import 'package:xuriti/companyList/model/companyListModel.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/util/common/endPoints_constant.dart';

import '../../models/services/dio_service.dart';

class CompanyListViewModel extends GetxController {
  Rx<CompanyListModel?>? companyList =
      RxNullable<CompanyListModel?>().setNull();
  Rx<CompanyInformation?> companyDetails =
      RxNullable<CompanyInformation?>().setNull();

  Rx<CompanyInformation?> selectedCompany =
      RxNullable<CompanyInformation?>().setNull();

  RxBool companyListLoading = false.obs;

  Future<CompanyListModel?> getCompanyList(
    String? id,
    Function(bool value) isSessionExpired,
  ) async {
    companyListLoading.value = true;
    Map<String, dynamic>? responseData =
        await DioClient().get(getComapnyListUrl(id: id));

    companyList?.value = null;
    companyListLoading.value = false;

    if (responseData != null && responseData['statusCode'] == 440) {
      isSessionExpired(true);
      return null;
    } else if (responseData != null) {
      companyList?.value = CompanyListModel.fromJson(responseData);
      isSessionExpired(false);
    }

    return companyList?.value;
  }

  Future<CompanyInformation?> getCompanyDetails() async {
    String url =
        getCompanyDetailsUrl(companyId: selectedCompany.value?.companyId ?? "");

    dynamic responseData = await DioClient().get(
      url,
    );

    if (responseData != null) {
      if (responseData['status'] == true && responseData['company'] != null) {
        //  String credit = responseData['company']['creditLimit'].toString();
        companyDetails.value =
            CompanyInformation.fromJson(responseData["company"]);
      }
      return companyDetails.value;
    }
    return null;
  }
}
