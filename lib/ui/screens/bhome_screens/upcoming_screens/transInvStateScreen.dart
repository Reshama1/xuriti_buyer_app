import 'package:flutter/material.dart';

import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/string_constants.dart';

import '../../../../util/common/text_constant_widget.dart';
import '../../../theme/constants.dart';
import '../../reports_screens/transactional_statement_screen/Inv_transaction.dart';

class TransInv extends StatefulWidget {
  final List invTransaction;
  final String companyName;
  final String amount;
  final String invoiceDate;
  final String invoiceNumber;

  TransInv({
    required this.invTransaction,
    required this.companyName,
    required this.amount,
    required this.invoiceDate,
    required this.invoiceNumber,
  });

  @override
  State<TransInv> createState() => _TransInvState();
}

class _TransInvState extends State<TransInv> {
  @override
  Widget build(BuildContext context) {
    final company12 = [widget.companyName];

    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;

      double w10p = maxWidth * 0.1;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: w10p * .5, vertical: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InvTransactions(
                        invtr: [widget.invTransaction],
                        invcDate: '${widget.invoiceDate}',
                        invoiceNo: '${widget.invoiceNumber}',
                        seller: '${widget.companyName}',
                      )),
            );
          },
          child: Card(
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Color.fromARGB(255, 245, 233, 219),
                  color: Colours.offWhite),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstantText(
                        text: widget.invoiceNumber,
                        style: TextStyles.textStyle6,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      // SizedBox(
                      //   width: maxWidth * 0.3,
                      //   height: maxHeight * 0.05,
                      //   child:
                      Container(
                        width: maxWidth * 0.55,
                        child: ConstantText(
                          text: getNewLineString(company12),
                          maxLines: 2,
                          style: TextStyles.textStyle00,
                        ),
                      ),

                      // ),

                      // SizedBox(
                      //   width: 6,
                      // ),
                      // ImageFromAssetPath<Widget>(assetPath:
                      //     "assets/images/home_images/arrow-circle-right.svg"),
                    ],
                  ),

                  // SizedBox(
                  //   width: 10,
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstantText(
                        text: invoice_date,
                        style: TextStyles.textStyle6,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      ConstantText(
                        text: widget.invoiceDate
                            .getDateInRequiredFormat(
                                requiredFormat: "dd-MMM-yyyy")
                            ?.parseDateIn(requiredFormat: "dd-MMM-yyyy"),
                        maxLines: 2,
                        style: TextStyles.textStyle00,
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   width: 5,
                  // )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
