import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/models/services/dio_service.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/ui/screens/reports_screens/transactional_statement_screen/model/transactionStatementModel.dart';
import 'package:xuriti/util/common/string_constants.dart';

class TransactionStatementVM extends GetxController {
  Rx<TransactionStatementModel?> transactionStatementData =
      RxNullable<TransactionStatementModel?>().setNull();

  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());

  Future<TransactionStatementModel?> transactionLedger() async {
    String endUrl =
        "/ledger/companies/transaction_ledger?buyer=${companyListViewModel.selectedCompany.value?.companyId ?? ""}${(getIt<TransactionManager>().selectedSeller.value != null && getIt<TransactionManager>().selectedSeller.value?.anchorName?.toLowerCase() != all_sellers.tr) ? "&pan=${getIt<TransactionManager>().selectedSeller.value?.anchor_pan ?? ""}" : ""}";

    Map<String, dynamic>? response = await DioClient().get(endUrl);
    if (response != null) {
      transactionStatementData.value =
          TransactionStatementModel.fromJson(response);
    } else {
      transactionStatementData.value = null;
    }
    return transactionStatementData.value;
  }
}
