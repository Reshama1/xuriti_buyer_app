import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/invoice_model.dart';
import 'package:xuriti/ui/widgets/pending_invoices_widget/pending_invoice_widget.dart';
import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/string_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../theme/constants.dart';

class PInvoices extends StatefulWidget {
  const PInvoices({
    Key? key,
  }) : super(key: key);

  @override
  State<PInvoices> createState() => _PInvoicesState();
}

class _PInvoicesState extends State<PInvoices> {
  TransactionManager transactionManager = Get.put(TransactionManager());

  ScrollController controllerForScroll = new ScrollController();

  String? id;
  @override
  void initState() {
    transactionManager.selectedSeller.listen((p0) {
      if (transactionManager.invoiceScreenIndex == 0 &&
          transactionManager.landingScreenIndex == 1) {
        transactionManager.fetchInvoicesList(
            invoiceStatus: 'Pending', resetFlag: true);
      }
    });
    controllerForScroll.addListener(() async {
      if (controllerForScroll.offset >
          controllerForScroll.position.maxScrollExtent - 100) {
        transactionManager.fetchInvoicesList(invoiceStatus: 'Pending');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxHeight = constraints.maxHeight;
        double maxWidth = constraints.maxWidth;
        double h1p = maxHeight * 0.01;

        double w10p = maxWidth * 0.1;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Container(
            width: maxWidth,
            height: maxHeight,
            decoration: const BoxDecoration(
              color: Colours.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26),
                topRight: Radius.circular(26),
              ),
            ),
            child: Obx(
              () {
                List<Invoice?>? pendingInvoices = transactionManager
                    .invoices?.value?.invoice
                    ?.where((element) =>
                        element.invoiceStatus?.toLowerCase() == "pending" &&
                        element.invoiceType?.toLowerCase() == "in")
                    .toList();

                return Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: h1p * 1, horizontal: w10p * .8),
                        child: const ConstantText(
                            text: pending_invoices,
                            style: TextStyles.textStyle38),
                      ),
                    ),
                    (pendingInvoices?.isEmpty ?? true)
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
                                          vertical: h1p * 3,
                                          horizontal: w10p * .3),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ImageFromAssetPath<Widget>(
                                                    assetPath:
                                                        ImageAssetpathConstant
                                                            .logo1)
                                                .imageWidget,
                                            SizedBox(
                                              width: w10p * 0.5,
                                            ),
                                            ((transactionManager
                                                            .invoices
                                                            ?.value
                                                            ?.invoice
                                                            ?.isEmpty ??
                                                        true) &&
                                                    transactionManager
                                                            .fetchingInvoices
                                                            .value ==
                                                        true)
                                                ? Expanded(
                                                    child: ConstantText(
                                                      text:
                                                          please_wait_while_we_connect_you_with_your_sellers,
                                                      style: TextStyles
                                                          .textStyle34,
                                                    ),
                                                  )
                                                : ConstantText(
                                                    text: invoice_not_found,
                                                    style:
                                                        TextStyles.textStyle34,
                                                  ),
                                          ]),
                                    )),
                              ),
                              SizedBox(
                                height: h1p * 8,
                              ),
                              Center(
                                child: Image.asset(
                                    ImageAssetpathConstant.onboardImage3),
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
                                    return PendingInvoiceWidget(
                                      maxWidth: maxWidth,
                                      maxHeight: maxHeight,
                                      fullDetails: pendingInvoices?[index],
                                    );
                                  }),
                                  childCount: pendingInvoices?.length ?? 0,
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
