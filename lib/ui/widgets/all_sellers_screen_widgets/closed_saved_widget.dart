import 'package:flutter/material.dart';

import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class ClosedSavedWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final String amount;
  final String day;
  final String SAmount;
  final String companyName;

  const ClosedSavedWidget(
      {required this.maxWidth,
      required this.maxHeight,
      required this.amount,
      required this.day,
      required this.SAmount,
      required this.companyName});

  @override
  Widget build(BuildContext context) {
    double w10p = maxWidth * 0.1;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Card(
        elevation: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colours.offWhite,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: w10p * .2),
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
                        style: TextStyles.textStyle93,
                      ),
                    ],
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstantText(
                              text: "You Saved", style: TextStyles.textStyle60),
                          ConstantText(
                              text: "₹ $SAmount",
                              style: TextStyles.textStyle68),
                        ],
                      ),
                      SizedBox(
                        width: w10p * .5,
                      ),
                      ConstantText(
                        text: "₹ $amount ",
                        style: TextStyles.textStyle58,
                      ),
                      SizedBox(
                        width: w10p * .2,
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
