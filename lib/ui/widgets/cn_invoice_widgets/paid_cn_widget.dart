import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:xuriti/util/Extensions.dart';
import '../../../logic/view_models/transaction_manager.dart';
import '../../../models/core/invoice_model.dart';
import '../../../models/helper/service_locator.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';

class PaidCNInvoiceWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final bool isOverdue;
  final String amount;
  final String savedAmount;
  final String invoiceDate;
  final String dueDate;
  final String gst;
  final String invoiceAmount;
  final Invoice fullDetails;

  final String companyName;
  PaidCNInvoiceWidget(
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
  Widget build(BuildContext context) {
    double gstAmt;
    double inv = amount.getDoubleValue();
    if (gst != "undefined" && gst.runtimeType == num) {
      gstAmt = gst.getDoubleValue();
    } else {
      gstAmt = 0;
    }
    double invAmt = invoiceAmount.getDoubleValue();
    double payableAMt = invAmt + gstAmt - inv;

    DateTime dd = DateTime.parse(dueDate);
    DateTime currentDate = DateTime.now();
    Duration dif = dd.difference(currentDate);
    int daysLeft = dif.inDays;

    double h1p = maxHeight * 0.01;

    double w10p = maxWidth * 0.1;
    return ExpandableNotifier(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w10p * .5, vertical: 10),
        child: Expandable(
            collapsed: ExpandableButton(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isOverdue
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: h1p * 1),
                                    child: Container(
                                      // height: h1p * 4.5,
                                      // width: w10p * 1.7,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
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

                            Row(
                              children: [
                                ConstantText(
                                  text: "${fullDetails.invoiceNumber} ",
                                  style: TextStyles.textStyle6,
                                ),
                                ImageFromAssetPath<Widget>(
                                        assetPath: ImageAssetpathConstant
                                            .arrowCircleRight)
                                    .imageWidget,
                              ],
                            ),

                            ConstantText(
                              text: companyName,
                              style: TextStyles.companyName,
                            ),
                            // isOverdue?
                            //  Text(
                            //   "interest charged",
                            //   style: TextStyles.textStyle102,
                            // ):,
                            // const Text(
                            //   "You Save",
                            //   style: TextStyles.textStyle102,
                            // ),
                            // Text(
                            //   "₹ $savedAmount",
                            //   style: isOverdue?
                            //   TextStyles.textStyle61 :
                            //   TextStyles.textStyle100,
                            // )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            isOverdue
                                ? ConstantText(
                                    text: "$daysLeft ${"dayOverdue"}",
                                    style: TextStyles.textStyle57,
                                  )
                                : ConstantText(
                                    text: paid_amount,
                                    style: TextStyles.textStyle57,
                                  ),
                            ConstantText(
                              text: "₹ ${payableAMt.toStringAsFixed(2)}",
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isOverdue
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: h1p * 1),
                                        child: Container(
                                          // height: h1p * 4.4,
                                          // width: w10p * 1.7,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colours.failPrimary,
                                          ),
                                          child: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(3.5),
                                              child: ConstantText(
                                                text: overdue,
                                                style: TextStyles.overdue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Row(
                                  children: [
                                    ConstantText(
                                      text: "${fullDetails.invoiceNumber} ",
                                      style: TextStyles.textStyle6,
                                    ),
                                    ImageFromAssetPath<Widget>(
                                            assetPath: ImageAssetpathConstant
                                                .arrowRight)
                                        .imageWidget,
                                  ],
                                ),

                                ConstantText(
                                  text: companyName,
                                  style: TextStyles.companyName,
                                ),
                                // isOverdue? const Text(
                                //   "Interest charged",
                                //   style: TextStyles.textStyle102,
                                // ):
                                // Text(
                                //   "You Save",
                                //   style: TextStyles.textStyle102,
                                // ),
                                // Text(
                                //   "₹ $savedAmount",
                                //   style:isOverdue?
                                //   TextStyles.textStyle61:
                                //   TextStyles.textStyle100,
                                // )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                isOverdue
                                    ? ConstantText(
                                        text: "$daysLeft ${"dayOverdue"}",
                                        style: TextStyles.textStyle57,
                                      )
                                    : ConstantText(
                                        text: paid_amount,
                                        style: TextStyles.textStyle57,
                                      ),
                                ConstantText(
                                  text: "₹ ${payableAMt.toStringAsFixed(2)}",
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
                            SizedBox(
                              height: 4,
                            ),
                            ConstantText(
                              text: invoice_date,
                              style: TextStyles.textStyle62,
                            ),
                            ConstantText(
                              text: (fullDetails.invoiceDate ?? "")
                                  .getDateInRequiredFormat(
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
                            SizedBox(
                              height: 4,
                            ),
                            ConstantText(
                              text: invoice_due_date,
                              style: TextStyles.textStyle62,
                            ),
                            ConstantText(
                              text: (fullDetails.invoiceDueDate ?? "")
                                  .getDateInRequiredFormat(
                                      requiredFormat: "dd-MMM-yyyy")
                                  ?.parseDateIn(requiredFormat: "dd-MMM-yyyy"),
                              style: TextStyles.textStyle63,
                            ),
                            // Text(
                            //   "Updated At",
                            //   style: TextStyles.textStyle62,
                            // ),
                            // Text(
                            //   idueDate,
                            //   style: TextStyles.textStyle63,
                            // ),
                            // Text(
                            //   companyName,
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
                                  text: "₹ ${payableAMt.toStringAsFixed(2)}",
                                  style: TextStyles.textStyle65,
                                )
                                //    Text("Asian Paints",style: TextStyles.textStyle34,),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 4,
                                ),
                                isOverdue
                                    ? ConstantText(
                                        text: payable_amount,
                                        style: TextStyles.textStyle62,
                                      )
                                    : ConstantText(
                                        text: paid_amount,
                                        style: TextStyles.textStyle62,
                                      ),
                                ConstantText(
                                  text: "₹ ${payableAMt.toStringAsFixed(2)}",
                                  style: TextStyles.textStyle66,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h1p * 1.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            isOverdue
                                ? const ConstantText(
                                    text: interest_constant,
                                    style: TextStyles.textStyle62,
                                  )
                                : Container(),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: GestureDetector(
                              onTap: () {
                                isOverdue
                                    ? Navigator.pushNamed(
                                        context, overdueDetails)
                                    : getIt<TransactionManager>()
                                        .changePaidInvoice(fullDetails);

                                Navigator.pushNamed(
                                    context, paidInvoiceDetails);
                              },
                              child: Container(
                                width: 300,
                                height: 40,
                                child: Center(
                                    child: ConstantText(
                                  text: view_details,
                                  style: TextStyles.textStyle195,
                                )),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colours.pumpkin,
                                ),
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
