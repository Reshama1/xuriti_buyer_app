import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:xuriti/models/core/invoice_model.dart';
import 'package:xuriti/ui/theme/constants.dart';
import 'package:xuriti/ui/widgets/appbar/app_bar_widget.dart';
import 'package:xuriti/util/Extensions.dart';
import '../../../../../new modules/common_widget.dart';
import '../../../../../new modules/image_assetpath_constants.dart';
import '../../../../../util/common/string_constants.dart';
import '../../../../../util/common/text_constant_widget.dart';

class ReportsAllSellers extends StatefulWidget {
  final Invoice? invoice;
  const ReportsAllSellers({required this.invoice});

  @override
  State<ReportsAllSellers> createState() => _ReportsAllSellersState();
}

class _ReportsAllSellersState extends State<ReportsAllSellers> {
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: Material(child: LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;

      return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              toolbarHeight: h10p * .9,
              flexibleSpace: AppbarWidget()),
          body: Column(children: [
            SizedBox(
              height: h10p * .3,
            ),
            Expanded(
                child: Container(
                    width: maxWidth,
                    decoration: const BoxDecoration(
                        color: Colours.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26),
                        )),
                    child: widget.invoice != null
                        ? ListView(children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 13),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    ImageFromAssetPath<Widget>(
                                            assetPath: ImageAssetpathConstant
                                                .arrowLeft)
                                        .imageWidget,
                                    SizedBox(
                                      width: w10p * .3,
                                    ),
                                    const ConstantText(
                                      text: back,
                                      style: TextStyles.textStyle41,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ReportsAllSellersWidget(
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                              image: ImageAssetpathConstant.companyVector,
                              invoice: widget.invoice,
                            ),
                            SizedBox(height: h1p * 2),
                          ])
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: h1p * 4, horizontal: w10p * .3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const ConstantText(
                                        text: all_sellers,
                                        style: TextStyles.textStyle38),
                                    // Row(
                                    //   children: [
                                    //     ConstantText(
                                    // text:
                                    //       "Filters     ",
                                    //       style: TextStyles.textStyle38,
                                    //     ),
                                    //     ImageFromAssetPath<Widget>(assetPath: "assets/images/filterRight.svg"),
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w10p * .6, vertical: h1p * 1),
                                child: Container(
                                    width: maxWidth,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colours.offWhite),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: h1p * 4,
                                          horizontal: w10p * .3),
                                      child: Row(children: [
                                        ImageFromAssetPath<Widget>(
                                                assetPath:
                                                    ImageAssetpathConstant
                                                        .logo1)
                                            .imageWidget,
                                        SizedBox(
                                          width: w10p * 0.5,
                                        ),
                                        Expanded(
                                          child: ConstantText(
                                            text:
                                                please_wait_while_we_connect_you_with_your_sellers,
                                            style: TextStyles.textStyle34,
                                          ),
                                        ),
                                      ]),
                                    )),
                              ),
                              SizedBox(
                                height: h1p * 8,
                              ),
                              Center(
                                child: ImageFromAssetPath<Widget>(
                                        assetPath: ImageAssetpathConstant
                                            .onboardImage3)
                                    .imageWidget,
                              ),
                            ],
                          )))
          ]));
    })));
  }
}

class ReportsAllSellersWidget extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;

  final String image;

  final Invoice? invoice;

  const ReportsAllSellersWidget({
    required this.maxWidth,
    required this.maxHeight,
    required this.image,
    required this.invoice,
  });

  @override
  State<ReportsAllSellersWidget> createState() =>
      _ReportsAllSellersWidgetState();
}

class _ReportsAllSellersWidgetState extends State<ReportsAllSellersWidget> {
  @override
  Widget build(BuildContext context) {
    double h1p = widget.maxHeight * 0.01;
    double h10p = widget.maxHeight * 0.1;
    double w10p = widget.maxWidth * 0.1;

    double cl = (widget.invoice?.buyer?.creditLimit?.isNotEmpty ?? false)
        ? widget.invoice?.buyer?.creditLimit.getDoubleValue() ?? 0.0
        : 0;

    double bc = (widget.invoice?.buyer?.availCredit?.isNotEmpty ?? false)
        ? widget.invoice?.buyer?.availCredit.getDoubleValue() ?? 0.0
        : 0;

    // double usedCredit = cl - bc;
    // double usedCreditAmt = double.parse(source)
    // usedCredit;

    // MoneyFormatter usdcrdt = MoneyFormatter(amount: usedCredit);
    //
    // MoneyFormatterOutput usedcredt = usdcrdt.output;
    //
    // // String balcedCredit = bc.toStringAsFixed(2);
    //
    // MoneyFormatter balCred = MoneyFormatter(amount: bc);
    //
    // MoneyFormatterOutput balancedCrdt = balCred.output;

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            width: widget.maxWidth - 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colours.wolfGrey, width: 1)),
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
                        radius: 50,
                        backgroundImage:
                            ImageFromAssetPath<Widget>(assetPath: widget.image)
                                .provider,
                      ),
                      SizedBox(
                        width: w10p * .5,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              widget.invoice?.seller?.companyName ?? "",
                              style: TextStyles.textStyle8,
                            ),
                            // AutoSizeConstantText(
                            // text:
                            //   "Building name",
                            //   overflow: TextOverflow.ellipsis,
                            //   style: TextStyles.textStyle69,
                            // ),
                            AutoSizeText(
                              widget.invoice?.seller?.address ?? "",
                              style: TextStyles.textStyle69,
                              maxLines: 2,
                            ),
                            AutoSizeText(
                              widget.invoice?.seller?.state ?? "",
                              style: TextStyles.textStyle69,
                            ),
                            AutoSizeText(
                              widget.invoice?.seller?.gstin ?? "",
                              style: TextStyles.textStyle69,
                            ),
                            // Row(
                            //   children: [
                            //     AutoSizeConstantText(
                            // text:
                            //       "Credit Limit : ",
                            //       style: TextStyles.textStyle70,
                            //     ),
                            //     AutoSizeConstantText(
                            // text:
                            //       "₹ $creditLimitAMt",
                            //       style: TextStyles.textStyle70,
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: h1p * 2,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colours.successIcon,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConstantText(
                                text: used_credit,
                                style: TextStyles.textStyle71,
                              ),
                              ConstantText(
                                text: "₹ ${cl - bc}",
                                style: TextStyles.textStyle72,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ConstantText(
                                text: available_credit_limit,
                                // "Credit Limit",
                                style: TextStyles.textStyle71,
                              ),
                              ConstantText(
                                text: "₹ ${bc}",
                                style: TextStyles.textStyle72,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ])),
      ),
    );
  }
}
