import 'package:flutter/material.dart';

import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class SavedWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final String heading1;
  final String heading2;
  final String dayCount;
  final String companyName;

  const SavedWidget(
      {required this.maxWidth,
      required this.maxHeight,
      required this.heading1,
      required this.heading2,
      required this.dayCount,
      required this.companyName});

  @override
  Widget build(BuildContext context) {
    double h10p = maxHeight * 0.1;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Card(
        elevation: 1,
        child: Container(
          height: h10p * 3.5,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    const ConstantText(
                      text: "You Save",
                      style: TextStyles.textStyle60,
                    ),
                    ConstantText(
                      text: "₹ $heading1",
                      style: TextStyles.textStyle68,
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
                      text: "₹ $heading2",
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
      ),
    );
  }
}
