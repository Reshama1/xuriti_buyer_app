import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/ui/screens/starting_screens/company_list.dart';
import 'package:xuriti/util/Extensions.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class InvTransactions extends StatefulWidget {
  final List invtr;
  final String invcDate;
  final String invoiceNo;
  final String seller;
  // String transAmount;
  // String transDate;
  // String amountCleared;
  // String interest;
  // String discount;
  // String remarks;
  // TransactionInvoice invoice;

  // Invoice currentInvoice;
  InvTransactions({
    required this.invtr,
    required this.invcDate,
    required this.invoiceNo,
    required this.seller,
    // required this.transAmount,
    // required this.transDate,
    // required this.amountCleared,
    // required this.interest,
    // required this.discount,
    // required this.remarks,
    // required this.invoice,

    // required this.currentInvoice,
  });

  @override
  State<InvTransactions> createState() => _InvTransactionsState(
        this.invtr,
        this.invcDate,
        this.invoiceNo,
        this.seller,
        // this.transAmount,
        // this.transDate,
        // this.amountCleared,
        // this.interest,
        // this.discount,
        // this.remarks
      );
}

class _InvTransactionsState extends State<InvTransactions> {
  List invtr = [];
  String invcDate = '';
  String invoiceNo = '';
  String seller = '';
  // String transAmount = '';
  // String transDate = '';
  // String amountCleared = '';
  // String interest = '';
  // String discount = '';
  // String remarks = '';
  String discnt = '';
  String intrst = '';
  String trmt = '';
  String clrAmt = '';
  String klt =
      'bxbvxhvdg gst interest discount gfsdghdf mkgnjkf983495 bjdf7348';

  TransactionManager transactionManager = Get.put(TransactionManager());

  int currentIndex = 0;
  _InvTransactionsState(
    this.invtr,
    this.invcDate,
    this.invoiceNo,
    this.seller,
    // this.transAmount,
    // this.transDate,
    // this.amountCleared,
    // this.interest,
    // this.discount,
    // this.remarks
  );

