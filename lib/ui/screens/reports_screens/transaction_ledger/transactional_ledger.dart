import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:xuriti/models/core/transactional_model.dart';
import 'package:xuriti/ui/screens/starting_screens/company_list.dart';
import 'package:xuriti/ui/theme/constants.dart';
import 'package:xuriti/util/Extensions.dart';
import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/string_constants.dart';
import '../../../../util/common/text_constant_widget.dart';

class TransactionalLedger extends StatefulWidget {
  final String? account;
  final String? accountType;
  final String? invoiceID;
  final String? createdAt;
  final String? invoiceDate;
  final String? balance;
  final String? debit;
  final String? credit;
  final String? recordType;
  final String? counterParty;
  final String? transactionType;
  final String? transactionAmount;

  TransactionalLedger(
      {required this.account,
      required this.accountType,
      required this.balance,
      required this.debit,
      required this.invoiceDate,
      required this.credit,
      required this.counterParty,
      required this.createdAt,
      required this.invoiceID,
      required this.recordType,
      required this.transactionType,
      required this.transactionAmount});

  @override
  State<TransactionalLedger> createState() => _TransactionalLedgerState();
}

class _TransactionalLedgerState extends State<TransactionalLedger> {
  String balAmt = '';
  List<dynamic> txn = [];

  TransactionModel? transactionModel;
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';
  dynamic typeConv(record, double w10p) {
    print(record);
    switch (record) {
      case "BPAYMENT":
        {
          record = ConstantText(
            text: buyer_payment,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }

        break;
      case "GST Amount":
        {
          record = ConstantText(
            text: gst_amount,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }

        break;
      case "DISCOUNT":
        {
          record = ConstantText(
            text: discount_constant,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;
      case "CREDIT NOTE":
        {
          record = ConstantText(
            text: credit_note,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;
      case "INTEREST":
        {
          record = ConstantText(
            text: interest_constant,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;
      case "SALESINVOICE":
        {
          record = ConstantText(
            text: sales_invoices,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;
      case "INTEREST PAID":
        {
          record = ConstantText(
            text: interest_paid,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;

      case "Interest Applied":
        {
          record = ConstantText(
            text: interest_applied,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;
      case "Interest Paid":
        {
          record = ConstantText(
            text: interest_paid,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;
      case "INTEREST APPLIED":
        {
          record = ConstantText(
            text: interest_applied,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;

      default:
        {
          record = SizedBox(
            width: w10p * 3.3,
            child: ConstantText(
              text: "$record",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          );
        }
        break;
    }
    return record as dynamic;
  }

  @override
  Widget build(BuildContext context) {
    String transacAmount =
        (widget.transactionAmount as String).getDoubleValue().toString();

    String balanceLeft = widget.balance == "null"
        ? ""
        : (widget.balance as String).getDoubleValue().toString();

    return LayoutBuilder(
      builder: (context, constraints) {
        double maxHeight = constraints.maxHeight;
        double maxWidth = constraints.maxWidth;

        double h10p = maxHeight * 0.1;
        double w10p = maxWidth * 0.1;
        return Scaffold(
          backgroundColor: Colours.black,
          body: ProgressHUD(
            child: Builder(
              builder: (context) {
                return Column(
                  children: [
                    Container(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 19,
                            right: 7,
                            top: 70,
                          ),

                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          child: Container(
                            height: h10p * 2.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: w10p * 1.2,
                                      height: h10p * 0.3,
                                      child: ImageFromAssetPath<Widget>(
                                              assetPath: ImageAssetpathConstant
                                                  .xuriti1)
                                          .imageWidget,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.offAll(CompanyList());
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                width: 1, color: Colors.white)
                                            //more than 50% of width makes circle
                                            ),
                                        child: Icon(
                                          Icons.business_center,
                                          color: Colours.tangerine,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ConstantText(
                                      text: transaction_statement,
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 228, 131, 20),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 45,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ConstantText(
                                            text: widget.invoiceID.toString(),
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          ConstantText(
                                            text: widget.account.toString(),
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: Container(
                        width: maxWidth,
                        // height: maxHeight,
                        // height: h10p * 3,
                        decoration: const BoxDecoration(
                            color: Colours.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(26),
                              topRight: Radius.circular(26),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18, top: 8),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: ImageFromAssetPath<Widget>(
                                            assetPath: ImageAssetpathConstant
                                                .arrowLeft)
                                        .imageWidget,
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 6,
                                    right: 10,
                                    top: 3,
                                  ),
                                  child: ListView(
                                    children: [
                                      Card(
                                        shadowColor:
                                            Color.fromARGB(255, 245, 175, 45),
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 12,
                                            right: 14,
                                            top: 12,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ConstantText(
                                                    text: transaction_type,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  typeConv(
                                                      widget.recordType, w10p),
                                                  SizedBox(height: 15),
                                                  ConstantText(
                                                    text: transaction_amount,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  ConstantText(
                                                    text: "${transacAmount}"
                                                        .setCurrencyFormatter(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 15),
                                                  ConstantText(
                                                    text: transaction_date,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  ConstantText(
                                                    text: (widget.createdAt ??
                                                            "")
                                                        .getDateInRequiredFormat(
                                                            requiredFormat:
                                                                "dd-MMM-yyyy")
                                                        ?.parseDateIn(
                                                            requiredFormat:
                                                                "dd-MMM-yyyy"),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 15),
                                                  ConstantText(
                                                    text: credit,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  ConstantText(
                                                    text: (widget.credit ??
                                                            "0.0")
                                                        .getDoubleValue()
                                                        .toString()
                                                        .setCurrencyFormatter(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 6),
                                                ],
                                              ),
                                              SizedBox(
                                                width: w10p * 2.9,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ConstantText(
                                                    text: debit_credit,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  ConstantText(
                                                    text: (widget.transactionType
                                                                    .toString() ==
                                                                "" ||
                                                            widget.transactionType
                                                                    .toString() ==
                                                                "null")
                                                        ? ""
                                                        : widget.transactionType
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 15),
                                                  ConstantText(
                                                    text: counter_party,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100.0,
                                                    child: AutoSizeText(
                                                      (widget.counterParty
                                                                      .toString() ==
                                                                  "" ||
                                                              widget.counterParty
                                                                      .toString() ==
                                                                  "null")
                                                          ? ""
                                                          : "${widget.counterParty.toString()}",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  ConstantText(
                                                    text: debit,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  ConstantText(
                                                    text: "$debit"
                                                        .setCurrencyFormatter(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 6),
                                                  ConstantText(
                                                    text: balance,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  ConstantText(
                                                    text: "$balanceLeft"
                                                        .setCurrencyFormatter(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 6),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
