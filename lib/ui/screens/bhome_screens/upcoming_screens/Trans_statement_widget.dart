import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:intl/intl.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/string_constants.dart';
import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../theme/constants.dart';
import '../../reports_screens/transactional_statement_screen/Inv_transaction.dart';

class transStatementWidget extends StatefulWidget {
  final List invtrns;
  final String seller;
  final String invcDate;
  final String transType;
  final String transAmount;
  final String transDate;
  final String amountCleared;
  final String interest;
  final String discount;
  final String remarks;
  // TransactionInvoice invoice;

  // Invoice currentInvoice;
  transStatementWidget({
    required this.invtrns,
    required this.seller,
    required this.invcDate,
    required this.transType,
    required this.transAmount,
    required this.transDate,
    required this.amountCleared,
    required this.interest,
    required this.discount,
    required this.remarks,
    // required this.invoice,

    // required this.currentInvoice,
  });

  @override
  State<transStatementWidget> createState() => _transStatementWidgetState();
}

class _transStatementWidgetState extends State<transStatementWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime id = DateTime.parse(widget.transDate); //invoice date
    String invDate = DateFormat("dd-MMM-yyyy").format(id);
    String amount = widget.transAmount.getDoubleValue().toStringAsFixed(2);

    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;
      // double h1p = maxHeight * 0.01;
      // double h10p = maxHeight * 0.1;
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
                      color: Color(0xfffcdcb4),
                      //     ?
                      //     :
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AutoSizeText(
                                    widget.transType,
                                    style: TextStyles.textStyle6,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  ImageFromAssetPath<Widget>(
                                          assetPath: ImageAssetpathConstant
                                              .arrowCircleRight)
                                      .imageWidget,
                                ],
                              ),
                              ConstantText(
                                text: widget.transType,
                                style: TextStyles.companyName,
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: ConstantText(
                              text: "₹ ",
                              style: TextStyles.textStyle58,
                            ),
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
                          // color: widget.fullDetails.invoiceType == "IN"
                          //     ? Colours.offWhite
                          //     : Color(0xfffcdcb4),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ConstantText(
                                        text: widget.transType,
                                        style: TextStyles.textStyle6,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      ImageFromAssetPath<Widget>(
                                              assetPath: ImageAssetpathConstant
                                                  .arrowRight)
                                          .imageWidget,
                                    ],
                                  ),
                                  ConstantText(
                                    text: widget.transType,
                                    style: TextStyles.companyName,
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: ConstantText(
                                  text: "₹ $amount",
                                  style: TextStyles.textStyle58,
                                ),
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
                                text: invDate.toString(),
                                style: TextStyles.textStyle63,
                              ),
                              // ConstantText(
                              // text:
                              //   widget.companyName,
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
                            children: [],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: GestureDetector(
                                onTap: () {
                                  InvTransactions(
                                    invtr: [widget.invtrns],
                                    invcDate: '${widget.invcDate}',
                                    invoiceNo: '${widget.interest}',
                                    seller: '${widget.seller}',
                                  );
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
    });
  }
}
