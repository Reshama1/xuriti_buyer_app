import 'package:flutter/material.dart';

import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class UpComingWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;

  final String amount;
  final String dayCount;
  final String companyName;
  const UpComingWidget(
      {required this.maxWidth,
      required this.maxHeight,
      required this.amount,
      required this.dayCount,
      required this.companyName});

  @override
  Widget build(BuildContext context) {
    double h1p = maxHeight * 0.01;

    double w10p = maxWidth * 0.1;
    return Card(
      elevation: 1,
      child: Container(
        // height: h10p * 1.2,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: w10p * .5, vertical: h1p * 1.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageFromAssetPath<Widget>(
                          assetPath: ImageAssetpathConstant.overdueScreens)
                      .imageWidget,
                  ImageFromAssetPath<Widget>(
                          assetPath: ImageAssetpathConstant.overdueFrame)
                      .imageWidget,
                  ConstantText(
                    text: companyName,
                    style: TextStyles.textStyle59,
                  ),
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
                  ImageFromAssetPath<Widget>(
                          assetPath: ImageAssetpathConstant.button)
                      .imageWidget,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
