import 'package:flutter/material.dart';
import 'package:xuriti/util/common/string_constants.dart';

import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class InterestCharged extends StatelessWidget {
  final String amount;
  final String interest;

  const InterestCharged({required this.amount, required this.interest});

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
                      text: invoice_amount,
                      style: TextStyles.textStyle62,
                    ),
                    ConstantText(
                      text: "₹ $amount",
                      style: TextStyles.textStyle65,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ConstantText(
                      text: interest_charged,
                      style: TextStyles.textStyle62,
                    ),
                    ConstantText(
                      text: "₹ $interest",
                      style: TextStyles.textStyle101,
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
