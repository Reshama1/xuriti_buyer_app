import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:xuriti/ui/routes/router.dart';

import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../theme/constants.dart';

class AllPendingInvoiceWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;

  final String amount;
  final String savedAmount;
  final String dayCount;
  final String companyName;
  AllPendingInvoiceWidget(
      {required this.maxWidth,
      required this.maxHeight,
      required this.amount,
      required this.savedAmount,
      required this.dayCount,
      required this.companyName});

  @override
  Widget build(BuildContext context) {
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
                            Row(
                              children: [
                                const ConstantText(
                                  text: "#4321 ",
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
                            ConstantText(
                              text: "You Save",
                              style: TextStyles.textStyle102,
                            ),
                            ConstantText(
                              text: "₹ $savedAmount",
                              style: TextStyles.textStyle100,
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ConstantText(
                              text: "$dayCount days left",
                              style: TextStyles.textStyle57,
                            ),
                            ConstantText(
                              text: "₹ $amount",
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
                                Row(
                                  children: [
                                    const ConstantText(
                                      text: "#4321",
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
                                ConstantText(
                                  text: "You Save",
                                  style: TextStyles.textStyle102,
                                ),
                                ConstantText(
                                  text: "₹ $savedAmount",
                                  style: TextStyles.textStyle100,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ConstantText(
                                  text: "$dayCount days left",
                                  style: TextStyles.textStyle57,
                                ),
                                ConstantText(
                                  text: "₹ $amount",
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
                          children: const [
                            SizedBox(
                              height: 4,
                            ),
                            ConstantText(
                              text: "Invoice Date",
                              style: TextStyles.textStyle62,
                            ),
                            ConstantText(
                              text: "12.Jun.2022",
                              style: TextStyles.textStyle63,
                            ),
                            ConstantText(
                              text: "Nippon Paint",
                              style: TextStyles.companyName,
                            ),
                          ],
                        ),
                        ImageFromAssetPath<Widget>(
                                assetPath: ImageAssetpathConstant.arrowSvg)
                            .imageWidget,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            SizedBox(
                              height: 4,
                            ),
                            ConstantText(
                              text: "Due Date",
                              style: TextStyles.textStyle62,
                            ),
                            ConstantText(
                              text: "28.Jun.2022",
                              style: TextStyles.textStyle63,
                            ),
                            ConstantText(
                              text: "Nippon Paint",
                              style: TextStyles.companyName,
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
                              children: const [
                                SizedBox(
                                  height: 4,
                                ),
                                ConstantText(
                                  text: "Invoice Amount",
                                  style: TextStyles.textStyle62,
                                ),
                                ConstantText(
                                  text: "₹ 12,345",
                                  style: TextStyles.textStyle65,
                                )
                                //    Text("Asian Paints",style: TextStyles.textStyle34,),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                SizedBox(
                                  height: 4,
                                ),
                                ConstantText(
                                  text: "Pay Now",
                                  style: TextStyles.textStyle62,
                                ),
                                ConstantText(
                                  text: "₹ 12,345",
                                  style: TextStyles.textStyle66,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstantText(
                                  text: "You Save",
                                  style: TextStyles.textStyle102,
                                ),
                                ConstantText(
                                  text: "₹ $savedAmount",
                                  style: TextStyles.textStyle100,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, overdueDetails);
                              },
                              child: Container(
                                width: 300,
                                height: 40,
                                child: Center(
                                    child: ConstantText(
                                  text: "View Details",
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
