import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/payment_history_model.dart';
import 'package:xuriti/models/services/dio_service.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';

import '../../util/common/endPoints_constant.dart';

class TransHistoryManager extends ChangeNotifier {
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  TransactionManager transactionManager = Get.put(TransactionManager());
  Rx<PaymentHistoryModel?> paymentHistory =
      RxNullable<PaymentHistoryModel?>().setNull();

  RxBool fetchingPaymentHistory = false.obs;

  RxBool hasMoreItemsToScroll = false.obs;

  int lowerLimit = 1;
  int upperLimit = 5;

  Future<PaymentHistoryModel?> getPaymentHistory(buyerId) async {
    String? sellerId = transactionManager.selectedSeller.value?.Anchor_id;
    String url = transactionPaymentHistoryUrl(
        buyerId: buyerId,
        upperLimit: upperLimit,
        lowerLimit: lowerLimit,
        sellerId: sellerId);

    lowerLimit = lowerLimit + 5;
    upperLimit = lowerLimit + 4;
    fetchingPaymentHistory.value = true;

    dynamic responseData = await DioClient().get(
      url,
    );
    fetchingPaymentHistory.value = false;
    if (responseData != null && responseData['status'] == true) {
      paymentHistory.value = PaymentHistoryModel.fromJson(responseData);
      return paymentHistory.value;
    } else if (responseData == null) {
      return null;
    }
    return responseData;
  }

  disposeInvoices() {
    lowerLimit = 1;
    upperLimit = 5;
  }

  Future<PaymentHistoryModel?> getPaymentHistoryDetails() async {
    String url = transactionPaymentHistoryUrl(
        buyerId: companyListViewModel.selectedCompany.value?.companyId ?? "");

    dynamic responseData = await DioClient().get(url);

    if (responseData != null && responseData['status'] == true) {
      PaymentHistoryModel paymentHistory =
          PaymentHistoryModel.fromJson(responseData);
      return paymentHistory;
    } else {
      return null;
    }
  }
}
