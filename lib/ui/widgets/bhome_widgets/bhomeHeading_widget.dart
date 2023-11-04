import 'package:flutter/cupertino.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class SubHeadingWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;

  final String heading1;

  const SubHeadingWidget({
    required this.maxWidth,
    required this.maxHeight,
    required this.heading1,
  });

  @override
  Widget build(BuildContext context) {
    double h10p = maxHeight * 0.1;
    double w10p = maxWidth * 0.1;
    return Container(
      width: maxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colours.pumpkin,
      ),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: w10p * 0.2, vertical: h10p * .24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageFromAssetPath<Widget>(
                        assetPath: ImageAssetpathConstant.polygonRed)
                    .imageWidget,
                SizedBox(
                  width: w10p * 0.2,
                ),
                ConstantText(
                  text: heading1,
                  style: TextStyles.subHeading,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
