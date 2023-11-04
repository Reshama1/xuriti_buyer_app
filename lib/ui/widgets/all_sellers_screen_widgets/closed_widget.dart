import 'package:flutter/material.dart';

import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class ClosedWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final String amount;
  final String day;
  final String companyName;
  const ClosedWidget(
      {required this.maxWidth,
      required this.maxHeight,
      required this.amount,
      required this.day,
      required this.companyName});

  @override
  Widget build(BuildContext context) {
    double h1p = maxHeight * 0.01;

    double w10p = maxWidth * 0.1;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: h1p * .2, horizontal: w10p * .2),
      child: Card(
        elevation: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colours.offWhite,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                                  assetPath: ImageAssetpathConstant.arrowRight)
                              .imageWidget,
                        ],
                      ),
                      ConstantText(
                        text: companyName,
                        style: TextStyles.textStyle59,
                      ),
                    ],
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ConstantText(
                        text: "₹ $amount ",
                        style: TextStyles.textStyle58,
                      ),
                      ConstantText(
                        text: day,
                        style: TextStyles.textStyle94,
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
