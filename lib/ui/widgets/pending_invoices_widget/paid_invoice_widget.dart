import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/string_constants.dart';
import '../../../logic/view_models/transaction_manager.dart';
import '../../../models/core/invoice_model.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';

class PaidInvoiceWidget extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;
  final bool isOverdue;
  final String? amount;
  final String? savedAmount;
  final String? invoiceDate;
  final String? dueDate;
  final String? gst;
  final String? invoiceAmount;
  final Invoice? fullDetails;

  final String companyName;
  PaidInvoiceWidget(
      {required this.invoiceAmount,
      required this.gst,
      required this.fullDetails,
      required this.maxWidth,
      required this.maxHeight,
      required this.amount,
      required this.savedAmount,
      required this.invoiceDate,
      required this.dueDate,
      required this.companyName,
      required this.isOverdue});

  @override
  State<PaidInvoiceWidget> createState() => _PaidInvoiceWidgetState();
}

class _PaidInvoiceWidgetState extends State<PaidInvoiceWidget> {
  TransactionManager transactionManager = Get.put(TransactionManager());

  @override
  Widget build(BuildContext context) {
    double h1p = widget.maxHeight * 0.01;
    double h10p = widget.maxHeight * 0.1;
    double w10p = widget.maxWidth * 0.1;
    return ExpandableNotifier(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: w10p * .5, vertical: h10p * 0.16),
        child: Expandable(
            collapsed: ExpandableButton(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: widget.fullDetails?.invoiceType == "IN"
                        ? Colours.offWhite
                        : Color(0xfffcdcb4),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ConstantText(
                              text: invoice_amount,
                              style: TextStyles.textStyle57,
                            ),
                            ConstantText(
                              text:
                                  "${(widget.fullDetails?.invoiceAmount ?? "0.0").getDoubleValue()}"
                                      .setCurrencyFormatter(),
                              style: TextStyles.textStyle58,
                            ),
                          ],
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ConstantText(
                                  text: invoice_amount,
                                  style: TextStyles.textStyle57,
                                ),
                                ConstantText(
                                  text:
                                      "${widget.fullDetails?.invoiceAmount ?? "0.0"}"
                                          .setCurrencyFormatter(),
                                  style: TextStyles.textStyle58,
                                )
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
                            SizedBox(
                              height: 4,
                            ),
                            ConstantText(
                              text: invoice_date,
                              style: TextStyles.textStyle62,
                            ),
                            ConstantText(
                              text: widget.fullDetails?.invoiceDate
                                  ?.getDateInRequiredFormat(
                                      requiredFormat: "dd-MMM-yyyy")
                                  ?.parseDateIn(requiredFormat: "dd-MMM-yyyy"),
                              style: TextStyles.textStyle63,
                            ),
                          ],
                        ),
                        ImageFromAssetPath<Widget>(
                                assetPath: ImageAssetpathConstant.arrowSvg)
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
                              text: widget.fullDetails?.invoiceDueDate
                                  ?.getDateInRequiredFormat(
                                      requiredFormat: "dd-MMM-yyyy")
                                  ?.parseDateIn(requiredFormat: "dd-MMM-yyyy"),
                              style: TextStyles.textStyle63,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [
                        Row(
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
                                  text:
                                      "${widget.fullDetails?.invoiceAmount ?? "0.0"}"
                                          .setCurrencyFormatter(),
                                  style: TextStyles.textStyle65,
                                )
                                //    Text("Asian Paints",style: TextStyles.textStyle34,),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h1p * 1.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.isOverdue
                                    ? const ConstantText(
                                        text: interest_constant,
                                        style: TextStyles.textStyle62,
                                      )
                                    : Container()
                                // const Text(
                                //   "You Save",
                                //   style: TextStyles.textStyle62,
                                // ),
                                // Text(
                                //   "₹ $savedAmount",
                                //   style:isOverdue?
                                //   TextStyles.textStyle73:
                                //   TextStyles.textStyle77,
                                // ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: GestureDetector(
                              onTap: () {
                                widget.isOverdue
                                    ? Navigator.pushNamed(
                                        context, overdueDetails)
                                    : transactionManager
                                        .changePaidInvoice(widget.fullDetails);

                                Navigator.pushNamed(
                                    context, paidInvoiceDetails);
                              },
                              child: Container(
                                // width: w10p * 5,
                                height: h1p * 8,
                                child: Center(
                                    child: ConstantText(
                                  text: view_details,
                                  color: Colors.black,
                                  style: TextStyles.textStyle195,
                                )),
                                decoration: BoxDecoration(
                                    // borderRadius:
                                    // BorderRadius.all(Radius.circular(5)),
                                    // color: Colours.black,
                                    border: Border.all(width: 1)),
                              )),
                        ),
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
