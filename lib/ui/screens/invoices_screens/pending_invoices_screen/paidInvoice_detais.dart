import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/util/Extensions.dart';
import '../../../../logic/view_models/transaction_manager.dart';
import '../../../../models/helper/service_locator.dart';
import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/string_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../routes/router.dart';
import '../../../theme/constants.dart';
import '../../../widgets/payment_history_widgets/company_details.dart';
import '../../../widgets/profile/profile_widget.dart';

class PaidInvoiceDetails extends StatefulWidget {
  const PaidInvoiceDetails({Key? key}) : super(key: key);

  @override
  State<PaidInvoiceDetails> createState() => _PaidInvoiceDetailsState();
}

class _PaidInvoiceDetailsState extends State<PaidInvoiceDetails> {
  String GstAmt = '';
  TransactionManager transactionManager = Get.put(TransactionManager());
  Credit_Details_VM credit_details_vm = Get.put(Credit_Details_VM());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colours.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: h10p * 2.2,
            flexibleSpace: ProfileWidget(),
          ),
          body: Column(children: [
            // SizedBox(
            //   height: h10p * .3,
            // ),
            Expanded(
                child: Container(
              width: maxWidth,
              decoration: const BoxDecoration(
                  color: Colours.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(left: 13, top: 8, right: 13),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 13),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context, landing);
                        },
                        child: Row(
                          children: [
                            ImageFromAssetPath<Widget>(
                                    assetPath: ImageAssetpathConstant.arrowLeft)
                                .imageWidget,
                            SizedBox(
                              width: w10p * .3,
                            ),
                            const ConstantText(
                              text: back,
                              style: TextStyles.textStyle41,
                            ),
                          ],
                        ),
                      ),
                    ),
                    CompanyDetailsWidget(
                      maxHeight: maxHeight,
                      maxWidth: maxWidth,
                      image: ImageAssetpathConstant.companyVector,
                      companyName: transactionManager
                              .currentPaidInvoice?.seller?.companyName ??
                          '',
                      companyAddress: transactionManager
                              .currentPaidInvoice?.seller?.address ??
                          '',
                      state: transactionManager
                              .currentPaidInvoice?.seller?.state ??
                          '',
                      gstNo: transactionManager
                              .currentPaidInvoice?.seller?.gstin ??
                          '',
                      creditLimit: (credit_details_vm.creditDetails?.value
                                      ?.companyDetails?.creditDetails
                                      ?.where((element) =>
                                          element.anchor_pan ==
                                          (transactionManager.invoiceDetails
                                                  .value?.seller?.pan ??
                                              ""))
                                      .length ??
                                  0) !=
                              0
                          ? ("${((double.tryParse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == (transactionManager.invoiceDetails.value?.seller?.pan ?? "")).first.creditLimit ?? "0")) != null ? double.parse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == (transactionManager.invoiceDetails.value?.seller?.pan ?? "")).first.creditLimit ?? "0")) : 0)).toStringAsFixed(2)}")
                          : "${credit_details_vm.creditDetails?.value?.companyDetails?.totalCreditAvailable ?? 0}",
                      balanceCredit: (credit_details_vm.creditDetails?.value
                                      ?.companyDetails?.creditDetails
                                      ?.where((element) =>
                                          element.anchor_pan ==
                                          (transactionManager.invoiceDetails
                                                  .value?.seller?.pan ??
                                              ""))
                                      .length ??
                                  0) !=
                              0
                          ? "${((double.tryParse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == (transactionManager.invoiceDetails.value?.seller?.pan ?? "")).first.creditAvailable ?? "0")) != null ? double.parse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == (transactionManager.invoiceDetails.value?.seller?.pan ?? "")).first.creditAvailable ?? "0")) : 0)).toStringAsFixed(2)}"
                          : "${credit_details_vm.creditDetails?.value?.companyDetails?.totalCreditLimit ?? 0}",
                    ),
                    SizedBox(height: h1p * 2),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Container(
                        height: h1p * 10,
                        width: w10p * 3,
                        decoration: BoxDecoration(
                          color: Colours.pearlGrey,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ConstantText(
                                    text: invoice_ID,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text:
                                        "${transactionManager.currentPaidInvoice?.invoiceNumber!}",
                                    style: TextStyles.textStyle56,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ConstantText(
                                    text: invoice_amount,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text:
                                        "${transactionManager.currentPaidInvoice?.invoiceAmount ?? "0.0"}"
                                            .setCurrencyFormatter(),
                                    style: TextStyles.textStyle140,
                                  ),
                                  // Text(
                                  //   "Paid Amount",
                                  //   style: TextStyles.textStyle62,
                                  // ),
                                  // Text(
                                  //   "₹ ${amtPayable.nonSymbol}",
                                  //   style: TextStyles.textStyle56,
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    //  Text(
                    //   "$daysLeft days left",
                    //   style: TextStyles.textStyle57,
                    //   textAlign: TextAlign.center,
                    // ),
                    Card(
                      elevation: .5,
                      child: Container(
                        height: h1p * 10,
                        color: Colours.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w10p * .50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ConstantText(
                                    text: invoice_date,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text: (transactionManager.currentPaidInvoice
                                                ?.invoiceDate)
                                            ?.getDateInRequiredFormat(
                                                requiredFormat: "dd-MMM-yyyy")
                                            ?.parseDateIn(
                                                requiredFormat:
                                                    "dd-MMM-yyyy") ??
                                        "",
                                    style: TextStyles.textStyle63,
                                  ),
                                  // Text(
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
                                ],
                              ),
                              ImageFromAssetPath<Widget>(
                                      assetPath:
                                          ImageAssetpathConstant.arrowSvg)
                                  .imageWidget,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ConstantText(
                                    text: invoice_due_date,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text: (transactionManager.currentPaidInvoice
                                                    ?.invoiceDueDate ??
                                                '')
                                            .getDateInRequiredFormat(
                                                requiredFormat: "dd-MMM-yyyy")
                                            ?.parseDateIn(
                                                requiredFormat:
                                                    "dd-MMM-yyyy") ??
                                        "",
                                    style: TextStyles.textStyle63,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Card(
                      elevation: .5,
                      child: Container(
                        height: h1p * 10,
                        color: Colours.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w10p * .50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ConstantText(
                                    text: payable_amount,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text:
                                        "${transactionManager.currentPaidInvoice?.payableAmount ?? "0.0"}"
                                            .setCurrencyFormatter(),
                                    style: TextStyles.textStyle140,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ConstantText(
                                    text: outstanding_amount,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text:
                                        "${(transactionManager.currentPaidInvoice?.outstandingAmount).getDoubleValue()}"
                                            .setCurrencyFormatter(),
                                    style: TextStyles.textStyle140,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Card(
                      elevation: .5,
                      child: Container(
                        height: h1p * 10,
                        color: Colours.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w10p * .50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ConstantText(
                                    text: discount_constant,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text:
                                        "${transactionManager.currentPaidInvoice?.discount ?? "0.0"}"
                                            .setCurrencyFormatter(),
                                    style: TextStyles.textStyle143,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ConstantText(
                                    text: interest_constant,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text:
                                        "${transactionManager.currentPaidInvoice?.paidInterest ?? "0.0"}"
                                            .setCurrencyFormatter(),
                                    style: TextStyles.textStyle142,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Card(
                      elevation: .5,
                      child: Container(
                        height: h1p * 10,
                        color: Colours.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w10p * .50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ConstantText(
                                    text: gst_amount,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text:
                                        "${transactionManager.currentPaidInvoice?.billDetails!.gstSummary?.totalTax ?? "0.0"}"
                                            .setCurrencyFormatter(),
                                    style: TextStyles.textStyle140,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ConstantText(
                                    text: uploaded_at,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text: (transactionManager.currentPaidInvoice
                                                    ?.createdAt ??
                                                '')
                                            .getDateInRequiredFormat(
                                                requiredFormat: "dd-MMM-yyyy")
                                            ?.parseDateIn(
                                                requiredFormat:
                                                    "dd-MMM-yyyy") ??
                                        "",
                                    style: TextStyles.textStyle63,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: .5,
                      child: Container(
                        height: h1p * 10,
                        color: Colours.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w10p * .50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ConstantText(
                                    text: paid_amount,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text:
                                        "${transactionManager.currentPaidInvoice?.paidAmount ?? "0.0"}"
                                            .setCurrencyFormatter(),
                                    style: TextStyles.textStyle140,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Container(
                        width: 200,
                        // width: maxWidth,
                        height: 40,
                        color: Colors.white,
                        child: GestureDetector(
                            onTap: () async {
                              // progress!.show();
                              if (transactionManager.currentPaidInvoice
                                      ?.invoiceFile?.isNotEmpty ??
                                  false) {
                                await getIt<TransactionManager>().openFile(
                                    url: transactionManager
                                            .currentPaidInvoice?.invoiceFile ??
                                        "");
                                // progress.dismiss();
                                Fluttertoast.showToast(
                                    webPosition: "center",
                                    msg: opening_invoice_file);
                              } else {
                                Fluttertoast.showToast(
                                    webPosition: "center",
                                    msg: invoice_file_not_found);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: transactionManager.currentPaidInvoice
                                              ?.invoiceFile?.isNotEmpty ??
                                          false
                                      ? Colours.tangerine
                                      : Colors.grey),
                              child: Center(
                                child: ConstantText(
                                    text: download_invoices,
                                    style: TextStyles.textStyle150),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ]),
        ),
      );
    });
  }
}
