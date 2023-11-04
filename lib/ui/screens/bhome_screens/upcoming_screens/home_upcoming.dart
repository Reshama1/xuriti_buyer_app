import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:xuriti/models/core/invoice_model.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/method_constant.dart';
import 'package:xuriti/util/common/string_constants.dart';
import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../routes/router.dart';
import '../../../theme/constants.dart';

class HomeUpcoming extends StatefulWidget {
  final String companyName;
  final Invoice? fullDetails;

  final String payableAmount;
  HomeUpcoming({
    required this.fullDetails,
    required this.companyName,
    required this.payableAmount,
  });

  @override
  State<HomeUpcoming> createState() => _HomeUpcomingState();
}

class _HomeUpcomingState extends State<HomeUpcoming> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;
      double w10p = maxWidth * 0.1;

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
                      color: widget.fullDetails?.invoiceType == "IN"
                          ? Colours.offWhite
                          : Color(0xfffcdcb4),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
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
                                      assetPath: ImageAssetpathConstant
                                          .arrowCircleRight,
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
                          SizedBox(
                            width: 10.0,
                          ),
                          widget.fullDetails?.invoiceType == "IN"
                              ? RichText(
                                  textAlign: TextAlign.start,
                                  maxLines: 10,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: context.tr(
                                              (widget.fullDetails?.discount !=
                                                      0)
                                                  ? discount_constant
                                                  : interest_constant),
                                          style: TextStyles.textStyle62),
                                      TextSpan(
                                        text: (widget.fullDetails?.discount !=
                                                0)
                                            ? "\n" +
                                                (widget.fullDetails?.discount
                                                        .getDoubleValue()
                                                        .toString()
                                                        .setCurrencyFormatter() ??
                                                    "")
                                            : "\n" +
                                                (widget.fullDetails?.interest
                                                        .getDoubleValue()
                                                        .toString()
                                                        .setCurrencyFormatter() ??
                                                    ""),
                                        style:
                                            (widget.fullDetails?.discount == 0)
                                                ? TextStyles.textStyle142
                                                : TextStyles.textStyle143,
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              widget.fullDetails?.invoiceType == "IN"
                                  ? ConstantText(
                                      text:
                                          getDueSinceAndOverDueTextForInvoices(
                                              invoiceDate: widget.fullDetails
                                                      ?.invoiceDate ??
                                                  "",
                                              invoiceDueDate: widget.fullDetails
                                                      ?.invoiceDueDate ??
                                                  ""),
                                      style: TextStyles.textStyle57,
                                    )
                                  : Container(),
                              ConstantText(
                                text:
                                    "${widget.fullDetails?.outstandingAmount ?? "0"}"
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
                          color:
                              widget.fullDetails?.invoiceType?.toLowerCase() ==
                                      "in"
                                  ? Colours.offWhite
                                  : Color(0xfffcdcb4),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
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
                              SizedBox(
                                width: 10.0,
                              ),
                              widget.fullDetails?.invoiceType == "IN"
                                  ? RichText(
                                      textAlign: TextAlign.start,
                                      maxLines: 10,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: context.tr((widget
                                                          .fullDetails
                                                          ?.discount !=
                                                      0)
                                                  ? discount_constant
                                                  : interest_constant),
                                              style: TextStyles.textStyle62),
                                          TextSpan(
                                            text: (widget.fullDetails
                                                        ?.discount !=
                                                    0)
                                                ? "\n" +
                                                    (widget.fullDetails
                                                            ?.discount
                                                            .getDoubleValue()
                                                            .toString()
                                                            .setCurrencyFormatter() ??
                                                        "")
                                                : "\n" +
                                                    (widget.fullDetails
                                                            ?.interest
                                                            .getDoubleValue()
                                                            .toString()
                                                            .setCurrencyFormatter() ??
                                                        ""),
                                            style:
                                                (widget.fullDetails?.discount ==
                                                        0)
                                                    ? TextStyles.textStyle142
                                                    : TextStyles.textStyle143,
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(
                                width: 10.0,
                              ),
                              // Flexible(
                              //   child: Column(
                              //     children: [
                              //       widget.fullDetails?.invoiceType == "IN"
                              //           ? widget.fullDetails?.discount != 0
                              //               ? Column(
                              //                   children: [
                              //                     // Padding(
                              //                     //     padding: EdgeInsets.fromLTRB(
                              //                     //         70, 20, 0, 0)),
                              //                     ConstantText(
                              //                       text: "Discount",
                              //                       style: TextStyles.textStyle62,
                              //                     ),
                              //                     ConstantText(
                              //                       text:
                              //                           "${widget.fullDetails?.discount?.toStringAsFixed(2)}",
                              //                       style: TextStyles.textStyle143,
                              //                     ),
                              //                   ],
                              //                 )
                              //               : Column(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.start,
                              //                   children: [
                              //                     ConstantText(
                              //                       text: "Interest",
                              //                       style: TextStyles.textStyle62,
                              //                     ),
                              //                     ConstantText(
                              //                       text:
                              //                           "${widget.fullDetails?.interest ?? 0.0}"
                              //                               .setCurrencyFormatter(),
                              //                       style: TextStyles.textStyle142,
                              //                     ),
                              //                   ],
                              //                 )
                              //           : Container(),
                              //     ],
                              //   ),
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  widget.fullDetails?.invoiceType == "IN"
                                      ? ConstantText(
                                          text:
                                              getDueSinceAndOverDueTextForInvoices(
                                                  invoiceDate: widget
                                                          .fullDetails
                                                          ?.invoiceDate ??
                                                      "",
                                                  invoiceDueDate: widget
                                                          .fullDetails
                                                          ?.invoiceDueDate ??
                                                      ""),
                                          style: TextStyles.textStyle57,
                                        )
                                      : Container(),
                                  ConstantText(
                                    text:
                                        "${widget.fullDetails?.outstandingAmount ?? "0"}"
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
                              SizedBox(
                                height: 4,
                              ),
                              ConstantText(
                                text: invoice_date,
                                style: TextStyles.textStyle62,
                              ),
                              ConstantText(
                                text: (widget.fullDetails?.invoiceDate ?? "")
                                    .getDateInRequiredFormat(
                                        requiredFormat: "dd-MMM-yyyy")
                                    ?.parseDateIn(
                                        requiredFormat: "dd-MMM-yyyy"),
                                style: TextStyles.textStyle63,
                              ),
                              // ConstantText(
                              // text:
                              //   widget.companyName,
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
                                text: due_date,
                                style: TextStyles.textStyle62,
                              ),
                              ConstantText(
                                text: (widget.fullDetails?.invoiceDueDate ?? "")
                                    .getDateInRequiredFormat(
                                        requiredFormat: "dd-MMM-yyyy")
                                    ?.parseDateIn(
                                        requiredFormat: "dd-MMM-yyyy"),
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
                                    text:
                                        "${widget.fullDetails?.outstandingAmount ?? "0"}"
                                            .setCurrencyFormatter(),
                                    style: TextStyles.textStyle65,
                                  )
                                  //    ConstantText(
                                  // text:"Asian Paints",style: TextStyles.textStyle34,),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ConstantText(
                                    text: payable_amount,
                                    style: TextStyles.textStyle62,
                                  ),
                                  ConstantText(
                                    text: ((widget.fullDetails
                                                        ?.outstandingAmount ??
                                                    0.0)
                                                .getDoubleValue() +
                                            (widget.fullDetails?.interest ??
                                                    0.0)
                                                .getDoubleValue() -
                                            (widget.fullDetails?.discount ??
                                                    0.0)
                                                .getDoubleValue())
                                        .abs()
                                        .toString()
                                        .setCurrencyFormatter(),
                                    style: TextStyles.textStyle66,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, upcomingDetails,
                                      arguments: widget.fullDetails?.sId ?? "");
                                },
                                child: Container(
                                  // width: 300,
                                  // width: 300,
                                  height: 40,
                                  // height: h1p * 8,
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
                ],
              )),
        ),
      );
    });
  }
}
