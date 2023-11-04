import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/invoice_model.dart';
import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/string_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../theme/constants.dart';
import '../../../widgets/pending_invoices_widget/paid_invoice_widget.dart';

class PaidInvoices extends StatefulWidget {
  const PaidInvoices({Key? key}) : super(key: key);

  @override
  State<PaidInvoices> createState() => _PInvoicesState();
}

class _PInvoicesState extends State<PaidInvoices> {
  TransactionManager transactionManager = Get.put(TransactionManager());

  ScrollController controllerForScroll = new ScrollController();

  String? id;
  @override
  void initState() {
    transactionManager.selectedSeller.listen((p0) {
      if (transactionManager.invoiceScreenIndex.value == 1 &&
          transactionManager.landingScreenIndex == 1) {
        transactionManager.fetchInvoicesList(
            invoiceStatus: "Paid", resetFlag: true);
      }
    });
    controllerForScroll.addListener(() async {
      if (controllerForScroll.offset >
          controllerForScroll.position.maxScrollExtent - 100) {
        transactionManager.fetchInvoicesList(invoiceStatus: 'Paid');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;

      double w10p = maxWidth * 0.1;
      return Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Container(
              width: maxWidth,
              height: maxHeight,
              decoration: const BoxDecoration(
                  color: Colours.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                  )),
              child: Obx(() {
                List<Invoice?>? paidInvoiceList = transactionManager
                    .invoices?.value?.invoice
                    ?.where((element) =>
                        element.invoiceType?.toLowerCase() == "in" &&
                        element.invoiceStatus?.toLowerCase() == "paid")
                    .toList();
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: h1p * 1, horizontal: w10p * .8),
                        child: ConstantText(
                            text: paid_invoices, style: TextStyles.textStyle38),
                      ),
                    ),
                    (paidInvoiceList?.isEmpty ?? true)
                        ? Column(
                            children: [
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
                                        ((transactionManager.invoices?.value
                                                        ?.invoice?.isEmpty ??
                                                    true) &&
                                                transactionManager
                                                        .fetchingInvoices
                                                        .value ==
                                                    true)
                                            ? Expanded(
                                                child: ConstantText(
                                                  text:
                                                      please_wait_while_we_connect_you_with_your_sellers,
                                                  style: TextStyles.textStyle34,
                                                ),
                                              )
                                            : ConstantText(
                                                text: invoice_not_found,
                                                style: TextStyles.textStyle34,
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
                          )
                        : Expanded(
                            child: CustomScrollView(
                              controller: controllerForScroll,
                              slivers: [
                                SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                  ((context, index) {
                                    Buyer? buyr =
                                        paidInvoiceList?[index]?.seller;
                                    return PaidInvoiceWidget(
                                      invoiceAmount: paidInvoiceList?[index]
                                              ?.invoiceAmount ??
                                          "",
                                      gst: paidInvoiceList?[index]
                                              ?.billDetails
                                              ?.gstSummary
                                              ?.totalTax ??
                                          "",
                                      fullDetails: paidInvoiceList?[index],
                                      maxWidth: maxWidth,
                                      maxHeight: maxHeight,
                                      amount: paidInvoiceList?[index]
                                          ?.outstandingAmount
                                          .toString(),
                                      savedAmount: "500",
                                      invoiceDate: paidInvoiceList?[index]
                                              ?.invoiceDate ??
                                          "",
                                      dueDate:
                                          paidInvoiceList?[index]?.updatedAt ??
                                              "",
                                      companyName: buyr?.companyName ?? "",
                                      isOverdue: false,
                                    );
                                  }),
                                  childCount: paidInvoiceList?.length ?? 0,
                                )),
                                SliverToBoxAdapter(
                                  child: transactionManager
                                          .hasMoreItemsToScroll.value
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ConstantText(
                                          text: no_more_invoices,
                                          textAlign: TextAlign.center,
                                        ),
                                ),
                              ],
                            ),
                          ),
                  ],
                );
              })));
    });
  }
}
