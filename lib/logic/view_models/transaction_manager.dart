import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/models/core/invoice_model.dart';
import 'package:xuriti/models/core/seller_list_model.dart';
import 'package:xuriti/models/core/seller_list_model.dart' as Sel;
import 'package:xuriti/models/services/dio_service.dart';
import 'package:open_file_safe_plus/open_file_safe_plus.dart';
import 'package:xuriti/new%20modules/Credit_Details/model/Credit_Details.dart';
import 'package:xuriti/util/common/string_constants.dart';
import '../../models/core/transactional_model.dart';
import '../../models/helper/service_locator.dart';
import '../../new modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import '../../util/common/endPoints_constant.dart';

class TransactionManager extends GetxController {
  RxInt invoiceScreenIndex = 0.obs; // This will be for index selection
  RxInt landingScreenIndex = 0.obs;

  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());

  ///This is for Seller List and selected seller from drop menu
  Rx<List<Sel.Seller?>?>? sellerList =
      RxNullable<List<Sel.Seller?>?>().setNull();
  Rx<CreditDetails?> selectedSeller = RxNullable<CreditDetails?>().setNull();

  ///Invoice Details Object
  Rx<Invoice?> invoiceDetails = RxNullable<Invoice?>().setNull();

  Rx<bool> hasMoreItemsToScroll = false.obs;

  Rx<Invoices?>? invoices = RxNullable<Invoices?>().setNull();
  RxBool fetchingInvoices = false.obs;

  TransactionInvoice? selectedInvoice;
  Invoice? currentPaidInvoice;
  bool? isPending;
  String errorMessage = "";

  int paymentCounter = 0;
  double payableAmount = 0;

  double allEntitiesPayAmt = 0;

  // getallEntitiesPayAmt() async {
  //   allEntitiesPayAmt = 0;
  //   for (int i = 0; i < companyList.length; i++) {
  //     // c.companyDetails?.sId;
  //     dynamic a =
  //         await getTotalOutstandingAmount(companyList[i].companyDetails?.sId);
  //     // ignore: unnecessary_cast
  //     allEntitiesPayAmt = allEntitiesPayAmt + a as double;
  //   }
  //   print(allEntitiesPayAmt);
  //
  //   return allEntitiesPayAmt == 0 ? true : false;
  // }

  getTransactionLedger(String? id) async {
    try {
      String url = transactionLedger(
          companyId:
              id); //"/ledger/companies/transaction_ledger?buyer=$companyId";
      dynamic responseData = await DioClient().get(url);
      print("responseData =========> $responseData");

      if (responseData != null && responseData['status'] == true) {
        TransactionModel transactionModel =
            TransactionModel.fromJson(responseData);

        return transactionModel;
      } else if (responseData == null) {
        return TransactionModel();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Invoice?> getInvoiceDetails({String? invoiceId}) async {
    try {
      String url = InvoicesListAndDetailsEndpoint(invoiceId: invoiceId);

      dynamic responseData = await DioClient().get(url);

      if (responseData != null && responseData['status'] == true) {
        invoiceDetails.value = Invoices.fromJson(responseData).invoice?.first;

        return invoiceDetails.value;
      } else {
        Fluttertoast.showToast(msg: responseData["message"].toString());
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<TransactionModel?> getTransactionStatement(String? id) async {
    TransactionModel? transactionModel;

    try {
      String url = transactionalStatementUrl(companyId: id);

      dynamic responseData = await DioClient().get(url);
      print("responseData =========> $responseData");

      if (responseData['status'] == true) {
        return responseData;
      }
    } catch (e) {
      print(e);
    }
    return transactionModel;
  }

  // getTotalOutstandingAmount(companyId) async {
  //   if (companyId != null) {
  //     // String url = "/invoice/paymentsummary/?buyer=$companyId";
  //     String url = paymentTotalPayableUrl(companyId: companyId);
  //
  //     dynamic responseData = await DioClient().get(
  //       url,
  //     );
  //     if (responseData == null || responseData['status'] == false) {
  //       for (var i in confirmedInvoices) {
  //         String outStandingAmt = "0";
  //         if (i.invoiceType == "IN") {
  //           if (i.outstandingAmount != null) {
  //             outStandingAmt = i.outstandingAmount!;
  //             dynamic interest = i.interest;
  //             dynamic discound = i.discount;
  //             // totalAmt = totalAmt +
  //             //     (double.parse(outStandingAmt) + interest - discound);
  //           }
  //         } else {
  //           return double.parse(outStandingAmt.toString()).toStringAsFixed(2);
  //         }
  //       }
  //       return totalAmt;
  //     }
  //     if (responseData != null && responseData['status'] == true) {
  //       dynamic outstandingAmountObj =
  //           TotalOutstandingAmount.fromJson(responseData);
  //       if (outstandingAmountObj != null) {
  //         if (outstandingAmountObj!.outstaningAmount != null) {
  //           return outstandingAmountObj!.outstaningAmount;
  //         }
  //       }
  //     }
  //   }
  //   return 0;
  // }

  // getFilteredInvoices(
  //   String? sId,
  // ) async {
  //   // this method used for filtration of invoices when pagination flag is off
  //   // sellerData = sName;
  //   // String? sId = "";
  //   if (sId == "clear") {
  //   } else {
  //     String url = InvoicesListAndDetailsEndpoint(
  //         sellerPan: sId); //"/invoice/search-invoice/$bId/buyer?seller=$sId";
  //
  //     dynamic responseData = await DioClient().get(
  //       url,
  //     );
  //
  //     if (responseData != null && responseData['status'] == true) {
  //       invoices?.value = Invoices.fromJson(responseData);
  //
  //       // for (var i in (invoices?.value)) {
  //       //   if (i.invoiceStatus == "Paid") {
  //       //     // paidInvoices.add(i);
  //       //   }
  //       //   if (i.invoiceType == "IN" && i.invoiceStatus == "Pending") {
  //       //     // pendingInvoice.add(i);
  //       //   }
  //       //   if (i.invoiceType == "CN") {
  //       //     // cnInvoice.add(i);
  //       //   }
  //       //   if (i.invoiceStatus == "Confirmed" ||
  //       //       i.invoiceStatus == "Partpay" && i.invoiceType == "IN") {
  //       //     if (i.invoiceType == "IN") {
  //       //       // confirmedInInvoices.add(i);
  //       //     } else {
  //       //       // confirmedCNInvoices.add(i);
  //       //     }
  //       //   }
  //       // }
  //     }
  //     // return invoices;
  //
  //     return;
  //   }
  // }

  // Future<Invoices?>? getInvoices(String? id, bool? shouldReset) async {
  //   invoices?.value = null;
  //
  //   if (id != null) {
  //     String url =
  //         InvoicesListAndDetailsEndpoint(); // "/invoice/search-invoice/$id/buyer";
  //     print(url);
  //
  //     dynamic responseData = await DioClient().get(url);
  //
  //     if (responseData != null && responseData['status'] == true) {
  //       invoices?.value = Invoices.fromJson(responseData);
  //
  //       return invoices?.value;
  //     }
  //   }
  //   return Invoices();
  // }

  // getOutStandingAmt() {
  //
  //   if (!paginationFlag) {
  //     for (var i in confirmedInInvoices) {
  //       String outStandingAmt = "0";
  //       if (i.invoiceType == "IN") {
  //         if (i.outstandingAmount != null) {
  //           outStandingAmt = i.outstandingAmount!;
  //           dynamic interest = i.interest;
  //           dynamic discound = i.discount;
  //           totalAmt =
  //               totalAmt + (double.parse(outStandingAmt) + interest - discound);
  //           // totalAmt = totalAmt + double.parse(outStandingAmt);
  //
  //         }
  //       } else {
  //         return double.parse(outStandingAmt.toString()).toStringAsFixed(2);
  //       }
  //     }
  //   } else {
  //     for (var i in confirmedInvoices) {
  //       String outStandingAmt = "0";
  //       if (i.invoiceType == "IN") {
  //         if (i.outstandingAmount != null) {
  //           outStandingAmt = i.outstandingAmount!;
  //           dynamic interest = i.interest;
  //           dynamic discound = i.discount;
  //           totalAmt =
  //               totalAmt + (double.parse(outStandingAmt) + interest - discound);
  //           // totalAmt = totalAmt + double.parse(outStandingAmt);
  //
  //         }
  //       } else {
  //         return double.parse(outStandingAmt.toString()).toStringAsFixed(2);
  //       }
  //     }
  //   }
  // }

  // getInetialInvoices(
  //     {String? id,
  //     bool resetConfirmedInvoices = false,
  //     String? invoiceType}) async {
  //
  //   if (getIt<SharedPreferences>().getBool("filtrationFlag") == true &&
  //       getIt<SharedPreferences>().getBool("filtrationFlag") != null) {
  //     await getFilteredInvoices(
  //         getIt<TransactionManager>().selectedSeller.value?.Anchor_id ?? "");
  //     // notifyListeners();
  //     return Invoices(status: false);
  //   } else {
  //     if ((getIt<SharedPreferences>().getBool("filtrationFlag") == false ||
  //         getIt<SharedPreferences>().getBool("filtrationFlag") == null)) {
  //       return getInvoices(id);
  //     }
  //
  //     //when the company is changed, we need to reset the invoices
  //     // getIt<CompanyDetailsManager>().getSellerList(companyId);
  //     if (companyId == null) {
  //       print('//////////////error- companyId null in getInetialInvoices');
  //       return Invoices(status: false);
  //     }
  //
  //     if (confirmedInvoices.length == 0 ||
  //         resetConfirmedInvoices ||
  //         currentCompanyId != companyId) {
  //       //reset all invoices arrays to empty array
  //       currentCompanyId = companyId;
  //
  //       totalAmt = 0;
  //       //fetch only the first 5 invoices for all pages
  //
  //       await getCreditLimit();
  //       await getIt<RewardManager>().getRewards();
  //       await addInvoices(id: id, status: 'Pending', type: 'IN');
  //       await addInvoices(id: id, status: 'Paid', type: 'IN');
  //       await addInvoices(id: id, type: 'CN');
  //
  //       String url;
  //       sId == null
  //           ? url = //searchInvoiceUrl(buyerId: id)
  //               "/invoice/search-invoice/$id/buyer?multi_invoice_status_A=Confirmed&multi_invoice_status_B=Partpay&invoice_type=IN&limit=5&page=1"
  //           : url = // searchInvoiceUrl(
  //               //  buyerId: id, sellerId: confirm_filter, invoiceType: 'IN');
  //               "/invoice/search-invoice/$id/buyer?seller=$sId&multi_invoice_status_A=Confirmed&multi_invoice_status_B=Partpay&invoice_type=IN&limit=5&page=1";
  //
  //       dynamic responseData = await DioClient().get(
  //         url,
  //       );
  //       if (responseData == null) {
  //         print('////////////////////response null');
  //         return Invoices(status: false);
  //       }
  //       invoices?.value = Invoices.fromJson(responseData);
  //
  //       // totalAmt = await getTotalOutstandingAmount(companyId);
  //
  //       return Invoices(invoice: confirmedInvoices, status: true);
  //     }
  //     return Invoices(status: false);
  //   }
  // }

  Future<Invoices?> fetchInvoicesList(
      {String? statusA,
      String? statusB,
      String? invoiceStatus,
      String? type = 'IN',
      bool? resetFlag}) async {
    String? sellerPAN = selectedSeller.value?.anchor_pan;

    fetchingInvoices.value = true;
    if (resetFlag == true) {
      invoices?.value = null;
    }

    int limit = 50;

    if ((invoices?.value != null) &&
        (invoices?.value?.invoice?.length ?? 0) < limit) {
      return invoices?.value;
    }

    String url = InvoicesListAndDetailsEndpoint(
      sellerPan: sellerPAN,
      invoiceType: type,
      limit: limit.toString(),
      invoiceStatus: invoiceStatus,
      page: (invoices?.value?.invoice?.length ?? 0) == 0
          ? "1"
          : (((invoices?.value?.invoice?.length ?? 0) / 50) + 1).toString(),
      multiInvStatusA: statusA,
      multiInvStatusB: statusB,
    );
    dynamic responseData = await DioClient().get(url);

    try {
      if (responseData == null || responseData['status'] != true) {
        fetchingInvoices.value = false;
        invoices?.value = null;
        // if (landingScreenIndex == 0) {
        //   await getIt<SharedPreferences>().setString(
        //       SharedPrefKeyValue.recentSelectedCompany,
        //       companyListViewModel.selectedCompany.value?.companyId ?? "");
        // }
        return null;
      } else {
        fetchingInvoices.value = false;
        invoices?.value = Invoices.fromJson(responseData);

        return invoices?.value;
      }
    } catch (e) {
      debugPrint(e.toString());
      // if (landingScreenIndex == 0) {
      //   await getIt<SharedPreferences>().setString(
      //       SharedPrefKeyValue.recentSelectedCompany,
      //       companyListViewModel.selectedCompany.value?.companyId ?? "");
      // }
      fetchingInvoices.value = false;
      invoices?.value = null;
    }
    return null;
  }

  Future<List<Sel.Seller?>?> getSellerData(
    companyId,
  ) async {
    // sellerList = SellerList();
    if (companyId != null) {
      String url = getSellerListUrl(companyId: companyId);

      dynamic responseData = await DioClient().get(url);

      if (responseData != null && responseData['status'] == true) {
        if (responseData['seller'] != null) {
          sellerList?.value =
              SellerListModel.fromJson(responseData).seller ?? [];
        } else {}

        return sellerList?.value ?? [];
      }
    }
    return null;
  }

  transStateInvoice(invoice) {
    selectedInvoice = invoice;
  }

  changePaidInvoice(invoice) {
    currentPaidInvoice = invoice;
  }

  setWidgetType(widgetType) {
    isPending = widgetType;
  }

  changeInvoiceStatus(String? id, String status, Invoice? inv, String timeStamp,
      bool userConsent, String userComment, String userConsentMessage) async {
    String url = invoiceStatus;
    print(id);
    Map<String, dynamic> data = {
      "invoiceID": id,
      "status": status,
      "user_comment": userComment,
      "user_consent_message": userConsentMessage,
      "reason": "xyz",
      "userConsentGiven": userConsent,
      "consentimeStamp": timeStamp,
    };

    dynamic responseData = await getIt<DioClient>().patch(
      url,
      data,
    );
    print("responseData confirm ----$responseData");
    if (responseData != null && responseData['status'] == true) {
      String message = responseData["message"];

      if (responseData["message"] == "Invoice confirmed") {
        // confirmedInvoices.add(inv);

        // pendingInvoice.removeAt(index);

        return message;
      } else if (responseData["message"] == "Invoice rejected") {
        // pendingInvoice.removeAt(index);

        return message;
      }
      return message;
    } else {
      return unexpectedErrorOccuredMes;
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {}
  }

  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      final response = await Dio().get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }

  Future<void> openFile({required String url, String? fileName}) async {
    final name = fileName ?? url.split('/').last;
    final file = await downloadFile(url, name);
    if (file == null) return;

    print('Path:${file.path}');

    OpenFilePlus.open(file.path);
  }
}
