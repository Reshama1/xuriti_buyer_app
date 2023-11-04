import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/string_constants.dart';
import '../../../../logic/view_models/transaction_manager.dart';
import '../../../../models/core/invoice_model.dart';
import '../../../../models/helper/service_locator.dart';
import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../routes/router.dart';
import '../../../theme/constants.dart';
import '../../../widgets/payment_history_widgets/company_details.dart';
import '../../../widgets/profile/profile_widget.dart';

class SavemoreDetails extends StatefulWidget {
  final Invoice invoice;
  const SavemoreDetails({Key? key, required this.invoice}) : super(key: key);

  @override
  State<SavemoreDetails> createState() => _SavemoreDetailsState();
}

class _SavemoreDetailsState extends State<SavemoreDetails> {
  Credit_Details_VM credit_details_vm = Get.put(Credit_Details_VM());

  @override
  Widget build(BuildContext context) {
    num discount = widget.invoice.paidDiscount.getDoubleValue();
    String discstr = discount.toString();
    double dbldisc = discstr.getDoubleValue();

    num interest = widget.invoice.paidInterest.getDoubleValue();

    String intrst = interest.toString();
    double dblintrst = intrst.getDoubleValue();

    double invAmt = widget.invoice.invoiceAmount.getDoubleValue();

    double outamt = widget.invoice.outstandingAmount.getDoubleValue();

    String paidInvAmount =
        widget.invoice.outstandingAmount.getDoubleValue().toStringAsFixed(2);
    double paidamt = paidInvAmount.getDoubleValue();

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
                      companyName: widget.invoice.seller?.companyName ?? '',
                      companyAddress: widget.invoice.seller?.address ?? '',
                      state: widget.invoice.seller?.state ?? '',
                      gstNo: widget.invoice.seller?.gstin ?? '',
                      creditLimit: (credit_details_vm.creditDetails?.value
                                      ?.companyDetails?.creditDetails
                                      ?.where((element) =>
                                          element.anchor_pan ==
                                          (widget.invoice.seller?.pan ?? ""))
                                      .length ??
                                  0) !=
                              0
                          ? ("${((double.tryParse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == (widget.invoice.seller?.pan ?? "")).first.creditLimit ?? "0")) != null ? double.parse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == (widget.invoice.seller?.pan ?? "")).first.creditLimit ?? "0")) : 0)).toStringAsFixed(2)}")
                          : "${credit_details_vm.creditDetails?.value?.companyDetails?.totalCreditAvailable ?? 0}",
                      balanceCredit: (credit_details_vm.creditDetails?.value
                                      ?.companyDetails?.creditDetails
                                      ?.where((element) =>
                                          element.anchor_pan ==
                                          (widget.invoice.seller?.pan ?? ""))
                                      .length ??
                                  0) !=
                              0
                          ? "${((double.tryParse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == (widget.invoice.seller?.pan ?? "")).first.creditAvailable ?? "0")) != null ? double.parse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == (widget.invoice.seller?.pan ?? "")).first.creditAvailable ?? "0")) : 0)).toStringAsFixed(2)}"
                          : "${credit_details_vm.creditDetails?.value?.companyDetails?.totalCreditLimit ?? 0}",
                    ),
                    SizedBox(height: h1p * 2),
                    // ConstantText(
                    // text:
                    //   // " Payments Pending since 10 days",
                    //   currentDate.isAfter(dd)
                    //       ? " ${currentDate.difference(dd).inDays.toString()} days overdue"
                    //       : " Due since ${currentDate.difference(id).inDays.toString()} days",
                    //   //" ${daysLeft.toString()} days left",
                    //   style: TextStyles.textStyle57,
                    //   textAlign: TextAlign.center,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colours.pearlGrey,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstantText(
                                      text: invoice_ID,
                                      style: TextStyles.textStyle62,
                                    ),
                                    ConstantText(
                                      text:
                                          "${widget.invoice.invoiceNumber ?? ""}",
                                      style: TextStyles.textStyle56,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ConstantText(
                                      text: payable_amount,
                                      style: TextStyles.textStyle62,
                                    ),
                                    ConstantText(
                                      text: "${paidamt.getDoubleValue()}"
                                          .setCurrencyFormatter(),
                                      style: TextStyles.textStyle56,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    //  ConstantText(
                    // text:
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
                                    text: (widget.invoice.invoiceDate)
                                        ?.getDateInRequiredFormat(
                                            requiredFormat: "dd-MMM-yyyy")
                                        ?.parseDateIn(
                                            requiredFormat: "dd-MMM-yyyy"),
                                    style: TextStyles.textStyle63,
                                  ),
                                  // ConstantText(
                                  // text:
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
                                    text: due_date,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text: (widget.invoice.invoiceDueDate)
                                        ?.getDateInRequiredFormat(
                                            requiredFormat: "dd-MMM-yyyy")
                                        ?.parseDateIn(
                                            requiredFormat: "dd-MMM-yyyy"),
                                    style: TextStyles.textStyle63,
                                  ),
                                  // ConstantText(
                                  // text:
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
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
                                    text: invoice_amount,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text: "${invAmt}".setCurrencyFormatter(),
                                    style: TextStyles.textStyle140,
                                  ),
                                  // ConstantText(
                                  // text:
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ConstantText(
                                    text: gst_amount,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text: widget.invoice.billDetails?.gstSummary
                                        ?.totalTax
                                        .getDoubleValue()
                                        .toString()
                                        .setCurrencyFormatter(),
                                    style: TextStyles.textStyle140,
                                  ),
                                  // ConstantText(
                                  // text:
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
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
                                    text: outstanding_amount,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text: "${outamt}".setCurrencyFormatter(),
                                    style: TextStyles.textStyle140,
                                  ),
                                  // ConstantText(
                                  // text:
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
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
                                    text: (widget.invoice.createdAt)
                                        ?.getDateInRequiredFormat(
                                            requiredFormat: "dd-MMM-yyyy")
                                        ?.parseDateIn(
                                            requiredFormat: "dd-MMM-yyyy"),
                                    style: TextStyles.textStyle63,
                                  ),
                                  // ConstantText(
                                  // text:
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
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
                                    text: "${dbldisc}".setCurrencyFormatter(),
                                    style: TextStyles.textStyle143,
                                  ),
                                  // ConstantText(
                                  // text:
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
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
                                    text: "${dblintrst}".setCurrencyFormatter(),
                                    style: TextStyles.textStyle142,
                                  ),
                                  // ConstantText(
                                  // text:
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: GestureDetector(
                              onTap: () async {
                                // progress!.show();
                                if (widget.invoice.invoiceFile!.isNotEmpty) {
                                  await getIt<TransactionManager>().openFile(
                                      url: widget.invoice.invoiceFile ?? "");
                                  // progress.dismiss();
                                  Fluttertoast.showToast(
                                      msg: opening_invoice_file);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: invoice_file_not_found);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: (widget.invoice.invoiceFile
                                                ?.isNotEmpty ??
                                            false)
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
