import 'package:flutter/material.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class LeadingWidget extends StatelessWidget {
  final String heading;

  const LeadingWidget({required this.heading});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;

      double w10p = maxWidth * 0.1;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 13),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              ImageFromAssetPath<Widget>(
                      assetPath: ImageAssetpathConstant.arrowLeft)
                  .imageWidget,
              SizedBox(
                width: w10p * .3,
              ),
              ConstantText(
                text: heading,
                style: TextStyles.textStyle41,
              ),
            ],
          ),
        ),
      );
    });
  }
}
