import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/string_constants.dart';
import '../../../new modules/common_widget.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class CompanyDetailsWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final String companyName;
  final String image;
  final String companyAddress;
  final String state;
  final String gstNo;
  final String creditLimit;
  final String balanceCredit;

  const CompanyDetailsWidget({
    required this.maxWidth,
    required this.maxHeight,
    required this.image,
    required this.companyName,
    required this.companyAddress,
    required this.state,
    required this.gstNo,
    required this.creditLimit,
    required this.balanceCredit,
  });

  @override
  Widget build(BuildContext context) {
    double h1p = maxHeight * 0.01;
    double h10p = maxHeight * 0.1;
    double w10p = maxWidth * 0.1;

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            width: maxWidth - 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colours.wolfGrey, width: 1)),
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: h10p * .1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: w10p * .2,
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            ImageFromAssetPath<Widget>(assetPath: image)
                                .provider,
                      ),
                      SizedBox(
                        width: w10p * .5,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              companyName,
                              style: TextStyles.textStyle8,
                            ),
                            // AutoSizeText(
                            //   "Building name",
                            //   overflow: TextOverflow.ellipsis,
                            //   style: TextStyles.textStyle69,
                            // ),
                            AutoSizeText(
                              companyAddress,
                              style: TextStyles.textStyle69,
                              maxLines: 2,
                            ),
                            AutoSizeText(
                              state,
                              style: TextStyles.textStyle69,
                            ),
                            AutoSizeText(
                              gstNo,
                              style: TextStyles.textStyle69,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: h1p * 2,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colours.successIcon,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConstantText(
                                text: used_credit,
                                style: TextStyles.textStyle71,
                              ),
                              ConstantText(
                                text:
                                    "${(creditLimit).getDoubleValue() - (balanceCredit).getDoubleValue()}"
                                        .setCurrencyFormatter(),
                                style: TextStyles.textStyle72,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ConstantText(
                                text:
                                    // "Available Credit Limit",
                                    credit_limit,
                                style: TextStyles.textStyle71,
                              ),
                              ConstantText(
                                text: "${balanceCredit.getDoubleValue()}"
                                    .setCurrencyFormatter(),
                                style: TextStyles.textStyle72,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ])),
      ),
    );
  }
}
