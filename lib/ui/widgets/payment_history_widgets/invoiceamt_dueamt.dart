import 'package:flutter/material.dart';
import 'package:xuriti/util/common/string_constants.dart';

import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class InvoiceamtWidget extends StatelessWidget {
  final String heading1;
  final String heading2;
  const InvoiceamtWidget({required this.heading1, required this.heading2});

  @override
  Widget build(BuildContext context) {
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
                      text: payable_amount,
                      style: TextStyles.textStyle62,
                    ),
                    ConstantText(
                      text: "₹ $heading1",
                      style: TextStyles.textStyle66,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const ConstantText(
                      text: payment_date,
                      style: TextStyles.textStyle62,
                    ),
                    ConstantText(
                      text: heading2,
                      style: TextStyles.textStyle66,
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
