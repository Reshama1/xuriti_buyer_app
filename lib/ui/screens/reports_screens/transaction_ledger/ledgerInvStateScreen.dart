import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:xuriti/models/core/invoice_model.dart';
import 'package:xuriti/models/core/transactional_model.dart';
import 'package:xuriti/ui/screens/reports_screens/transaction_ledger/transactional_ledger.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/string_constants.dart';

import '../../../../util/common/text_constant_widget.dart';
import '../../../theme/constants.dart';

class LedgerInv extends StatefulWidget {
  final String invoiceID;
  final String account;
  final String createdAt;
  final String transactionType;
  final String invoiceDate;

  final String accountType;
  final String? invoiceId;
  final String balance;
  final String? credit;
  final String? debit;

  final String? recordType;
  final String? counterParty;

  final dynamic transactionAmount;
  // Invoice currentInvoice;
  LedgerInv({
    required this.accountType,
    required this.balance,
    required this.credit,
    required this.debit,
    required this.invoiceID,
    required this.invoiceDate,
    required this.recordType,
    required this.counterParty,
    required this.account,
    required this.createdAt,
    required this.transactionAmount,
    required this.transactionType,
    this.invoiceId,
    // required this.currentInvoice,
  });

  @override
  State<LedgerInv> createState() => _LedgerInvState();
}

class _LedgerInvState extends State<LedgerInv> {
  Transaction? transac;
  Invoice? invoices;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;

      double w10p = maxWidth * 0.1;
      return ExpandableNotifier(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w10p * .5, vertical: 10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TransactionalLedger(
                          account: widget.account,
                          accountType: widget.accountType,
                          balance: widget.balance,
                          credit: widget.credit,
                          debit: widget.debit,
                          counterParty: widget.counterParty,
                          createdAt: widget.createdAt,
                          invoiceID: widget.invoiceID,
                          invoiceDate: widget.invoiceDate,
                          recordType: widget.recordType.toString(),
                          transactionType: widget.transactionType,
                          transactionAmount: widget.transactionAmount,
                        )),
              );
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colours.offWhite),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AutoSizeText(
                                widget.invoiceID,
                                style: TextStyles.textStyle6,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 100.0,
                            height: 30.0,
                            child: AutoSizeText(
                              widget.counterParty ?? "",
                              maxLines: 1,
                              style: TextStyles.companyName,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: w10p * 1.5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          ConstantText(
                            text: transaction_date,
                            style: TextStyles.textStyle62,
                          ),
                          ConstantText(
                            text: (widget.createdAt)
                                .getDateInRequiredFormat(
                                    requiredFormat: "dd-MMM-yyyy")
                                ?.parseDateIn(requiredFormat: "dd-MMM-yyyy"),
                            style: TextStyles.textStyle63,
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }
}
