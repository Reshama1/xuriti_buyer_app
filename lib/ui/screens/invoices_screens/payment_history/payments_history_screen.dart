import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import '../../../../logic/view_models/trans_history_manager.dart';
import '../../../../logic/view_models/transaction_manager.dart';
import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/string_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../theme/constants.dart';
import 'all_payment_history.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  ScrollController controllerForScroll = new ScrollController();

  TransHistoryManager transHistoryManager = Get.put(TransHistoryManager());
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  TransactionManager transactionManager = Get.put(TransactionManager());
  @override
  void initState() {
    // setState(() {
    transactionManager.selectedSeller.listen((p0) {
      transHistoryManager.getPaymentHistory(
          companyListViewModel.selectedCompany.value?.companyId ?? "");
    });

    controllerForScroll.addListener(() async {
      if (controllerForScroll.offset >
          controllerForScroll.position.maxScrollExtent - 100) {
        await transHistoryManager.getPaymentHistory(
            companyListViewModel.selectedCompany.value?.companyId ?? "");
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
      return OrientationBuilder(builder: (context, orientation) {
        bool isPortrait = orientation == Orientation.portrait;
        return Scaffold(
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          body: ProgressHUD(
            child: Builder(builder: (context) {
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: isPortrait ? 15 : 0),
                  child: Container(
                      width: maxWidth,
                      height: maxHeight,
                      decoration: const BoxDecoration(
                          color: Colours.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26),
                            topRight: Radius.circular(26),
                          )),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: h1p * 1, horizontal: w10p * .8),
                              child: const ConstantText(
                                  text: payment_history,
                                  style: TextStyles.textStyle38),
                            ),
                          ),
                          Obx(() {
                            return (transHistoryManager.paymentHistory.value
                                        ?.finalresult?.isEmpty ??
                                    true)
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: w10p * .6,
                                            vertical: h1p * 1),
                                        child: Container(
                                            width: maxWidth,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
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
                                                // SizedBox(
                                                //   width: w10p * 0.2,
                                                // ),
                                                ((transHistoryManager
                                                                .paymentHistory
                                                                .value
                                                                ?.finalresult
                                                                ?.isEmpty ??
                                                            true) &&
                                                        transHistoryManager
                                                                .fetchingPaymentHistory
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
                                                        text:
                                                            no_payment_history_records_found,
                                                        style: TextStyles
                                                            .textStyle34,
                                                      ),
                                              ]),
                                            )),
                                      ),
                                      SizedBox(
                                        height: h1p * 8,
                                      ),
                                      Center(
                                        child: ImageFromAssetPath<Widget>(
                                                assetPath:
                                                    ImageAssetpathConstant
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
                                            delegate:
                                                SliverChildBuilderDelegate(
                                          ((context, index) {
                                            return AllPaymentHistory(
                                              maxWidth: maxWidth,
                                              maxHeight: maxHeight,
                                              fullDetails: transHistoryManager
                                                  .paymentHistory
                                                  .value
                                                  ?.finalresult?[index],
                                            );
                                          }),
                                          childCount: transHistoryManager
                                                  .paymentHistory
                                                  .value
                                                  ?.finalresult
                                                  ?.length ??
                                              0,
                                        )),
                                        SliverToBoxAdapter(
                                          child: transHistoryManager
                                                  .hasMoreItemsToScroll.value
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : ConstantText(
                                                  text: no_more_records,
                                                  textAlign: TextAlign.center,
                                                ),
                                        ),
                                      ],
                                    ),
                                  );
                          }),
                        ],
                      )));
            }),
          ),
        );
      });
    });
  }
}
