import 'package:flutter/material.dart';
import 'package:xuriti/util/common/string_constants.dart';

import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class InvoiceSavedAmtWidget extends StatelessWidget {
  final String heading1;
  final String heading2;
  final String heading3;
  final bool boolValue;
  const InvoiceSavedAmtWidget(
      {required this.heading1,
      required this.heading2,
      required this.heading3,
      required this.boolValue});

  @override
  Widget build(BuildContext context) {
    bool isRed = boolValue;
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstantText(
                      text: invoice_amount,
                      style: TextStyles.textStyle62,
                    ),
                    ConstantText(
                      text: "₹ $heading1",
                      style: TextStyles.textStyle65,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ConstantText(
                      text: heading2,
                      style: TextStyles.textStyle62,
                    ),
                    ConstantText(
                      text: heading3,
                      style: isRed
                          ? TextStyles.textStyle101
                          : TextStyles.textStyle77,
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
