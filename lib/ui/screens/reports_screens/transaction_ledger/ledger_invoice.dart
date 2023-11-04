import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/ui/screens/starting_screens/company_list.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/endPoints_constant.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../../logic/view_models/reward_manager.dart';
import '../../../../logic/view_models/transaction_manager.dart';
import '../../../../models/core/invoice_model.dart';
import '../../../../models/core/reward_model.dart';
import '../../../../models/helper/service_locator.dart';
import '../../../../models/services/dio_service.dart';
import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/string_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../theme/constants.dart';
import '../../../widgets/bhome_widgets/bhomeHeading_widget.dart';
import '../../../widgets/bhome_widgets/guide_widget.dart';
import '../../bhome_screens/upcoming_screens/transInvStateScreen.dart';
import 'package:easy_localization/easy_localization.dart';

class LedgerInvoiceScreen extends StatefulWidget {
  const LedgerInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<LedgerInvoiceScreen> createState() => _LedgerInvoiceScreenState();
}

class _LedgerInvoiceScreenState extends State<LedgerInvoiceScreen> {
  Credit_Details_VM credit_details_vm = Get.put(Credit_Details_VM());
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  RewardManager rewardManager = Get.put(RewardManager());

  int currentIndex = 0;
  String? invNo;
  String? sellerName;
  DateTime? transDate;
  String? transAmt;

  DateTime? invDate;
  bool isPressed = false; // used for download button
  late final Function onClick;

  List<dynamic> trns = [];
  List<TransactionInvoice>? invv = [];

  TransactionManager transactionManager = Get.put(TransactionManager());
  // final invv
  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    rewardManager.getRewards();
    dynamic responseData = await getIt<DioClient>().transactionStatementInv(
        companyListViewModel.selectedCompany.value?.companyId ?? "");
    final details = responseData['transcations'];

    setState(() {
      if (details != null) {
        List<dynamic> trns = details;

        this.trns = trns;
        print('transactttt0000000  ${trns[0]['details'][0]['seller_name']}');
        print('transact details fffffff  ${trns[0]['details']}');
      }
    });
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
            String baseUrl = DioClient.baseUrl;
            String dwnld = transactionalLedgerDownloadUrl(
                companyId:
                    companyListViewModel.selectedCompany.value?.companyId ??
                        "");
            //'/ledger/$companyId/statement/download';
            String downloadURL = dwnld;
            String uurrll = baseUrl + downloadURL;
            Uri uri = Uri.parse(uurrll);

            print('download url trans ++++++++++$uurrll');

            // openFile(
            //     url: baseUrl + downloadURL,
            //     filename:
            //         'transactionLedger.pdf');
            //   /ledger/buyerid/statement/download,

