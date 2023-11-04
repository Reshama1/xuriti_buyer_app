import 'package:flutter/material.dart';

import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class InvoiceId extends StatelessWidget {
  const InvoiceId({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Container(
          decoration: BoxDecoration(color: Colours.offWhite),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ConstantText(
                      text: "Invoice ID",
                      style: TextStyles.textStyle62,
                    ),
                    ConstantText(
                      text: "#4321",
                      style: TextStyles.textStyle56,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    ConstantText(
                      text: "Invoice Amount",
                      style: TextStyles.textStyle62,
                    ),
                    ConstantText(
                      text: "₹ 12,345",
                      style: TextStyles.textStyle56,
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
