import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/new%20modules/Credit_Details/model/Credit_Details.dart';
import 'package:xuriti/ui/screens/reports_screens/transactional_statement_screen/viewmodel/transactionStatementVM.dart';
import 'package:xuriti/ui/screens/starting_screens/company_list.dart';
import 'package:xuriti/util/common/string_constants.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../../logic/view_models/reward_manager.dart';
import '../../../../logic/view_models/transaction_manager.dart';
import '../../../../models/core/reward_model.dart';

import '../../../../models/core/transactional_statement_model.dart';
import '../../../../models/helper/service_locator.dart';
import '../../../../models/services/dio_service.dart';
import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/endPoints_constant.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../theme/constants.dart';
import '../../../widgets/bhome_widgets/bhomeHeading_widget.dart';
import '../../../widgets/bhome_widgets/guide_widget.dart';
import '../transaction_ledger/ledgerInvStateScreen.dart';

class TransactionalStatement extends StatefulWidget {
  const TransactionalStatement({Key? key}) : super(key: key);

  @override
  State<TransactionalStatement> createState() => _TransactionalStatementState();
}

class _TransactionalStatementState extends State<TransactionalStatement> {
  TransactionStatementVM transactionStatementVM =
      Get.put(TransactionStatementVM());
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  RewardManager rewardManager = Get.put(RewardManager());
  Credit_Details_VM credit_details_vm = Get.put(Credit_Details_VM());
  TransactionManager transactionManager = Get.put(TransactionManager());

  @override
  void dispose() {
    super.dispose();
  }

  int currentIndex = 0;

  Remark? remark;

