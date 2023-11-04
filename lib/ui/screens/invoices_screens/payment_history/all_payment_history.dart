import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xuriti/logic/view_models/trans_history_manager.dart';
import 'package:xuriti/models/core/payment_history_model.dart';
import 'package:xuriti/ui/screens/invoices_screens/payment_history/all_payment_details.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/string_constants.dart';
import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../theme/constants.dart';

class AllPaymentHistory extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;
  final Finalresult? fullDetails;

  AllPaymentHistory({
    required this.maxWidth,
    required this.maxHeight,
    required this.fullDetails,
  });

  @override
  State<AllPaymentHistory> createState() => _AllPaymentHistoryState();
}

class _AllPaymentHistoryState extends State<AllPaymentHistory> {
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';

  TransHistoryManager transHistoryManager = Get.put(TransHistoryManager());

  @override
  Widget build(BuildContext context) {
    double h1p = widget.maxHeight * 0.01;
    return ExpandableNotifier(
      child: Padding(
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
        child: Expandable(
          collapsed: ExpandableButton(
            child: Card(
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colours.offWhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstantText(
                                  text: widget.fullDetails?.orderId ?? "",
                                  style: TextStyles.textStyle6,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                ImageFromAssetPath<Widget>(
                                  assetPath:
                                      ImageAssetpathConstant.arrowCircleRight,
                                ).imageWidget,
                              ],
                            ),
                            SizedBox(
                              width: 100.0,
                              height: 18.0,
                              child: AutoSizeText(
                                widget.fullDetails?.sellerName ?? "",
                                maxLines: 1,
                                style: TextStyles.companyName,
                              ),
                            ),
                          ]),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          child: Container(
                            height: 12,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: ConstantText(
                                text:
                                    widget.fullDetails?.paymentMode.toString(),
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        ConstantText(
                          text: "${widget.fullDetails?.orderAmount ?? "0.0"}"
                              .setCurrencyFormatter(),
                          style: TextStyles.textStyle58,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          expanded: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10.0,
                ),
              ),
              border: Border.all(
                color: Colours.pumpkin,
              ),
            ),
            child: Column(
              children: [
                ExpandableButton(
                    child: Card(
                        child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colours.offWhite,
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ConstantText(
                                                text: widget
                                                        .fullDetails?.orderId ??
                                                    "",
                                                style: TextStyles.textStyle6,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              ImageFromAssetPath<Widget>(
                                                assetPath:
                                                    ImageAssetpathConstant
                                                        .arrowRight,
                                              ).imageWidget,
                                            ],
                                          ),
                                          SizedBox(
                                            width: 100.0,
                                            height: 18.0,
                                            child: AutoSizeText(
                                              widget.fullDetails?.sellerName ??
                                                  "",
                                              maxLines: 1,
                                              style: TextStyles.companyName,
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 5.0),
                                        child: Container(
                                          height: 12,
                                          width: 55,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Center(
                                            child: ConstantText(
                                              text: widget
                                                  .fullDetails?.paymentMode
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ConstantText(
                                        text:
                                            "${widget.fullDetails?.orderAmount ?? "0.0"}"
                                                .setCurrencyFormatter(),
                                        style: TextStyles.textStyle58,
                                      )
                                    ],
                                  )
                                ])))),
                ExpandableButton(
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colours.offWhite,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Column(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     const ConstantText(
                                //       text: "Transaction Id",
                                //       style: TextStyles.textStyle6,
                                //     ),
                                //     ConstantText(
                                //       text: widget.fullDetails?.transactionId ??
                                //           "",
                                //       style: TextStyles.textStyle6,
                                //     )
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 20.0,
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const ConstantText(
                                          text: payment_date,
                                          style: TextStyles.textStyle6,
                                        ),
                                        ConstantText(
                                          text: widget.fullDetails?.paymentDate
                                              ?.getDateInRequiredFormat(
                                                  requiredFormat: "dd-MM-yyyy")
                                              ?.parseDateIn(
                                                  requiredFormat: "dd-MM-yyyy"),
                                          style: TextStyles.textStyle6,
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        ConstantText(
                                          text: payment_mode,
                                          style: TextStyles.textStyle6,
                                        ),
                                        ConstantText(
                                          text: widget.fullDetails?.paymentMode
                                              .toString(),
                                          style: TextStyles.textStyle6,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const ConstantText(
                                          text: payment_status,
                                          style: TextStyles.textStyle6,
                                        ),
                                        ConstantText(
                                          text: widget.fullDetails?.status
                                              .toString(),
                                          style: TextStyles.textStyle6,
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        ConstantText(
                                          text: transaction_ID,
                                          style: TextStyles.textStyle6,
                                        ),
                                        ConstantText(
                                          text: widget
                                              .fullDetails?.transactionId
                                              .toString(),
                                          style: TextStyles.textStyle6,
                                        )
                                      ],
                                    ),
                                    // Column(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.start,
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.end,
                                    //   children: [
                                    //     const ConstantText(
                                    //       text: "Paid Amount",
                                    //       style: TextStyles.textStyle6,
                                    //       textAlign: TextAlign.right,
                                    //     ),
                                    //     ConstantText(
                                    //       text: widget.fullDetails?.invoices
                                    //           ?.map<double>(
                                    //               (e) => e?.amountPaid ?? 0.0)
                                    //           .toList()
                                    //           .fold(
                                    //               0.0,
                                    //               (double? previousValue,
                                    //                       element) =>
                                    //                   (previousValue != null
                                    //                       ? previousValue
                                    //                       : 0.0) +
                                    //                   (element
                                    //                       .toString()
                                    //                       .getDoubleValue()))
                                    //           .toString()
                                    //           .setCurrencyFormatter(),
                                    //       style: TextStyles.textStyle6,
                                    //     )
                                    //   ],
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllPaymentDetails(
                              paymentHistory: widget.fullDetails,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        // width: 300,

                        height: h1p * 8,
                        child: Center(
                            child: ConstantText(
                          text: view_details,
                          color: Colors.black,
                          style: TextStyles.textStyle195,
                        )),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          // borderRadius: BorderRadius.all(Radius.circular(5)),
                          // color: Colours.pumpkin,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
