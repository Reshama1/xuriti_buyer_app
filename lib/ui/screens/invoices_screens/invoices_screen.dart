import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipe/swipe.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/logic/view_models/trans_history_manager.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/new%20modules/Credit_Details/model/Credit_Details.dart';
import 'package:xuriti/ui/screens/bhome_screens/header_widget_for_cred_limit_seller_selection.dart';
import 'package:xuriti/ui/screens/invoices_screens/cn_invoices/all_cn_invoice.dart';
import 'package:xuriti/ui/screens/invoices_screens/payment_history/payments_history_screen.dart';
import 'package:xuriti/ui/screens/invoices_screens/pending_invoices_screen/pending_invoices_screen.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';
import 'all_sellers_screens/all_sellers_screen.dart';
import 'pending_invoices_screen/paid_invoices_screen.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  TransactionManager transactionManager = Get.put(TransactionManager());
  TransHistoryManager transHistoryManager = Get.put(TransHistoryManager());
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());

  ScrollController controllerForScroll = new ScrollController();
  List<Widget> invoicesStatusScreens = [];

  @override
  void initState() {
    invoicesStatusScreens = [
      PInvoices(),
      PaidInvoices(),
      CNInvoices(),
      PaymentHistory(),
      AllSellers(),
    ];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      transactionManager.fetchInvoicesList(
        invoiceStatus: 'Pending',
        resetFlag: true,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxHeight = constraints.maxHeight;
        double maxWidth = constraints.maxWidth;
        double h1p = maxHeight * 0.01;
        double h10p = maxHeight * 0.1;
        double w10p = maxWidth * 0.1;
        return OrientationBuilder(
          builder: (context, orientation) {
            bool isPortrait = orientation == Orientation.portrait;
            return Scaffold(
              backgroundColor: Colours.black,
              body: Obx(
                () {
                  (transactionManager.selectedSeller.value);
                  return Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 10.0,
                              top: 10.0,
                              bottom: 10.0,
                              right: 10.0,
                            ),
                            child: HeaderWidgetForCreditLimitAndSellerSelection(
                              selectedSeller:
                                  (CreditDetails? sellerObject) async {
                                transactionManager.selectedSeller.value =
                                    sellerObject;
                              },
                              showSellerFilter: true,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: h1p * 3,
                              left: isPortrait ? w10p * .5 : w10p * 0.13,
                            ),
                            child: Container(
                              height: isPortrait ? h1p * 10.005 : h1p * 25.2,
                              width: maxWidth,
                              child: ListView(
                                controller: controllerForScroll,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      transactionManager
                                          .invoiceScreenIndex.value = 0;

                                      transactionManager.fetchInvoicesList(
                                        invoiceStatus: "Pending",
                                        resetFlag: true,
                                      );
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: w10p * .4),
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: h10p * .2,
                                              bottom: h10p * .17,
                                              right: w10p * 0.65,
                                              left: w10p * .6),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: transactionManager
                                                          .invoiceScreenIndex
                                                          .value ==
                                                      0
                                                  ? Colours.tangerine
                                                  : Colours.almostBlack),
                                          child: Row(children: [
                                            ImageFromAssetPath<Widget>(
                                                    assetPath:
                                                        ImageAssetpathConstant
                                                            .icon)
                                                .imageWidget,
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: w10p * 0.32,
                                                  top: w10p * 0.13),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  ConstantText(
                                                    text: pending_invoices_,
                                                    style:
                                                        TextStyles.textStyle47,
                                                  ),
                                                  // ConstantText(
                                                  //   text: "Invoices",
                                                  //   style:
                                                  //       TextStyles.textStyle47,
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ])),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      // progress!.show();
                                      transactionManager.fetchInvoicesList(
                                        invoiceStatus: 'Paid',
                                        resetFlag: true,
                                      );

                                      transactionManager
                                          .invoiceScreenIndex.value = 1;
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: w10p * .4),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: h10p * .2,
                                            bottom: h10p * .17,
                                            right: w10p * 0.65,
                                            left: w10p * .6),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: transactionManager
                                                        .invoiceScreenIndex
                                                        .value ==
                                                    1
                                                ? Colours.tangerine
                                                : Colours.almostBlack),
                                        child: Row(
                                          children: [
                                            ImageFromAssetPath<Widget>(
                                                    assetPath:
                                                        ImageAssetpathConstant
                                                            .icon2)
                                                .imageWidget,
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: w10p * 0.32,
                                                  top: w10p * 0.13),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  ConstantText(
                                                    text: paidInvoice_,
                                                    style:
                                                        TextStyles.textStyle47,
                                                  ),
                                                  // ConstantText(
                                                  //   text: "Invoices",
                                                  //   style:
                                                  //       TextStyles.textStyle47,
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      transactionManager.fetchInvoicesList(
                                        type: "CN",
                                        resetFlag: true,
                                      );

                                      transactionManager
                                          .invoiceScreenIndex.value = 2;
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: w10p * .4),
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: h10p * .2,
                                              bottom: h10p * .17,
                                              right: w10p * 0.65,
                                              left: w10p * .6),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: transactionManager
                                                          .invoiceScreenIndex
                                                          .value ==
                                                      2
                                                  ? Colours.tangerine
                                                  : Colours.almostBlack),
                                          child: Row(children: [
                                            ImageFromAssetPath<Widget>(
                                                    assetPath:
                                                        //  "assets/images/icon3.svg"
                                                        ImageAssetpathConstant
                                                            .icon)
                                                .imageWidget,
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: w10p * 0.32,
                                                  top: w10p * 0.13),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  ConstantText(
                                                    text: creditNote_,
                                                    style:
                                                        TextStyles.textStyle47,
                                                  ),
                                                  // ConstantText(
                                                  //   text: "Note",
                                                  //   style:
                                                  //       TextStyles.textStyle47,
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ])),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      transHistoryManager.getPaymentHistory(
                                          companyListViewModel.selectedCompany
                                                  .value?.companyId ??
                                              "");
                                      transactionManager
                                          .invoiceScreenIndex.value = 3;
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: w10p * .4),
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: h10p * .2,
                                              bottom: h10p * .17,
                                              right: w10p * 0.65,
                                              left: w10p * .6),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: transactionManager
                                                          .invoiceScreenIndex
                                                          .value ==
                                                      3
                                                  ? Colours.tangerine
                                                  : Colours.almostBlack),
                                          child: Row(children: [
                                            ImageFromAssetPath<Widget>(
                                                    assetPath:
                                                        ImageAssetpathConstant
                                                            .icon2)
                                                .imageWidget,
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: w10p * 0.32,
                                                  top: w10p * 0.13),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  ConstantText(
                                                    text: paymentHistory_,
                                                    style:
                                                        TextStyles.textStyle47,
                                                  ),
                                                  // ConstantText(
                                                  //   text: "History",
                                                  //   style:
                                                  //       TextStyles.textStyle47,
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ])),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      transactionManager
                                          .invoiceScreenIndex.value = 4;
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: w10p * .4),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: h10p * .2,
                                            bottom: h10p * .17,
                                            right: w10p * 0.65,
                                            left: w10p * .6),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: transactionManager
                                                        .invoiceScreenIndex
                                                        .value ==
                                                    4
                                                ? Colours.tangerine
                                                : Colours.almostBlack),
                                        child: Row(
                                          children: [
                                            ImageFromAssetPath<Widget>(
                                                    assetPath:
                                                        ImageAssetpathConstant
                                                            .icon3)
                                                .imageWidget,
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: w10p * 0.32,
                                                  top: w10p * 0.13),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  ConstantText(
                                                    text: all_sellers,
                                                    style:
                                                        TextStyles.textStyle47,
                                                  ),
                                                  // ConstantText(
                                                  //   text: "",
                                                  //   style:
                                                  //       TextStyles.textStyle47,
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Swipe(
                          onSwipeRight: () {
                            if (transactionManager.invoiceScreenIndex != 0) {
                              transactionManager.invoiceScreenIndex--;
                              controllerForScroll.animateTo(
                                  transactionManager.invoiceScreenIndex *
                                          (controllerForScroll
                                                  .position.maxScrollExtent /
                                              5) +
                                      0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);

                              switch (
                                  transactionManager.invoiceScreenIndex.value) {
                                case 0:
                                  transactionManager.fetchInvoicesList(
                                    invoiceStatus: "Pending",
                                    resetFlag: true,
                                  );
                                  break;
                                case 1:
                                  transactionManager.fetchInvoicesList(
                                    invoiceStatus: 'Paid',
                                    resetFlag: true,
                                  );
                                  break;
                                case 2:
                                  transactionManager.fetchInvoicesList(
                                    type: "CN",
                                    resetFlag: true,
                                  );
                                  break;
                                case 3:
                                  transHistoryManager.getPaymentHistory(
                                      companyListViewModel.selectedCompany.value
                                              ?.companyId ??
                                          "");
                                  break;
                              }
                            }
                          },
                          onSwipeLeft: () {
                            //for right swipe
                            if (transactionManager.invoiceScreenIndex != 4) {
                              transactionManager.invoiceScreenIndex++;
                              controllerForScroll.animateTo(
                                  transactionManager.invoiceScreenIndex *
                                          (controllerForScroll
                                                  .position.maxScrollExtent /
                                              5) +
                                      70,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                              switch (
                                  transactionManager.invoiceScreenIndex.value) {
                                case 0:
                                  transactionManager.fetchInvoicesList(
                                    invoiceStatus: "Pending",
                                    resetFlag: true,
                                  );
                                  break;
                                case 1:
                                  transactionManager.fetchInvoicesList(
                                    invoiceStatus: 'Paid',
                                    resetFlag: true,
                                  );
                                  break;
                                case 2:
                                  transactionManager.fetchInvoicesList(
                                    type: "CN",
                                    resetFlag: true,
                                  );
                                  break;
                                case 3:
                                  transHistoryManager.getPaymentHistory(
                                      companyListViewModel.selectedCompany.value
                                              ?.companyId ??
                                          "");
                                  break;
                              }
                            }
                          },
                          child: Container(
                            width: maxWidth,
                            height: maxHeight,
                            decoration: const BoxDecoration(
                              color: Colours.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(26),
                                topRight: Radius.circular(26),
                              ),
                            ),
                            child: invoicesStatusScreens[
                                transactionManager.invoiceScreenIndex.value],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