  // final invv
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      transactionStatementVM.transactionLedger();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Scaffold(
          backgroundColor: Colours.black,
          body: ProgressHUD(
              // indicatorWidget: Backlogo(
              //   width: w10p * 2.5,
              //   height: h10p * 2,
              // ),
              child: Builder(builder: (context) {
            String dwnld = transactionalStatementDownloadUrl(
                companyId:
                    companyListViewModel.selectedCompany.value?.companyId ??
                        "");
            //'/ledger/$companyId/transaction-statement/download';

            return Obx(() {
              return Column(mainAxisSize: MainAxisSize.min, children: [
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 12,
                      top: 80,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          return Container(
                            padding: EdgeInsets.all(8.0),
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: context
                                      .tr(total_credit_limit_credit_available),
                                  style: TextStyles.textStyle25(Colors.white),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: getIt<TransactionManager>()
                                                        .selectedSeller
                                                        .value !=
                                                    null &&
                                                getIt<TransactionManager>()
                                                        .selectedSeller
                                                        .value
                                                        ?.anchorName
                                                        ?.toLowerCase() !=
                                                    context.tr(all_sellers) &&
                                                (credit_details_vm
                                                        .creditDetails
                                                        ?.value
                                                        ?.companyDetails
                                                        ?.creditDetails
                                                        ?.where((element) =>
                                                            element
                                                                .anchor_pan ==
                                                            getIt<TransactionManager>()
                                                                .selectedSeller
                                                                .value
                                                                ?.anchor_pan)
                                                        .length !=
                                                    0)
                                            ? ("₹ ${((double.tryParse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == getIt<TransactionManager>().selectedSeller.value?.anchor_pan).first.creditLimit ?? "0")) != null ? double.parse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == getIt<TransactionManager>().selectedSeller.value?.anchor_pan).first.creditLimit ?? "0")) : 0) / 100000).toStringAsFixed(2)} lacs/₹ ${((double.tryParse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == getIt<TransactionManager>().selectedSeller.value?.anchor_pan).first.creditAvailable ?? "0")) != null ? double.parse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == getIt<TransactionManager>().selectedSeller.value?.anchor_pan).first.creditAvailable ?? "0")) : 0) / 100000).toStringAsFixed(2)} lacs")
                                            : "₹ ${((credit_details_vm.creditDetails?.value?.companyDetails?.totalCreditLimit ?? 0) / 100000).toStringAsFixed(2)} lacs/₹ ${((credit_details_vm.creditDetails?.value?.companyDetails?.totalCreditAvailable ?? 0) / 100000).toStringAsFixed(2)} lacs",
                                        style: TextStyles.textStyle354),
                                  ],
                                )),
                          );
                        }),
                        GestureDetector(
                            onTap: () {
                              // context.showLoader();
                              //progress!.show();
                              Get.offAll(CompanyList());
                              // progress.dismiss();
                              // context.hideLoader();
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 1, color: Colors.white)
                                  //more than 50% of width makes circle
                                  ),
                              child: Icon(
                                Icons.business_center,
                                color: Colours.tangerine,
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  )
                ]),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colours.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: transactionStatementVM.transactionStatementData
                                  .value?.transaction.isEmpty ??
                              true
                          ? Column(
                              children: [
                                // SizedBox(
                                //   height: h1p * 0.8,
                                // ),

                                Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: w10p * 0.6,
                                      vertical: h1p * 4,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: ImageFromAssetPath<Widget>(
                                                  assetPath:
                                                      ImageAssetpathConstant
                                                          .arrowLeft)
                                              .imageWidget,
                                        ),
                                        GestureDetector(
                                            onTapDown: (tapDownDetails) {
                                              List<CreditDetails?>?
                                                  sellerListData =
                                                  (Get.put(Credit_Details_VM())
                                                          .creditDetails
                                                          ?.value
                                                          ?.companyDetails
                                                          ?.creditDetails ??
                                                      []);
                                              if (sellerListData.length == 0) {
                                                Fluttertoast.showToast(
                                                    msg: no_sellers_to_filter);
                                                return;
                                              }

                                              if (sellerListData
                                                      .where((element) =>
                                                          element?.anchorName
                                                              ?.toLowerCase() ==
                                                          context
                                                              .tr(all_sellers)
                                                              .toLowerCase())
                                                      .length ==
                                                  0) {
                                                sellerListData.insert(
                                                    0,
                                                    CreditDetails(
                                                        anchorName: context
                                                            .tr(all_sellers)));
                                              }

                                              if (sellerListData.isNotEmpty)
                                                showMenu(
                                                  context: context,
                                                  position:
                                                      RelativeRect.fromLTRB(
                                                    (tapDownDetails
                                                            .globalPosition
                                                            .dx) +
                                                        15,
                                                    (tapDownDetails
                                                            .globalPosition
                                                            .dy) +
                                                        15,
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height -
                                                        (tapDownDetails
                                                            .globalPosition.dy),
                                                  ),
                                                  items: (sellerListData
                                                      .map(
                                                        (sellerObject) =>
                                                            PopupMenuItem(
                                                          child: ConstantText(
                                                              text: context.tr(
                                                                  sellerObject
                                                                          ?.anchorName ??
                                                                      "")),
                                                          onTap: () {
                                                            getIt<TransactionManager>()
                                                                    .selectedSeller
                                                                    .value =
                                                                sellerObject;
                                                            context
                                                                .showLoader();
                                                            transactionStatementVM
                                                                .transactionLedger()
                                                                .then(
                                                                  (value) => context
                                                                      .hideLoader(),
                                                                );
                                                          },
                                                        ),
                                                      )
                                                      .toList()),
                                                );
                                            },
                                            child: Icon(Icons.filter_list))
                                      ],
                                    )),
                                // SizedBox(
                                //   height: h1p * 8,
                                // ),
                                Center(
                                  child: ImageFromAssetPath<Widget>(
                                          assetPath: ImageAssetpathConstant
                                              .onboardImage2)
                                      .imageWidget,
                                ),
                                SizedBox(
                                  height: h1p * 8,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w10p * .6, vertical: h1p * 1),
                                  child: Container(
                                      width: maxWidth,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colours.offWhite),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: h1p * 3,
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
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Center(
                                              child: ConstantText(
                                                text:
                                                    "            ${invoice_not_found}",
                                                style: TextStyles.textStyle34,
                                              ),
                                            ),
                                          ),
                                        ]),
                                      )),
                                ),
                                SizedBox(
                                  height: h1p * 8,
                                ),
                              ],
                            )
                          : CustomScrollView(
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: w10p * 0.6,
                                      vertical: h1p * 1.5,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: ImageFromAssetPath<Widget>(
                                                      assetPath:
                                                          ImageAssetpathConstant
                                                              .arrowLeft)
                                                  .imageWidget,
                                            ),
                                            GestureDetector(
                                              onTapDown: (tapDownDetails) {
                                                List<CreditDetails?>?
                                                    sellerListData =
                                                    (Get.put(Credit_Details_VM())
                                                            .creditDetails
                                                            ?.value
                                                            ?.companyDetails
                                                            ?.creditDetails ??
                                                        []);
                                                if (sellerListData.length ==
                                                    0) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          no_sellers_to_filter);
                                                  return;
                                                }

                                                if (sellerListData
                                                        .where((element) =>
                                                            element?.anchorName
                                                                ?.toLowerCase() ==
                                                            context
                                                                .tr(all_sellers)
                                                                .toLowerCase())
                                                        .length ==
                                                    0) {
                                                  sellerListData.insert(
                                                      0,
                                                      CreditDetails(
                                                          anchorName: context
                                                              .tr(all_sellers)));
                                                }

                                                if (sellerListData.isNotEmpty)
                                                  showMenu(
                                                    context: context,
                                                    position:
                                                        RelativeRect.fromLTRB(
                                                      (tapDownDetails
                                                              .globalPosition
                                                              .dx) +
                                                          15,
                                                      (tapDownDetails
                                                              .globalPosition
                                                              .dy) +
                                                          15,
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height -
                                                          (tapDownDetails
                                                              .globalPosition
                                                              .dy),
                                                    ),
                                                    items: (sellerListData
                                                        .map(
                                                          (sellerObject) =>
                                                              PopupMenuItem(
                                                            child: ConstantText(
                                                                text: sellerObject
                                                                        ?.anchorName ??
                                                                    ""),
                                                            onTap: () {
                                                              getIt<TransactionManager>()
                                                                      .selectedSeller
                                                                      .value =
                                                                  sellerObject;
                                                              context
                                                                  .showLoader();
                                                              transactionStatementVM
                                                                  .transactionLedger()
                                                                  .then(
                                                                    (value) =>
                                                                        context
                                                                            .hideLoader(),
                                                                  );
                                                            },
                                                          ),
                                                        )
                                                        .toList()),
                                                  );
                                              },
                                              child: Container(
                                                height: h10p * 0.5,
                                                padding: EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 0, 0, 0))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                      child: ConstantText(
                                                        text: getIt<TransactionManager>()
                                                                .selectedSeller
                                                                .value
                                                                ?.anchorName ??
                                                            all_sellers,
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 0, 0, 0),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Icon(Icons.filter_list)
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ConstantText(
                                              text: transaction_statement,
                                              style: TextStyles.textStyleUp,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                context.showLoader();

                                                dynamic responseData =
                                                    await DioClient().get(
                                                  dwnld,
                                                );
                                                Future<void>
                                                    _launchUrl() async {
                                                  String url1 =
                                                      responseData['url'];

                                                  Uri uri = Uri.parse(url1);
                                                  if (!await launchUrl(uri,
                                                      mode: LaunchMode
                                                          .externalApplication)) {
                                                    throw Exception(
                                                        'Could not launch $uri');
                                                  }
                                                }

                                                if (responseData != null &&
                                                    responseData['status'] ==
                                                        true) {
                                                  _launchUrl();
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          somethingWentWrongWhileDownloadPdf,
                                                      toastLength:
                                                          Toast.LENGTH_LONG);
                                                }
                                                context.hideLoader();
                                              },
                                              child: Container(
                                                height: h1p * 5.3,
                                                width: w10p * 1.7,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Colors.green)),
                                                child: Icon(
                                                  Icons.download_rounded,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                (transactionStatementVM.transactionStatementData
                                            .value?.transaction.isEmpty ??
                                        true)
                                    ? Container()
                                    : SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                        ((context, index) {
                                          return LedgerInv(
                                            transactionAmount:
                                                (transactionStatementVM
                                                            .transactionStatementData
                                                            .value
                                                            ?.transaction[index]
                                                            .transactionAmount ??
                                                        0.0)
                                                    .toString(),
                                            invoiceID: (transactionStatementVM
                                                        .transactionStatementData
                                                        .value
                                                        ?.transaction[index]
                                                        .invoiceId ??
                                                    "")
                                                .toString(),
                                            account: (transactionStatementVM
                                                        .transactionStatementData
                                                        .value
                                                        ?.transaction[index]
                                                        .account ??
                                                    "")
                                                .toString(),
                                            createdAt: (transactionStatementVM
                                                        .transactionStatementData
                                                        .value
                                                        ?.transaction[index]
                                                        .createdAt ??
                                                    "")
                                                .toString(),
                                            invoiceDate: (transactionStatementVM
                                                        .transactionStatementData
                                                        .value
                                                        ?.transaction[index]
                                                        .invoiceDate ??
                                                    "")
                                                .toString(),
                                            transactionType: (transactionStatementVM
                                                        .transactionStatementData
                                                        .value
                                                        ?.transaction[index]
                                                        .transactionType ??
                                                    "")
                                                .toString(),
                                            accountType: transactionStatementVM
                                                    .transactionStatementData
                                                    .value
                                                    ?.transaction[index]
                                                    .accountType ??
                                                "",
                                            balance: (transactionStatementVM
                                                        .transactionStatementData
                                                        .value
                                                        ?.transaction[index]
                                                        .balance ??
                                                    0.0)
                                                .toString(),
                                            credit: (transactionStatementVM
                                                        .transactionStatementData
                                                        .value
                                                        ?.transaction[index]
                                                        .credit ??
                                                    0.0)
                                                .toString(),
                                            debit: (transactionStatementVM
                                                    .transactionStatementData
                                                    .value
                                                    ?.transaction[index]
                                                    .debit)
                                                .toString(),
                                            counterParty: transactionStatementVM
                                                .transactionStatementData
                                                .value
                                                ?.transaction[index]
                                                .counterParty
                                                .toString(),
                                            recordType: transactionStatementVM
                                                .transactionStatementData
                                                .value
                                                ?.transaction[index]
                                                .recordType
                                                .toString(),

                                            // currentInvoice: invoice[index],
                                          );
                                        }),
                                        childCount: transactionStatementVM
                                                .transactionStatementData
                                                .value
                                                ?.transaction
                                                .length ??
                                            0,
                                      )),
                                SliverPadding(
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                  sliver: SliverToBoxAdapter(
                                      child: GuideWidget(
                                    maxWidth: maxWidth,
                                    maxHeight: maxHeight,
                                  )),
                                ),
                                SliverToBoxAdapter(
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: w10p * .4,
                                            vertical: 18),
                                        child: SubHeadingWidget(
                                          maxHeight: maxHeight,
                                          maxWidth: maxWidth,
                                          heading1: rewards_constant,
                                        ))),
                                SliverToBoxAdapter(
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      height: 140,
                                      width: maxWidth,
                                      child: Swiper(
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Rewards? currentReward = rewardManager
                                              .rewardsDataResponse
                                              .value
                                              ?.data
                                              ?.rewards?[index];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 9.0, vertical: 8),
                                            child: Stack(children: [
                                              Container(
                                                margin: const EdgeInsets.all(2),
                                                width: w10p * 9,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: ImageFromAssetPath<
                                                                    Widget>(
                                                                assetPath: currentReward
                                                                            ?.status ==
                                                                        "CLAIMED"
                                                                    ? ImageAssetpathConstant
                                                                        .completedReward
                                                                    : currentReward?.status ==
                                                                            "UNCLAIMED"
                                                                        ? ImageAssetpathConstant
                                                                            .bgImage1
                                                                        : currentReward?.status ==
                                                                                "LOCKED"
                                                                            ? ImageAssetpathConstant
                                                                                .bgImage2
                                                                            : ImageAssetpathConstant
                                                                                .bgImage2)
                                                            .provider),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            28),
                                                    color: Colours.white,
                                                    // border: Border.all(color: Colours.black,width: 0.5),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Colors.grey,
                                                          spreadRadius: 0.1,
                                                          blurRadius: 1,
                                                          offset: Offset(
                                                            0,
                                                            1,
                                                          )),
                                                      // BoxShadow(color: Colors.grey,spreadRadius: 0.5,blurRadius: 1,
                                                      //     offset: Offset(1,1,))
                                                    ]),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 18),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const ConstantText(
                                                                  text:
                                                                      xuriti_rewards,
                                                                  style: TextStyles
                                                                      .textStyle104),
                                                              ConstantText(
                                                                  text: context.tr(
                                                                          level) +
                                                                      "${currentReward?.level ?? 0}",
                                                                  style: currentReward
                                                                              ?.status ==
                                                                          "CLAIMED"
                                                                      ? TextStyles
                                                                          .textStyle46
                                                                      : TextStyles
                                                                          .textStyle38),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              ConstantText(
                                                                  text: "15",
                                                                  style: currentReward
                                                                              ?.status ==
                                                                          "CLAIMED"
                                                                      ? TextStyles
                                                                          .textStyle105
                                                                      : TextStyles
                                                                          .textStyle39),
                                                              ConstantText(
                                                                  text: "/15",
                                                                  style: currentReward
                                                                              ?.status ==
                                                                          "CLAIMED"
                                                                      ? TextStyles
                                                                          .textStyle106
                                                                      : TextStyles
                                                                          .textStyle38),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      currentReward?.status ==
                                                              "CLAIMED"
                                                          ? Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      18.0),
                                                              child:
                                                                  LinearPercentIndicator(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              0), //leaner progress bar
                                                                      animation:
                                                                          true,
                                                                      animationDuration:
                                                                          1000,
                                                                      lineHeight:
                                                                          15,
                                                                      percent:
                                                                          100 /
                                                                              100,
                                                                      progressColor:
                                                                          Colours
                                                                              .pumpkin,
                                                                      backgroundColor: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.3)),
                                                            )
                                                          : currentReward
                                                                      ?.status ==
                                                                  "UNCLAIMED"
                                                              ? Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          18.0),
                                                                  child: LinearPercentIndicator(
                                                                      padding: EdgeInsets.all(0), //leaner progress bar
                                                                      animation: true,
                                                                      animationDuration: 1000,
                                                                      lineHeight: 15,
                                                                      percent: 50 / 100,
                                                                      progressColor: Colours.pumpkin,
                                                                      backgroundColor: Colors.grey.withOpacity(0.3)),
                                                                )
                                                              : currentReward
                                                                          ?.status ==
                                                                      "LOCKED"
                                                                  ? Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              18.0),
                                                                      child: LinearPercentIndicator(
                                                                          padding: EdgeInsets.all(0), //leaner progress bar
                                                                          animation: true,
                                                                          animationDuration: 1000,
                                                                          lineHeight: 15,
                                                                          percent: 0 / 100,
                                                                          progressColor: Colours.pumpkin,
                                                                          backgroundColor: Colors.grey.withOpacity(0.3)),
                                                                    )
                                                                  : Container(),
                                                      ConstantText(
                                                          text: currentReward?.status ==
                                                                  "CLAIMED"
                                                              ? reward_claimed
                                                              : currentReward
                                                                          ?.status ==
                                                                      "UNCLAIMED"
                                                                  ? reward_unclaimed
                                                                  : currentReward
                                                                              ?.status ==
                                                                          "LOCKED"
                                                                      ? reward_lock
                                                                      : "",
                                                          style: currentReward
                                                                      ?.status ==
                                                                  "CLAIMED"
                                                              ? TextStyles
                                                                  .textStyle107
                                                              : TextStyles
                                                                  .textStyle40)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              currentReward?.status == "CLAIMED"
                                                  ? Positioned(
                                                      top: h10p * 0.7,
                                                      left: w10p * 2.5,
                                                      child: Container(
                                                        height: h10p * 0.4,
                                                        width: w10p * 2.5,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color:
                                                              Colours.pumpkin,
                                                        ),
                                                        child: Center(
                                                          child: ConstantText(
                                                            text: view_rewards,
                                                            style: TextStyles
                                                                .textStyle47,
                                                          ),
                                                        ),
                                                      ))
                                                  : Container(),
                                              currentReward?.status == "CLAIMED"
                                                  ? Positioned(
                                                      top: h10p * 0.75,
                                                      right: w10p * 0.67,
                                                      child: ImageFromAssetPath<
                                                                  Widget>(
                                                              assetPath:
                                                                  ImageAssetpathConstant
                                                                      .leadingStar)
                                                          .imageWidget,
                                                    )
                                                  : currentReward?.status ==
                                                          "UNCLAIMED"
                                                      ? Positioned(
                                                          top: h10p * 0.85,
                                                          right: w10p * 3.4,
                                                          child: ImageFromAssetPath<
                                                                      Widget>(
                                                                  assetPath:
                                                                      ImageAssetpathConstant
                                                                          .leadingStar)
                                                              .imageWidget,
                                                        )
                                                      : currentReward?.status ==
                                                              "LOCKED"
                                                          ? Positioned(
                                                              top: h10p * 0.85,
                                                              right: w10p * 3.5,
                                                              child: SvgPicture.asset(
                                                                  ImageAssetpathConstant
                                                                      .rewardLockedImage),
                                                            )
                                                          : Container(),
                                            ]),
                                          );
                                        },
                                        itemCount: 3,
                                        // rewards.data!.rewards!.length,
                                        loop: false,
                                        viewportFraction: 0.8,
                                        scale: 0.99,
                                        onIndexChanged: (value) {
                                          setState(() {
                                            currentIndex = value;
                                          });
                                        },
                                      )),
                                )
                              ],
                            ),
                    ),
                  ),
                )
              ]);
            });
          })));
    });
  }
}
