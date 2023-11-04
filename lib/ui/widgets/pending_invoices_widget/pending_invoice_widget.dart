import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/method_constant.dart';
import 'package:xuriti/util/common/string_constants.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../logic/view_models/transaction_manager.dart';
import '../../../models/core/invoice_model.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';

class PendingInvoiceWidget extends StatefulWidget {
  final double maxWidth;

  final double maxHeight;
  final Invoice? fullDetails;

  PendingInvoiceWidget({
    required this.fullDetails,
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  State<PendingInvoiceWidget> createState() => _PendingInvoiceWidgetState();
}

class _PendingInvoiceWidgetState extends State<PendingInvoiceWidget> {
  TextEditingController acceptController = TextEditingController();
  TextEditingController rejectController = TextEditingController();

  TransactionManager transactionManager = Get.put(TransactionManager());
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());

  ExpandableController expandController = ExpandableController();

  @override
  void initState() {
    transactionManager.selectedSeller.listen((p0) {
      if (transactionManager.landingScreenIndex.value == 1 &&
          transactionManager.invoiceScreenIndex == 0) {
        transactionManager.fetchInvoicesList(invoiceStatus: "Pending");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h1p = widget.maxHeight * 0.01;
    double w10p = widget.maxWidth * 0.1;
    double h10p = widget.maxHeight * 0.1;

    return ExpandableNotifier(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w10p * .5, vertical: 10),
        child: Expandable(
          // controller: expandController,
          collapsed: InkWell(
            onTap: () {
              expandController.toggle();
            },
            child: ExpandableButton(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colours.offWhite,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.start,
                            maxLines: 10,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        "${widget.fullDetails?.invoiceNumber}",
                                    style: TextStyles.textStyle6),
                                WidgetSpan(
                                    child: Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: ImageFromAssetPath<Widget>(
                                    assetPath:
                                        ImageAssetpathConstant.arrowCircleRight,
                                    width: 15.0,
                                    height: 15.0,
                                  ).imageWidget,
                                )),
                                TextSpan(
                                  text: "\n" +
                                      (widget.fullDetails?.seller
                                              ?.companyName ??
                                          ""),
                                  style: TextStyles.companyName,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ConstantText(
                              text: getDueSinceAndOverDueTextForInvoices(
                                  invoiceDate:
                                      widget.fullDetails?.invoiceDate ?? "",
                                  invoiceDueDate:
                                      widget.fullDetails?.invoiceDueDate ?? ""),
                              style: TextStyles.textStyle57,
                              textAlign: TextAlign.center,
                            ),
                            ConstantText(
                              text: "${widget.fullDetails?.invoiceAmount ?? ""}"
                                  .setCurrencyFormatter(),
                              style: TextStyles.textStyle58,
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            ),
          ),
          expanded: Column(
            children: [
              ExpandableButton(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colours.offWhite,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.start,
                              maxLines: 10,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          "${widget.fullDetails?.invoiceNumber}",
                                      style: TextStyles.textStyle6),
                                  WidgetSpan(
                                      child: Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Transform.rotate(
                                      angle: 32,
                                      child: ImageFromAssetPath<Widget>(
                                        assetPath: ImageAssetpathConstant
                                            .arrowCircleRight,
                                        width: 15.0,
                                        height: 15.0,
                                      ).imageWidget,
                                    ),
                                  )),
                                  TextSpan(
                                    text: "\n" +
                                        (widget.fullDetails?.seller
                                                ?.companyName ??
                                            ""),
                                    style: TextStyles.companyName,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ConstantText(
                                text: getDueSinceAndOverDueTextForInvoices(
                                    invoiceDate:
                                        widget.fullDetails?.invoiceDate ?? "",
                                    invoiceDueDate:
                                        widget.fullDetails?.invoiceDueDate ??
                                            ""),
                                style: TextStyles.textStyle57,
                                textAlign: TextAlign.center,
                              ),
                              ConstantText(
                                text:
                                    "${widget.fullDetails?.invoiceAmount ?? ""}"
                                        .setCurrencyFormatter(),
                                style: TextStyles.textStyle58,
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
              ),
              Card(
                elevation: .5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          const ConstantText(
                            text: invoice_date,
                            style: TextStyles.textStyle62,
                          ),
                          ConstantText(
                            text: widget.fullDetails?.invoiceDate
                                ?.getDateInRequiredFormat(
                                    requiredFormat: 'dd-MMM-yyyy')
                                ?.parseDateIn(requiredFormat: 'dd-MMM-yyyy'),
                            style: TextStyles.textStyle63,
                          ),
                          // Text(
                          //   companyName,
                          //   style: TextStyles.companyName,
                          // ),
                        ],
                      ),
                      ImageFromAssetPath<Widget>(
                              assetPath: ImageAssetpathConstant.arrowSvg)
                          .imageWidget,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          const ConstantText(
                            text: due_date,
                            style: TextStyles.textStyle62,
                          ),
                          ConstantText(
                            text: widget.fullDetails?.invoiceDueDate
                                ?.getDateInRequiredFormat(
                                    requiredFormat: 'dd-MMM-yyyy')
                                ?.parseDateIn(requiredFormat: 'dd-MMM-yyyy'),
                            style: TextStyles.textStyle63,
                          ),
                          // Text(
                          //  companyName,
                          //   style: TextStyles.companyName,
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              const ConstantText(
                                text: invoice_amount,
                                style: TextStyles.textStyle62,
                              ),
                              ConstantText(
                                text:
                                    "${widget.fullDetails?.invoiceAmount ?? "0.00"}"
                                        .setCurrencyFormatter(),
                                style: TextStyles.textStyle65,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, savemoreDetails,
                                      arguments: widget.fullDetails);
                                },
                                child: Container(
                                  // width: 100,
                                  height: h10p * 0.9,
                                  child: Center(
                                      child: Row(
                                    children: [
                                      ConstantText(
                                        text: view_details,
                                        color: Colours.primary,
                                        style: TextStyles.textStyle195,
                                      ),
                                      Icon(
                                        Icons.assignment_outlined,
                                        color: Colours.primary,
                                      )
                                    ],
                                  )),
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: h1p * 1.5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              // vertical: h10p * 5,
                                              ),
                                          child: AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(0.0))),
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Center(
                                                  child: ConstantText(
                                                      text: comment),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(
                                                        Icons.cancel_outlined)),
                                              ],
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextBoxField(
                                                  controller: rejectController,
                                                  hintText: leave_a_comment,
                                                  onChanged: (_) {
                                                    acceptController
                                                            .text.isEmpty
                                                        ? Row(
                                                            children: const [
                                                              ConstantText(
                                                                text:
                                                                    please_write_reason,
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)),
                                                              ),
                                                            ],
                                                          )
                                                        : Container();
                                                  },
                                                ),
                                                SizedBox(
                                                  height: h1p * 5,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    if (rejectController
                                                        .text.isNotEmpty) {
                                                      String timeStamp =
                                                          DateTime.now()
                                                              .toString();
                                                      context.showLoader();
                                                      // progress!.show();
                                                      print(acceptController
                                                          .text);
                                                      String message = await transactionManager
                                                          .changeInvoiceStatus(
                                                              widget.fullDetails
                                                                      ?.sId ??
                                                                  "",
                                                              "Rejected",
                                                              widget
                                                                  .fullDetails,
                                                              timeStamp,
                                                              true,
                                                              acceptController
                                                                  .text,
                                                              "NA");

                                                      context.hideLoader();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          content: ConstantText(
                                                            text: message,
                                                            style: const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255)),
                                                          ),
                                                        ),
                                                      );
                                                      transactionManager
                                                          .fetchInvoicesList(
                                                              invoiceStatus:
                                                                  "Pending",
                                                              resetFlag: true);
                                                      Navigator.pop(context);
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              please_write_reason,
                                                          textColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255));
                                                    }
                                                  },
                                                  child: Container(
                                                    height: h1p * 8,
                                                    width: w10p * 3,
                                                    decoration: BoxDecoration(
                                                        color: Colours.white,
                                                        border:
                                                            Border.all(width: 1)
                                                        // borderRadius:
                                                        //     BorderRadius
                                                        //         .circular(6),
                                                        // color: Colours.pumpkin
                                                        ),
                                                    child: const Center(
                                                        child: ConstantText(
                                                      text: save,
                                                      color: Colors.black,
                                                      style:
                                                          TextStyles.subHeading,
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )).then((value) async {
                                  transactionManager.fetchInvoicesList(
                                      invoiceStatus: "Pending");
                                });
                              },
                              child: Container(
                                height: h1p * 8,
                                decoration: BoxDecoration(
                                  color: Colours.white,
                                  border: Border.all(width: 1),
                                ),
                                child: const Center(
                                  child: ConstantText(
                                    text: reject,
                                    color: Colors.black,
                                    style: TextStyles.textStyle46,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: w10p * 0.5,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        // vertical: h10p * 4,
                                        ),
                                    child: AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(0))),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Center(
                                            child: ConstantText(text: consent),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child:
                                                  Icon(Icons.cancel_outlined)),
                                        ],
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          widget.fullDetails?.invoiceType ==
                                                  "IN"
                                              ? ConstantText(
                                                  text: invoiceConsentMsg1(
                                                      widget.fullDetails?.nbfcName ??
                                                          '',
                                                      widget.fullDetails?.seller
                                                              ?.companyName ??
                                                          "",
                                                      widget.fullDetails
                                                              ?.invoiceNumber ??
                                                          ''))
                                              // "I agree and  approve Xuriti and it's financing partner ${widget.fullDetails?.nbfcName} is authorised to disburse funds to the Seller ${widget.fullDetails?.seller?.companyName ?? ""} for invoice -${widget.fullDetails?.invoiceNumber} on my behalf.")
                                              : ConstantText(
                                                  text: invoiceConsentMesg2(
                                                      invoiceNumber: widget
                                                              .fullDetails
                                                              ?.invoiceNumber ??
                                                          "",
                                                      nbfcName: widget
                                                              .fullDetails
                                                              ?.nbfcName ??
                                                          "",
                                                      companyName: widget
                                                              .fullDetails
                                                              ?.seller
                                                              ?.companyName ??
                                                          "")),
                                          // "I agree and approve that credit note ${widget.fullDetails?.invoiceNumber} is correct. Xuriti and it's financing partner ${widget.fullDetails?.nbfcName} is authorised to adjust the credit note amount towards the upcoming invoices and disburse the remaining balance to ${widget.fullDetails?.seller?.companyName ?? ""}."),
                                          TextBoxField(
                                            controller: acceptController,
                                            hintText: leave_a_comment,
                                          ),
                                          SizedBox(
                                            height: h1p * 4,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              String timeStamp =
                                                  DateTime.now().toString();

                                              if (acceptController
                                                  .text.isNotEmpty) {
                                                context.showLoader();
                                                String? message =
                                                    await transactionManager
                                                        .changeInvoiceStatus(
                                                  widget.fullDetails?.sId ?? "",
                                                  "Confirmed",
                                                  widget.fullDetails,
                                                  timeStamp,
                                                  true,
                                                  acceptController.text,
                                                  widget.fullDetails?.invoiceType ==
                                                          "IN"
                                                      ? invoiceConsentMsg1(
                                                          widget.fullDetails
                                                                  ?.nbfcName ??
                                                              '',
                                                          widget
                                                                  .fullDetails
                                                                  ?.seller
                                                                  ?.companyName ??
                                                              "",
                                                          widget.fullDetails
                                                                  ?.invoiceNumber ??
                                                              '')
                                                      // "I agree and  approve Xuriti and it's financing partner ${widget.fullDetails?.nbfcName} is authorised to disburse funds to the Seller ${widget.fullDetails?.seller?.companyName ?? ""} for invoice -${widget.fullDetails?.invoiceNumber} on my behalf."
                                                      : invoiceConsentMesg2(
                                                          invoiceNumber: widget
                                                                  .fullDetails
                                                                  ?.invoiceNumber ??
                                                              "",
                                                          nbfcName: widget
                                                                  .fullDetails
                                                                  ?.nbfcName ??
                                                              "",
                                                          companyName: widget
                                                                  .fullDetails
                                                                  ?.seller
                                                                  ?.companyName ??
                                                              ""),
                                                  // "I agree and approve that credit note ${widget.fullDetails?.invoiceNumber} is correct. Xuriti and it's financing partner ${widget.fullDetails?.nbfcName} is authorised to adjust the credit note amount towards the upcoming invoices and disburse the remaining balance to ${widget.fullDetails?.seller?.companyName ?? ""}.",
                                                );

                                                context.hideLoader();
//

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        content: ConstantText(
                                                          text: message!,
                                                          style:
                                                              const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                        )));
                                                expandController.toggle();
                                                transactionManager
                                                    .fetchInvoicesList(
                                                  statusA: "Pending",
                                                  resetFlag: true,
                                                );
                                                Navigator.pop(context);
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: please_write_reason,
                                                    textColor:
                                                        const Color.fromARGB(
                                                            255,
                                                            251,
                                                            251,
                                                            251));
                                              }
                                            },
                                            child: Container(
                                              height: h1p * 8,
                                              width: w10p * 3,
                                              decoration: BoxDecoration(
                                                  // borderRadius:
                                                  //     BorderRadius.circular(6),
                                                  color: Colours.black),
                                              child: const Center(
                                                child: ConstantText(
                                                  text: accept,
                                                  style: TextStyles.subHeading,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: h1p * 8,
                                decoration: BoxDecoration(
                                  color: Colours.black,
                                  // borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ConstantText(
                                        text: accept,
                                        color: Colors.white,
                                        style: TextStyles.textStyle46,
                                      ),
                                      SizedBox(
                                        width: w10p * 0.1,
                                      ),
                                      Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: w10p * 0.43,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
