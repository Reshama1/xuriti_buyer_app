import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/string_constants.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../logic/view_models/transaction_manager.dart';
import '../../../models/core/invoice_model.dart';
import '../../../models/helper/service_locator.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';

//change for refress cnInvoices screen
class PendingCNInvoiceWidget extends StatefulWidget {
  final double maxWidth;

  final double maxHeight;
  final bool isOverdue;

  final Invoice? fullDetails;

  PendingCNInvoiceWidget({
    required this.fullDetails,
    required this.maxWidth,
    required this.maxHeight,
    required this.isOverdue,
  });

  @override
  _PendingCNInvoiceWidgetStatefulState createState() =>
      _PendingCNInvoiceWidgetStatefulState();
}

//
class _PendingCNInvoiceWidgetStatefulState
    extends State<PendingCNInvoiceWidget> {
  TransactionManager transactionManager = Get.put(TransactionManager());
  TextEditingController acceptController = TextEditingController();
  TextEditingController rejectController = TextEditingController();
  bool userConsentGiven = false;
  List<Invoice?> pendingInvoice = [];
//
  @override
  Widget build(BuildContext context) {
    double h1p = widget.maxHeight * 0.01;
    double h10p = widget.maxHeight * 0.1;
    double w10p = widget.maxWidth * 0.1;

    return ExpandableNotifier(
      initialExpanded: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w10p * .5, vertical: 10),
        child: Expandable(
            collapsed: ExpandableButton(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colours.offWhite
                      // color: fullDetails.invoiceType == "IN"
                      //     ? Colours.offWhite
                      //     : Color(0xfffcdcb4),
                      ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: RichText(
                            textAlign: TextAlign.start,
                            maxLines: 10,
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: widget.isOverdue
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: h1p * 1),
                                          child: Container(
                                            // height: h1p * 4.5,
                                            // width: w10p * 1.7,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colours.failPrimary,
                                            ),
                                            child: const Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(4),
                                                child: ConstantText(
                                                  text: overdue,
                                                  style: TextStyles.overdue,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ),
                                TextSpan(
                                    text: "\n" +
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
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ConstantText(
                                text: status,
                                style: TextStyles.textStyle57,
                              ),
                              ConstantText(
                                text: widget.fullDetails?.invoiceStatus ?? "",
                                style: TextStyles.textStyle57,
                              ),
                            ],
                          ),
                        ),
                        ConstantText(
                          text:
                              "${widget.fullDetails?.outstandingAmount.getDoubleValue()}"
                                  .setCurrencyFormatter(),
                          style: TextStyles.textStyle58,
                        )
                      ]),
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
                          children: [
                            Flexible(
                              child: RichText(
                                textAlign: TextAlign.start,
                                maxLines: 10,
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: widget.isOverdue
                                          ? Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: h1p * 1),
                                              child: Container(
                                                // height: h1p * 4.5,
                                                // width: w10p * 1.7,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colours.failPrimary,
                                                ),
                                                child: const Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(4),
                                                    child: ConstantText(
                                                      text: overdue,
                                                      style: TextStyles.overdue,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ),
                                    TextSpan(
                                        text: "\n" +
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
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ConstantText(
                                    text: status,
                                    style: TextStyles.textStyle57,
                                  ),
                                  ConstantText(
                                    text:
                                        widget.fullDetails?.invoiceStatus ?? "",
                                    style: TextStyles.textStyle57,
                                  ),
                                ],
                              ),
                            ),
                            ConstantText(
                              text:
                                  "${widget.fullDetails?.outstandingAmount.getDoubleValue()}"
                                      .setCurrencyFormatter(),
                              style: TextStyles.textStyle58,
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
                              text: (widget.fullDetails?.invoiceDate)
                                  ?.getDateInRequiredFormat(
                                      requiredFormat: "dd-MMM-yyyy")
                                  ?.parseDateIn(requiredFormat: "dd-MMM-yyyy"),
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
                              text: (widget.fullDetails?.invoiceDueDate)
                                  ?.getDateInRequiredFormat(
                                      requiredFormat: "dd-MMM-yyyy")
                                  ?.parseDateIn(requiredFormat: "dd-MMM-yyyy"),
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
                                  text: outstanding_amount,
                                  style: TextStyles.textStyle62,
                                ),
                                ConstantText(
                                  text:
                                      "${widget.fullDetails?.outstandingAmount.getDoubleValue()}"
                                          .setCurrencyFormatter(),
                                  style: TextStyles.textStyle65,
                                )
                                //    Text("Asian Paints",style: TextStyles.textStyle34,),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: GestureDetector(
                                  onTap: () {
                                    // progress!.show();
                                    context.showLoader();

                                    //  progress.dismiss();
                                    context.hideLoader();
                                    Navigator.pushNamed(
                                        context, savemoreDetails,
                                        arguments: widget.fullDetails);
                                    //Navigator.pushNamed(context, cnInvoices);
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
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h1p * 1.5,
                        ),
                        Row(
                          children: [
                            if (widget.fullDetails?.invoiceStatus == "Pending")
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      // vertical: h10p * 5,
                                                      ),
                                              child: AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    0))),
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
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Icon(Icons
                                                            .cancel_outlined)),
                                                  ],
                                                ),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextBoxField(
                                                      controller:
                                                          rejectController,
                                                      hintText: leave_a_comment,
                                                    ),
                                                    SizedBox(
                                                      height: h1p * 5,
                                                    ),
                                                    InkWell(
                                                        onTap: () async {
                                                          if (rejectController
                                                              .text
                                                              .isNotEmpty) {
                                                            userConsentGiven =
                                                                false;
                                                            String timeStamp =
                                                                DateTime.now()
                                                                    .toString();
                                                            //   progress!.show();
                                                            context
                                                                .showLoader();
                                                            print(
                                                                acceptController
                                                                    .text);
                                                            String message = await getIt<
                                                                    TransactionManager>()
                                                                .changeInvoiceStatus(
                                                                    widget
                                                                        .fullDetails
                                                                        ?.sId,
                                                                    "Rejected",
                                                                    widget
                                                                        .fullDetails,
                                                                    timeStamp,
                                                                    userConsentGiven,
                                                                    rejectController
                                                                        .text,
                                                                    "NA");

                                                            context
                                                                .hideLoader();

                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        behavior:
                                                                            SnackBarBehavior
                                                                                .floating,
                                                                        content:
                                                                            ConstantText(
                                                                          text:
                                                                              message,
                                                                          style:
                                                                              const TextStyle(color: Colors.red),
                                                                        )));

                                                            transactionManager
                                                                .fetchInvoicesList(
                                                              type: "CN",
                                                              resetFlag: true,
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                          } else {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    please_write_reason,
                                                                textColor:
                                                                    Colors.red);
                                                          }
                                                        },
                                                        child: Container(
                                                          height: h1p * 8,
                                                          width: w10p * 3,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Colours.white,
                                                            border: Border.all(
                                                              width: 1,
                                                            ),
                                                          ),
                                                          child: const Center(
                                                              child:
                                                                  ConstantText(
                                                            text: save,
                                                            color: Colors.black,
                                                            style: TextStyles
                                                                .subHeading,
                                                          )),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ));
                                  },
                                  child: Container(
                                    height: h1p * 8,
                                    decoration: BoxDecoration(
                                      color: Colours.white,
                                      border: Border.all(width: 1),
                                      // borderRadius: BorderRadius.circular(5)
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
                            if (widget.fullDetails?.invoiceStatus == "Pending")
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    if (widget.fullDetails?.invoiceStatus ==
                                        "Pending")
                                      showDialog(
                                          context: context,
                                          builder: (context) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        // vertical: h10p * 4,
                                                        ),
                                                child: AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          0))),
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Center(
                                                        child: ConstantText(
                                                            text: consent),
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Icon(Icons
                                                              .cancel_outlined)),
                                                    ],
                                                  ),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      widget.fullDetails
                                                                  ?.invoiceType ==
                                                              "CN"
                                                          ? ConstantText(
                                                              text: pendingInvConsent(
                                                                  widget.fullDetails
                                                                          ?.invoiceNumber ??
                                                                      '',
                                                                  widget.fullDetails
                                                                          ?.nbfcName ??
                                                                      '',
                                                                  widget
                                                                          .fullDetails
                                                                          ?.seller
                                                                          ?.companyName ??
                                                                      ""))

                                                          // "I agree and  approve Xuriti and it's financing partner ${fullDetails.nbfcName} is authorised to disburse funds to the Seller $companyName for invoice -${fullDetails.invoiceNumber} on my behalf.")
                                                          : ConstantText(
                                                              text: pendingInvConsent(
                                                                  widget.fullDetails
                                                                          ?.invoiceNumber ??
                                                                      '',
                                                                  widget.fullDetails
                                                                          ?.nbfcName ??
                                                                      '',
                                                                  widget
                                                                          .fullDetails
                                                                          ?.seller
                                                                          ?.companyName ??
                                                                      "")),
                                                      //"I agree and approve that credit note ${fullDetails.invoiceNumber} is correct. Xuriti and it's financing partner ${fullDetails.nbfcName} is authorised to adjust the credit note amount towards the upcoming invoices and disburse the remaining balance to $companyName."),
                                                      TextBoxField(
                                                        controller:
                                                            acceptController,
                                                        hintText:
                                                            leave_a_comment,
                                                      ),
                                                      SizedBox(
                                                        height: h1p * 4,
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          userConsentGiven =
                                                              true;
                                                          String timeStamp =
                                                              DateTime.now()
                                                                  .toString();
                                                          if (acceptController
                                                              .text
                                                              .isNotEmpty) {
                                                            String? message = await getIt<
                                                                    TransactionManager>()
                                                                .changeInvoiceStatus(
                                                                    widget
                                                                        .fullDetails
                                                                        ?.sId,
                                                                    "Confirmed",
                                                                    widget
                                                                        .fullDetails,
                                                                    timeStamp,
                                                                    userConsentGiven,
                                                                    acceptController
                                                                        .text,
                                                                    widget.fullDetails?.invoiceType ==
                                                                            "CN"
                                                                        ? invoiceConsentMsg1(
                                                                            widget.fullDetails?.nbfcName ??
                                                                                '',
                                                                            widget.fullDetails?.seller?.companyName ??
                                                                                '',
                                                                            widget.fullDetails?.invoiceNumber ??
                                                                                '')
                                                                        // "I agree and  approve Xuriti and it's financing partner ${widget.fullDetails?.nbfcName} is authorised to disburse funds to the Seller ${widget.fullDetails?.seller?.companyName} for invoice -${widget.fullDetails?.invoiceNumber} on my behalf."
                                                                        : invoiceConsentMesg2(
                                                                            invoiceNumber: widget.fullDetails?.invoiceNumber ??
                                                                                '',
                                                                            nbfcName: widget.fullDetails?.nbfcName ??
                                                                                '',
                                                                            companyName:
                                                                                widget.fullDetails?.seller?.companyName ?? "")

                                                                    //  "I agree and approve that credit note ${widget.fullDetails?.invoiceNumber} is correct. Xuriti and it's financing partner ${widget.fullDetails?.nbfcName} is authorised to adjust the credit note amount towards the upcoming invoices and disburse the remaining balance to ${widget.fullDetails?.seller?.companyName}.",
                                                                    );

                                                            print(
                                                                '${message} ====================>');
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        behavior:
                                                                            SnackBarBehavior
                                                                                .floating,
                                                                        content:
                                                                            ConstantText(
                                                                          text:
                                                                              message!,
                                                                          style:
                                                                              const TextStyle(color: Colors.green),
                                                                        )));

                                                            transactionManager
                                                                .fetchInvoicesList(
                                                              type: "CN",
                                                              resetFlag: true,
                                                            );
                                                          } else {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    please_write_reason,
                                                                textColor:
                                                                    Colors.red);
                                                          }

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: h1p * 8,
                                                          width: w10p * 3,
                                                          decoration:
                                                              BoxDecoration(
                                                                  // borderRadius:
                                                                  //     BorderRadius.circular(6),
                                                                  color: Colours
                                                                      .black),
                                                          child: const Center(
                                                            child: ConstantText(
                                                              text: accept,
                                                              style: TextStyles
                                                                  .subHeading,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                  },
                                  child: Container(
                                    height: h1p * 8,
                                    decoration: BoxDecoration(
                                      color: Colours.black,
                                      // borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
            )),
      ),
    );
  }
}
