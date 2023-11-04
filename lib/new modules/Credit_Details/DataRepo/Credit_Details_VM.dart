import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/models/services/dio_service.dart';
import '../../../util/common/endPoints_constant.dart';
import '../model/Credit_Details.dart';

class RxNullable<T> {
  Rx<T> setNull() {
    return (null as T).obs;
  }
}

String getNewLineString(List remarks) {
  StringBuffer sb = new StringBuffer();
  for (String line in remarks) {
    sb.write(line + "\n");
  }
  return sb.toString();
}

class Credit_Details_VM extends GetxController {
  Rx<Credit_Details_View_Model?>? creditDetails =
      RxNullable<Credit_Details_View_Model?>().setNull();
  RxBool gettingCreditDetails = false.obs;
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());

  Future<void> getCreditDetails() async {
    gettingCreditDetails.value = true;
    Map<String, dynamic>? responseData = await DioClient().get(
        getCreditandAvailableLimit(
            companyId:
                companyListViewModel.selectedCompany.value?.companyId ?? ""));

    if (responseData != null) {
      if (responseData["status"] == true) {
        creditDetails?.value = Credit_Details_View_Model.fromJson(responseData);
      } else {
        creditDetails?.value = null;
      }
      gettingCreditDetails.value = false;
    } else {
      creditDetails?.value = null;
      gettingCreditDetails.value = false;
    }
  }
}