  @override
  Widget build(BuildContext context) {
    List transLenght = invtr[0];

    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;

      double w10p = maxWidth * 0.1;

      return Scaffold(
        backgroundColor: Colours.black,
        body: ProgressHUD(
          child: Builder(
            builder: (context) {
              return Column(children: [
                Container(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 9,
                        right: 7,
                        top: 70,
                      ),

                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      child: Container(
                        // height: h10p * 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Row(
                            //   children: [
                            //     Icon(
                            //       Icons.arrow_back,
                            //       color: Colors.white,
                            //     )
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  // width: w10p * 1.2,
                                  // height: h10p * 0.3,
                                  child: ImageFromAssetPath<Widget>(
                                          assetPath:
                                              ImageAssetpathConstant.xuriti1)
                                      .imageWidget,
                                ),

                                // const ConstantText(
                                // text:
                                //   "Level 2",
                                //   style: TextStyle(color: Colours.white),
                                // )
                                GestureDetector(
                                    onTap: () {
                                      //  progress!.show();
                                      // context.showLoader();
                                      Get.offAll(CompanyList());
                                      //progress.dismiss();
                                      // context.hideLoader();
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
                                    ))
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
                                      color: Color.fromARGB(255, 228, 131, 20),
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
                                        text: '$invoiceNo',
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
                                        text: '$seller',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                  // Column(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   children: [
                                  //     ConstantText(
                                  // text:
                                  //       'Invoice Date',
                                  //       style: TextStyle(
                                  //         color: Color.fromARGB(
                                  //             255, 250, 250, 250),
                                  //         fontSize: 16,
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       height: 7,
                                  //     ),
                                  //     ConstantText(
                                  // text:
                                  //       ' $invDate',
                                  //       style: TextStyle(
                                  //         color: Color.fromARGB(
                                  //             255, 248, 248, 248),
                                  //         fontSize: 12,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
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
                                    //left: 6,
                                    right: 10,
                                    // top: 3,
                                  ),
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,

                                      // scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: transLenght.length,
                                      itemBuilder: (context, index) {
                                        // print(
                                        //     'invtr lengh ${transLenght.length}');
                                        // List trns = transLenght[index];

                                        final trType = transLenght[index]
                                            ['transaction_type'];

                                        // final trAmount =
                                        //     transLenght[index]['amount'];

                                        // double trammt = trAmount.toDouble();

                                        final trAmount =
                                            transLenght[index]['amount'];

                                        // MoneyFormatter fmf =
                                        //     MoneyFormatter(amount: trammt);
                                        //
                                        // MoneyFormatterOutput trmt = fmf.output;
                                        // String trmt =
                                        //     double.parse(trAmount as String)
                                        //         .toStringAsFixed(2)
                                        //         .toString()
                                        //         .replaceAllMapped(
                                        //             reg, mathFunc);
                                        // this.trmt = trmt;
                                        print(
                                            'trAmount type ${trAmount.runtimeType}');

                                        // String trmt =
                                        //     double.parse(trAmount as String)
                                        //         .toStringAsFixed(2)
                                        //         .toString()
                                        //         .replaceAllMapped(
                                        //             reg, mathFunc);
                                        //   final trmt =
                                        //       double.parse(trAmount.toString())
                                        //           .toStringAsFixed(2);
                                        //   this.trmt = trmt;
                                        // } else {
                                        //   String tramnt = trAmount.toString();
                                        //   String trmt = tramnt.replaceAllMapped(
                                        //       reg, mathFunc);
                                        //   this.trmt = trmt;
                                        // }
                                        // } else {
                                        //   String trmt = trAmount
                                        //       .replaceAllMapped(reg, mathFunc);
                                        //   this.trmt = trmt;
                                        // }

                                        // String trmt =
                                        //     double.parse(trAmount as String)
                                        //         .toStringAsFixed(2)
                                        //         .toString()
                                        //         .replaceAllMapped(
                                        //             reg, mathFunc);

                                        final trDate = transLenght[index]
                                                ['transaction_date'] ??
                                            '';
                                        DateTime trdt = DateTime.parse(
                                            trDate); //invoice date

                                        String transdt =
                                            DateFormat("dd-MMM-yyyy")
                                                .format(trdt);
                                        final trRemark =
                                            transLenght[index]['remark'];
                                        final remarks = [trRemark];
                                        String getNewLineString() {
                                          StringBuffer sb = new StringBuffer();
                                          for (String line in remarks) {
                                            sb.write(line + "\n");
                                          }
                                          return sb.toString();
                                        }

                                        final trinterest = transLenght[index]
                                                ['interest'] ??
                                            '';
                                        if (trinterest == 0.0 ||
                                            trinterest == 0) {
                                          intrst = '';
                                        } else {
                                          // String strint = trinterest.toString();
                                          // double dblintr =
                                          //     strint.getDoubleValue();
                                          // MoneyFormatter fmf =
                                          //     MoneyFormatter(amount: dblintr);
                                          //
                                          // MoneyFormatterOutput intrmf =
                                          //     fmf.output;
                                          // final nonint = intrmf.nonSymbol;

                                          // String intrst = nonint.toString();
                                          this.intrst = trinterest
                                              .toString()
                                              .getDoubleValue()
                                              .toString()
                                              .setCurrencyFormatter();
                                        }

                                        // MoneyFormatter discount =
                                        //     MoneyFormatter(amount: trdisc);

                                        // MoneyFormatterOutput discnt =
                                        //     discount.output;

                                        // if (trdisc is double) {
                                        //   // final trDiscount = trdisc.toString();
                                        //   final discnt =
                                        //       double.parse(trdisc.toString())
                                        //           .toStringAsFixed(2);
                                        //   this.discnt = discnt;
                                        // }
                                        //  else {
                                        final trdisc = transLenght[index]
                                                ['discount'] ??
                                            '';

                                        if (trdisc is double) {
                                          // final trDiscount = trdisc.toString();
                                          final discnt = trdisc
                                              .getDoubleValue()
                                              .toStringAsFixed(2);
                                          this.discnt = discnt;
                                        } else {
                                          if (trdisc == 0.0) {
                                            this.discnt = '';
                                          } else {
                                            String discnt1 = trdisc.toString();
                                            String discnt =
                                                discnt1.replaceAllMapped(
                                                    reg, mathFunc);
                                            this.discnt = discnt;
                                          }
                                        }

                                        // else {
                                        //   String discnt1 = trdisc.toString();
                                        //   String discnt = discnt1
                                        //       .replaceAllMapped(reg, mathFunc);
                                        //   this.discnt = discnt;
                                        // }

                                        // MoneyFormatter amtcleared =
                                        //     MoneyFormatter(amount: amtclr);
                                        //
                                        // MoneyFormatterOutput clrAmt =
                                        //     amtcleared.output;
                                        // String clrAmt =
                                        //     double.parse(amtCleared as String)
                                        //         .toStringAsFixed(2)
                                        //         .toString()
                                        //         .replaceAllMapped(
                                        //             reg, mathFunc);
                                        // this.clrAmt = clrAmt;
                                        print(
                                            'trAmount type ${trAmount.runtimeType}');

                                        // if (amtCleared is double) {
                                        //   final clrAmt = double.parse(
                                        //           amtCleared.toString())
                                        //       .toStringAsFixed(2);
                                        //   this.clrAmt = clrAmt;
                                        // } else {
                                        //   String clramt1 =
                                        //       amtCleared.toString();
                                        //   String clrAmt = clramt1
                                        //       .replaceAllMapped(reg, mathFunc);
                                        //   this.clrAmt = clrAmt;
                                        // }

                                        return SizedBox(
                                          height: maxHeight * 0.28,
                                          child: Card(
                                              shadowColor: Color.fromARGB(
                                                  255, 245, 175, 45),
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
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ConstantText(
                                                          text:
                                                              transaction_type,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        ConstantText(
                                                          text: "$trType",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 15),
                                                        ConstantText(
                                                          text:
                                                              transaction_amount,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        ConstantText(
                                                          text: "${trmt}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 15),
                                                        ConstantText(
                                                          text:
                                                              transaction_date,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        ConstantText(
                                                          text: "$transdt",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 15),
                                                        ConstantText(
                                                          text: amount_cleared,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        ConstantText(
                                                          text: "${clrAmt}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 6),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: w10p * 1.85,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ConstantText(
                                                          text:
                                                              interest_constant,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        ConstantText(
                                                          text: "$intrst",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 15),
                                                        ConstantText(
                                                          text:
                                                              discount_constant,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        ConstantText(
                                                          text: "${discnt}",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 15),
                                                        ConstantText(
                                                          text: remark,
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        // Flexible(
                                                        //   child:
                                                        ConstantText(
                                                          text:
                                                              getNewLineString(),
                                                          maxLines: 4,
                                                          style: TextStyle(
                                                              // leadingDistribution:
                                                              //     TextLeadingDistribution
                                                              //         .values
                                                              //         .last,

                                                              // fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),

                                                        // Expanded(
                                                        //     child: SizedBox()),

                                                        ConstantText(
                                                          text: "",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        ConstantText(
                                                          text: "",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        ConstantText(
                                                          text: "",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        ConstantText(
                                                          text: "",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // SizedBox(
                                                    //   width: w10p * 0.2,
                                                    // )
                                                  ],
                                                ),
                                              )),
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ],
                        )))
              ]);
            },
          ),
        ),

        // child: screens[currentIndex],
      );
    });
  }
}
