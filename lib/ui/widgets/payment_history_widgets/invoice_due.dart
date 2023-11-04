import 'package:flutter/material.dart';
import 'package:xuriti/util/common/string_constants.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class InvoiceDueDateWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final String invoiceDate;
  final String companyName;
  final String dueDate;
  final String companyNameDue;

  const InvoiceDueDateWidget(
      {required this.maxWidth,
      required this.maxHeight,
      required this.invoiceDate,
      required this.companyName,
      required this.dueDate,
      required this.companyNameDue});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;

      double w10p = maxWidth * 0.1;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: w10p * .50),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
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
                      text: invoiceDate,
                      style: TextStyles.textStyle63,
                    ),
                    ConstantText(
                      text: companyName,
                      style: TextStyles.textStyle64,
                    ),
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
                      text: dueDate,
                      style: TextStyles.textStyle63,
                    ),
                    ConstantText(
                      text: companyNameDue,
                      style: TextStyles.textStyle64,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