            return Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 12,
                      top: 80,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Obx(() {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 2,
                                  top: 3,
                                ),
                                child: Container(
                                  // width: w10p * 3.1,
                                  height: h10p * 0.9,
                                  // decoration: const BoxDecoration(
                                  //   color: Colours.almostBlack,
                                  // ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: h1p * 1,
                                      ),
                                      const ConstantText(
                                        text:
                                            total_credit_limit_credit_available,
                                        style: TextStyles.textStyle21,
                                      ),
                                      SizedBox(
                                        height: h1p * 0.2,
                                      ),
                                      ConstantText(
                                          text:
                                              "${((credit_details_vm.creditDetails?.value?.companyDetails?.totalCreditLimit ?? "0.0").getDoubleValue() / 100000).toStringAsFixed(2).setCurrencyFormatter()} lacs/ ${((credit_details_vm.creditDetails?.value?.companyDetails?.totalCreditAvailable ?? "0.0").getDoubleValue() / 100000).toStringAsFixed(2).setCurrencyFormatter()} lacs",
                                          style: TextStyles.textStyle354),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                        GestureDetector(
                            onTap: () {
                              //  context.showLoader();
                              // progress!.show();
                              Get.offAll(CompanyList());
                              // Navigator.pushNamed(context, homeCompanyList);
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
                    height: 20,
                  )
                ]),
              ),
              Expanded(
                child: Container(
                  width: maxWidth,
                  height: maxHeight,
                  decoration: const BoxDecoration(
                      color: Colours.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: w10p * 0.6,
                            vertical: h1p * 3,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ConstantText(
                                    text: transactionalLedger_,
                                    style: TextStyles.textStyleUp,
                                  ),
                                  trns.isEmpty
                                      ? SizedBox(
                                          height: h1p * 5.3,
                                          width: w10p * 1.7,
                                        )
                                      : InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onHighlightChanged: (param) {
                                            setState(() {
                                              isPressed = param;
                                            });
                                          },
                                          // onTap: () {
                                          //   widget.onClicked();
                                          // },
                                          onTap: () async {
                                            context.showLoader();

                                            dynamic responseData =
                                                await DioClient().get(dwnld);
                                            Future<void> _launchUrl() async {
                                              String url1 = responseData['url'];

                                              Uri uri = Uri.parse(url1);
                                              if (!await launchUrl(uri,
                                                  mode: LaunchMode
                                                      .externalApplication)) {
                                                throw Exception(
                                                    'Could not launch $uri');
                                              }
                                            }

                                            print(
                                                'response data 123**********$uri');
                                            if (responseData['status'] ==
                                                true) {
                                              _launchUrl();
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      somethingWentWrongWhileDownloadPdf,
                                                  timeInSecForIosWeb: 10,
                                                  toastLength:
                                                      Toast.LENGTH_LONG);
                                            }
                                            context.hideLoader();
                                            // print(
                                            //     'response data 123**********$uri');
                                            // if (responseData['status'] ==
                                            //     true) {
                                            //   _launchUrl();
                                            // }
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
                                                  color: Colors.green)),
                                          focusColor: Colors.orange,
                                        ),
                                ],
                              ),
                              // Text(
                              //   "₹ ${outStandingAmt.toStringAsFixed(2)}",
                              //   style: TextStyles.textStyleUp,
                              // ),
                            ],
                          ),
                        ),
                        trns.isEmpty
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: h1p * 8,
                                  ),
                                  Center(
                                    child: ImageFromAssetPath<Widget>(
                                            assetPath: ImageAssetpathConstant
                                                .onboardImage2)
                                        .imageWidget,
                                  ),
                                  SizedBox(
                                    height: h1p * 2,
                                  ),
                                  ConstantText(
                                    text: invoice_not_found,
                                    fontSize: w10p * 0.35,
                                    style: TextStyles.textStyle34,
                                  ),
                                ],
                              )
                            : Expanded(
                                child: CustomScrollView(
                                  slivers: [
                                    SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                      ((context, index) {
                                        var details = trns[index]['details'][0];
                                        return TransInv(
                                          invTransaction: trns[index]
                                              ['details'],

                                          companyName: trns[index]['details'][0]
                                                  ['seller'] ??
                                              ''.toString(),
                                          amount: details.containsKey('amount')
                                              ? trns[index]['details'][0]
                                                      ['amount']
                                                  .toStringAsFixed(2)
                                              : '',
                                          // amount: trns[index]['details'][0]['amount']
                                          //     .toStringAsFixed(2),
                                          invoiceDate: trns[index]['details'][0]
                                                  ['invoice_date']
                                              .toString(),
                                          invoiceNumber:
                                              trns[index]['_id'].toString(),
                                        );
                                      }),
                                      childCount: trns.length,
                                    )),
                                    SliverPadding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 18),
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
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              Rewards? currentReward =
                                                  rewardManager
                                                      .rewardsDataResponse
                                                      .value
                                                      ?.data
                                                      ?.rewards?[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 9.0,
                                                        vertical: 8),
                                                child: Stack(children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(2),
                                                    width: w10p * 9,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: ImageFromAssetPath<
                                                                        Widget>(
                                                                    assetPath: currentReward?.status ==
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
                                                            BorderRadius
                                                                .circular(28),
                                                        color: Colours.white,
                                                        // border: Border.all(color: Colours.black,width: 0.5),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              color:
                                                                  Colors.grey,
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
                                                                      style: currentReward?.status ==
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
                                                                      text:
                                                                          "15",
                                                                      style: currentReward?.status ==
                                                                              "CLAIMED"
                                                                          ? TextStyles
                                                                              .textStyle105
                                                                          : TextStyles
                                                                              .textStyle39),
                                                                  ConstantText(
                                                                      text:
                                                                          "/15",
                                                                      style: currentReward?.status ==
                                                                              "CLAIMED"
                                                                          ? TextStyles
                                                                              .textStyle106
                                                                          : TextStyles
                                                                              .textStyle38),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          currentReward
                                                                      ?.status ==
                                                                  "CLAIMED"
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
                                                                      percent: 100 / 100,
                                                                      progressColor: Colours.pumpkin,
                                                                      backgroundColor: Colors.grey.withOpacity(0.3)),
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
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 18.0),
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
                                                              text: currentReward
                                                                          ?.status ==
                                                                      "CLAIMED"
                                                                  ? reward_claimed
                                                                  : currentReward
                                                                              ?.status ==
                                                                          "UNCLAIMED"
                                                                      ? reward_unclaimed
                                                                      : currentReward?.status ==
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
                                                  currentReward?.status ==
                                                          "CLAIMED"
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
                                                                      .circular(
                                                                          4),
                                                              color: Colours
                                                                  .pumpkin,
                                                            ),
                                                            child: Center(
                                                              child:
                                                                  ConstantText(
                                                                text:
                                                                    view_rewards,
                                                                style: TextStyles
                                                                    .textStyle47,
                                                              ),
                                                            ),
                                                          ))
                                                      : Container(),
                                                  currentReward?.status ==
                                                          "CLAIMED"
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
                                                          : currentReward
                                                                      ?.status ==
                                                                  "LOCKED"
                                                              ? Positioned(
                                                                  top: h10p *
                                                                      0.85,
                                                                  right: w10p *
                                                                      3.5,
                                                                  child: ImageFromAssetPath<
                                                                              Widget>(
                                                                          assetPath:
                                                                              ImageAssetpathConstant.rewardLockedImage)
                                                                      .imageWidget,
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
                      ],
                    ),
                  ),
                ),
              )
            ]);
          })));
    });
  }
}
