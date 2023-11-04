import 'package:flutter/material.dart';
import 'package:xuriti/models/core/payment_history_model.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/text_constant_widget.dart';

import '../../../../util/common/string_constants.dart';
import '../../../theme/constants.dart';

class PaymentHistInvoices extends StatefulWidget {
  final Invoices? invoice;
  final double? w10p;
  PaymentHistInvoices({
    required this.w10p,
    required this.invoice,
  });

  @override
  State<PaymentHistInvoices> createState() => _PaymentHistInvoicesState();
}

class _PaymentHistInvoicesState extends State<PaymentHistInvoices> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.w10p! * .2,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colours.pumpkin),
          color: Color.fromARGB(255, 255, 248, 238),
        ),
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.all(5.0),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.w10p! * .2,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstantText(
                  text: invoice_ID,
                  style: TextStyles.textStyle62,
                ),
                ConstantText(
                  text: "${widget.invoice?.invoiceNumber}",
                  style: TextStyles.textStyle140,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const ConstantText(
                      text: settled_amount,
                      style: TextStyles.textStyle62,
                    ),
                    ConstantText(
                      text: "${widget.invoice?.settledAmount}"
                          .setCurrencyFormatter(),
                      style: TextStyles.textStyle140,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const ConstantText(
                      text: amount_paid,
                      style: TextStyles.textStyle62,
                    ),
                    ConstantText(
                      text: "${widget.invoice?.amountPaid}"
                          .setCurrencyFormatter(),
                      style: TextStyles.textStyle140,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  // //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ConstantText(
                      text: interest_constant,
                      style: TextStyles.textStyle62,
                    ),
                    ConstantText(
                      text:
                          '${widget.invoice?.interest}'.setCurrencyFormatter(),
                      style: TextStyles.textStyle140,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const ConstantText(
                      text: discount_constant,
                      style: TextStyles.textStyle62,
                    ),
                    ConstantText(
                      text:
                          "${widget.invoice?.discount}".setCurrencyFormatter(),
                      style: TextStyles.textStyle140,
                    )
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
