import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:xuriti/models/core/payment_history_model.dart';
import 'package:xuriti/ui/screens/invoices_screens/payment_history/all_payment_history_invoices.dart';
import 'package:xuriti/util/Extensions.dart';
import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/string_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../theme/constants.dart';
import '../../../widgets/payment_history_widgets/leading.dart';
import '../../../widgets/profile/profile_widget.dart';

class AllPaymentDetails extends StatefulWidget {
  final Finalresult? paymentHistory;

  AllPaymentDetails({
    this.paymentHistory,
  });

  @override
  State<AllPaymentDetails> createState() => _AllPaymentDetailsState();
}

class _AllPaymentDetailsState extends State<AllPaymentDetails> {
  GlobalKey<ScaffoldState> ssk = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return SafeArea(
        child: Scaffold(
            key: ssk,
            backgroundColor: Colours.black,
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              toolbarHeight: h10p * 2.2,
              flexibleSpace: ProfileWidget(pskey: ssk),
            ),
            body: Container(
                width: maxWidth,
                height: maxHeight,
                decoration: const BoxDecoration(
                    color: Colours.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(left: 13, top: 8, right: 13),
                  child: ListView(children: [
                    LeadingWidget(
                      heading: back,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: w10p * .25,
                      ),
                      child: Container(
                        width: maxWidth - 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(color: Colours.wolfGrey, width: 1)),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: h10p * .1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: w10p * .2,
                                ),
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: ImageFromAssetPath<Widget>(
                                          assetPath: ImageAssetpathConstant
                                              .companyVector)
                                      .provider,
                                ),
                                SizedBox(
                                  width: w10p * .5,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        "${widget.paymentHistory?.sellerName ?? ''}",
                                        style: TextStyles.textStyle8,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colours.successIcon,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: h1p * 1),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: ConstantText(
                                            text: transaction_ID,
                                            style: TextStyles.textStyle62,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: ConstantText(
                                            text: widget.paymentHistory
                                                    ?.transactionId ??
                                                "",
                                            style: TextStyles.textStyle56,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: ConstantText(
                                            text: payment_status,
                                            style: TextStyles.textStyle62,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: ConstantText(
                                            text:
                                                "${widget.paymentHistory?.status ?? ""}",
                                            style: TextStyles.textStyle56,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstantText(
                                      text: order_ID,
                                      style: TextStyles.textStyle62,
                                    ),
                                    ConstantText(
                                      text:
                                          "${widget.paymentHistory?.orderId ?? ''}",
                                      style: TextStyles.textStyle140,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const ConstantText(
                                      text: payment_date,
                                      style: TextStyles.textStyle62,
                                    ),
                                    ConstantText(
                                      text: (widget.paymentHistory
                                                  ?.paymentDate ??
                                              "")
                                          .getDateInRequiredFormat(
                                              requiredFormat: "dd-MMM-yyyy")
                                          ?.parseDateIn(
                                              requiredFormat: "dd-MMM-yyyy"),
                                      style: TextStyles.textStyle140,
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: widget.paymentHistory?.invoices
                              ?.map((e) => PaymentHistInvoices(
                                    invoice: e,
                                    w10p: w10p,
                                  ))
                              .toList() ??
                          [],
                    ),
                    SizedBox(
                      height: h10p * .2,
                    )
                  ]),
                ))),
      );
    });
  }
}
