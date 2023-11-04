import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xuriti/logic/view_models/company_details_manager.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/seller_info_model.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/string_constants.dart';

import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentSummaryScreen extends StatefulWidget {
  const PaymentSummaryScreen({
    super.key,
    required this.maxWidth,
    required this.maxheight,
    required this.w10p,
    required this.h30p,
    required this.isPartPaymentChecked,
    required this.h1p,
  });

  final double maxWidth;
  final double maxheight;
  final double h30p;
  final double w10p;
  final double h1p;
  final String isPartPaymentChecked;

  @override
  State<PaymentSummaryScreen> createState() => _PaymentSummaryScreenState();
}

class _PaymentSummaryScreenState extends State<PaymentSummaryScreen> {
  CompanyDetailsManager companyDetailsManager =
      Get.put(CompanyDetailsManager());

  List<InvoiceDetail>? invoiceDetails;

  @override
  void initState() {
    invoiceDetails = widget.isPartPaymentChecked.isNotEmpty
        ? companyDetailsManager.sellerInfoForPartPay?.value?.invoiceDetails
        : companyDetailsManager.sellerInfo?.value?.invoiceDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.isPartPaymentChecked.isEmpty &&
            (getIt<TransactionManager>().selectedSeller.value == null ||
                getIt<TransactionManager>()
                        .selectedSeller
                        .value
                        ?.anchorName
                        ?.toLowerCase() ==
                    context.tr(all_sellers)))
        ? Container(
            width: widget.maxWidth,
            height: widget.maxWidth,
            decoration: const BoxDecoration(
                color: Colours.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                )),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 15, vertical: widget.h1p * 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ConstantText(
                        text: invoice_not_found, style: TextStyles.textStyle38),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.w10p * 0.1, vertical: widget.h1p),
                  child: Container(
                    width: widget.maxWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colours.offWhite),
                    child: Padding(
                        padding: EdgeInsets.symmetric(),
                        child: Row(children: [
                          ImageFromAssetPath<Widget>(
                                  assetPath: ImageAssetpathConstant.logo1)
                              .imageWidget,
                          SizedBox(
                            width: widget.w10p * 0.1,
                          ),
                          Expanded(
                            child: ConstantText(
                              text:
                                  please_wait_while_we_connect_you_with_your_sellers,
                              style: TextStyles.textStyle34,
                            ),
                          ),
                        ])),
                  )),
              SizedBox(
                height: widget.h1p,
              ),
              Center(
                child: ImageFromAssetPath<Widget>(
                        assetPath: ImageAssetpathConstant.onboardImage3)
                    .imageWidget,
              ),
            ]))
        : ((getIt<TransactionManager>().selectedSeller.value?.Anchor_id != null)
            ? Container(
                width: widget.maxWidth,
                height: widget.h30p,
                decoration: const BoxDecoration(
                    color: Colours.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    )),
                // child: Column(children: [
                // Padding(
                // padding: const EdgeInsets.only(
                //   left: 15,
                //   right: 15,
                //   top: 45,
                // ),
                // child: Flexible(
                //   child: SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(),
                  // padding: const EdgeInsets.only(
                  //   //left: 6,
                  //   right: 10,
                  //   // top: 3,
                  // ),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: invoiceDetails?.length ?? 0,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: widget.maxheight * 0.23,
                          child: Card(
                            shadowColor: Color.fromARGB(255, 245, 175, 45),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 7,
                                right: 7,
                                top: 12,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ConstantText(
                                        text: invoice_no,
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                      ConstantText(
                                        text:
                                            "${invoiceDetails?[index].invoiceNumber ?? ""}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 15),
                                      ConstantText(
                                        text: discount_constant,
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                      ConstantText(
                                        text:
                                            "${invoiceDetails?[index].discount ?? 0.0}"
                                                .setCurrencyFormatter(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 15),
                                      ConstantText(
                                        text: gst_settled,
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                      ConstantText(
                                        text:
                                            "${invoiceDetails?[index].gst ?? 0.0}"
                                                .setCurrencyFormatter(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 15),
                                      ConstantText(
                                        text: amount_cleared,
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                      ConstantText(
                                        text:
                                            "${invoiceDetails?[index].amountCleared ?? 0.0}"
                                                .setCurrencyFormatter(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 2),
                                    ],
                                  ),
                                  SizedBox(
                                    width: widget.w10p * 1,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ConstantText(
                                        text: outstanding_amount,
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                      ConstantText(
                                        text:
                                            "${invoiceDetails?[index].outstandingAmount ?? 0.0}"
                                                .setCurrencyFormatter(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 15),
                                      ConstantText(
                                        text: interest_constant,
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                      ConstantText(
                                        text:
                                            "${invoiceDetails?[index].interest ?? 0.0}"
                                                .setCurrencyFormatter(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 15),
                                      Container(
                                        width: 70,
                                        height: 45,
                                        child: ConstantText(
                                          text: remaining_outstanding_amount,
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                      ConstantText(
                                        text:
                                            "${invoiceDetails?[index].remainingOutstanding ?? 0.0}"
                                                .setCurrencyFormatter(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
            : Container());
  }
}
