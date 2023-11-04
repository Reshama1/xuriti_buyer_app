import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/method_constant.dart';
import 'package:xuriti/util/common/string_constants.dart';
import '../../../../logic/view_models/transaction_manager.dart';
import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../routes/router.dart';
import '../../../theme/constants.dart';
import '../../../widgets/payment_history_widgets/company_details.dart';
import '../../../widgets/profile/profile_widget.dart';

class UpcomingDetails extends StatefulWidget {
  final String invoiceId;
  UpcomingDetails({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<UpcomingDetails> createState() => _UpcomingDetailsState();
}

class _UpcomingDetailsState extends State<UpcomingDetails> {
  TransactionManager transactionManager = Get.put(TransactionManager());
  Credit_Details_VM credit_details_vm = Get.put(Credit_Details_VM());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      transactionManager.getInvoiceDetails(invoiceId: widget.invoiceId);
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
        return WillPopScope(
          onWillPop: () async {
            await Navigator.pushNamed(context, landing);

            return true;
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colours.black,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: h10p * 2,
                flexibleSpace: ProfileWidget(),
              ),
              body: Obx(() {
                return Column(children: [
                  SizedBox(
                    height: h10p * .3,
                  ),
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
                      padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 13),
                            child: GestureDetector(
                              onTap: () async {
                                // Navigator.pop(context);
                                Navigator.pushNamed(context, landing);
                              },
                              child: Row(
                                children: [
                                  ImageFromAssetPath<Widget>(
                                          assetPath:
                                              ImageAssetpathConstant.arrowLeft)
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
                            companyName: transactionManager.invoiceDetails.value
                                    ?.seller?.companyName ??
                                '',
                            companyAddress: transactionManager
                                    .invoiceDetails.value?.seller?.address ??
                                '',
                            state: transactionManager
                                    .invoiceDetails.value?.seller?.state ??
                                '',
                            gstNo: transactionManager
                                    .invoiceDetails.value?.seller?.gstin ??
                                '',
                            creditLimit: (credit_details_vm.creditDetails?.value
                                            ?.companyDetails?.creditDetails
                                            ?.where((element) =>
                                                element.anchor_pan ==
                                                (transactionManager
                                                        .invoiceDetails
                                                        .value
                                                        ?.seller
                                                        ?.pan ??
                                                    ""))
                                            .length ??
                                        0) !=
                                    0
                                ? ("${((double.tryParse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == (transactionManager.invoiceDetails.value?.seller?.pan ?? "")).first.creditLimit ?? "0")) != null ? double.parse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == (transactionManager.invoiceDetails.value?.seller?.pan ?? "")).first.creditLimit ?? "0")) : 0)).toStringAsFixed(2)}")
                                : "${credit_details_vm.creditDetails?.value?.companyDetails?.totalCreditAvailable ?? 0}",
                            balanceCredit: (credit_details_vm
                                            .creditDetails
                                            ?.value
                                            ?.companyDetails
                                            ?.creditDetails
                                            ?.where((element) =>
                                                element.anchor_pan ==
                                                (transactionManager
                                                        .invoiceDetails
                                                        .value
                                                        ?.seller
                                                        ?.pan ??
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
                              decoration: BoxDecoration(
                                color: Colours.pearlGrey,
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w10p * .27,
                                    vertical: h1p * 1.2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ConstantText(
                                          text: invoice_ID,
                                          style: TextStyles.textStyle62,
                                        ),
                                        SizedBox(
                                          width: w10p * 2.5,
                                          child: AutoSizeText(
                                            (transactionManager.invoiceDetails
                                                    .value?.invoiceNumber ??
                                                ""),
                                            style: TextStyles.textStyle56,
                                            // overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        ConstantText(
                                          text: invoice_status,
                                          style: TextStyles.textStyle62,
                                        ),
                                        ConstantText(
                                          text:
                                              "${transactionManager.invoiceDetails.value?.invoiceStatus ?? ""}",
                                          style: TextStyles.textStyle63,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        ConstantText(
                                          text: outstanding_amount,
                                          style: TextStyles.textStyle62,
                                        ),
                                        ConstantText(
                                          text: transactionManager
                                              .invoiceDetails
                                              .value
                                              ?.outstandingAmount
                                              ?.setCurrencyFormatter(),
                                          style: TextStyles.textStyleC85,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ConstantText(
                            text: getDueSinceAndOverDueTextForInvoices(
                                invoiceDate: transactionManager
                                        .invoiceDetails.value?.invoiceDate ??
                                    "",
                                invoiceDueDate: transactionManager
                                        .invoiceDetails.value?.invoiceDueDate ??
                                    ""),
                            //" ${daysLeft.toString()} days left",
                            style: TextStyles.textStyle57,
                            textAlign: TextAlign.center,
                          ),
                          Card(
                            elevation: .5,
                            child: Container(
                              height: h1p * 10,
                              color: Colours.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w10p * .50),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 4,
                                        ),
                                        ConstantText(
                                          text: invoice_date,
                                          style: TextStyles.textStyle62,
                                        ),
                                        ConstantText(
                                          text: (transactionManager
                                                          .invoiceDetails
                                                          .value
                                                          ?.invoiceDate ??
                                                      "")
                                                  .getDateInRequiredFormat(
                                                      requiredFormat:
                                                          "dd-MMM-yyyy")
                                                  ?.parseDateIn(
                                                      requiredFormat:
                                                          "dd-MMM-yyyy") ??
                                              "",
                                          style: TextStyles.textStyle63,
                                        ),
                                      ],
                                    ),
                                    ImageFromAssetPath<Widget>(
                                            assetPath:
                                                ImageAssetpathConstant.arrowSvg)
                                        .imageWidget,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 4,
                                        ),
                                        ConstantText(
                                          text: due_date,
                                          style: TextStyles.textStyle62,
                                        ),
                                        ConstantText(
                                          text: (transactionManager
                                                          .invoiceDetails
                                                          .value
                                                          ?.invoiceDueDate ??
                                                      "")
                                                  .getDateInRequiredFormat(
                                                      requiredFormat:
                                                          "dd-MMM-yyyy")
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
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: w10p * .5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 4,
                                        ),
                                        ConstantText(
                                          text: invoice_amount,
                                          style: TextStyles.textStyle62,
                                        ),
                                        ConstantText(
                                          text:
                                              "${transactionManager.invoiceDetails.value?.invoiceAmount ?? "0.0"}"
                                                  .setCurrencyFormatter(),
                                          style: TextStyles.textStyle65,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 4,
                                        ),
                                        ConstantText(
                                          text: total_invoice_amount,
                                          style: TextStyles.textStyle62,
                                        ),
                                        ConstantText(
                                          text:
                                              "${(transactionManager.invoiceDetails.value?.invoiceAmount ?? "0.0").getDoubleValue() + (transactionManager.invoiceDetails.value?.billDetails?.gstSummary?.totalTax ?? "0.0").getDoubleValue()}"
                                                  .setCurrencyFormatter(),
                                          style: TextStyles.textStyle66,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: h1p * 1,
                          ),
                          Card(
                            elevation: .5,
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w10p * .5),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                "${transactionManager.invoiceDetails.value?.interest ?? 0.0}"
                                                    .setCurrencyFormatter(),
                                            style: TextStyles.textStyle142,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                                "${transactionManager.invoiceDetails.value?.discount ?? 0.0}"
                                                    .setCurrencyFormatter(),
                                            style: TextStyles.textStyle143,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: h1p * 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h1p * 1,
                          ),
                          Card(
                            elevation: .5,
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w10p * .5),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                "${transactionManager.invoiceDetails.value?.billDetails?.gstSummary?.totalTax ?? ""}"
                                                    .setCurrencyFormatter(),
                                            style: TextStyles.textStyle65,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 4,
                                          ),
                                          ConstantText(
                                            text: amount_paid,
                                            style: TextStyles.textStyle62,
                                          ),
                                          ConstantText(
                                            text:
                                                "${(transactionManager.invoiceDetails.value?.paidAmount ?? 0.0).getDoubleValue()}"
                                                    .setCurrencyFormatter(),
                                            style: TextStyles.textStyle66,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: h1p * 2,
                                  ),
                                ],
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
                                    if (transactionManager.invoiceDetails.value
                                            ?.invoiceFile?.isNotEmpty ??
                                        false) {
                                      await transactionManager.openFile(
                                          url: transactionManager.invoiceDetails
                                                  .value?.invoiceFile ??
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: transactionManager
                                                    .invoiceDetails
                                                    .value
                                                    ?.invoiceFile
                                                    ?.isNotEmpty ??
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
                ]);
              }),
            ),
          ),
        );
      },
    );
  }
}
