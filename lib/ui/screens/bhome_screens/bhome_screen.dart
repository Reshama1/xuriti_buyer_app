import 'dart:async';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flame_lottie/flame_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/logic/view_models/reward_manager.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/screens/bhome_screens/header_widget_for_cred_limit_seller_selection.dart';
import 'package:xuriti/ui/screens/bhome_screens/upcoming_screens/home_upcoming.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/custom_interactive_dialog.dart';
import 'package:xuriti/util/common/key_value_sharedpreferences.dart';
import 'package:xuriti/util/common/string_constants.dart';
import 'package:xuriti/util/common/text_constant_widget.dart';
import '../../../logic/view_models/transaction_manager.dart';
import '../../../models/core/reward_model.dart';
import '../../../new modules/Credit_Details/model/Credit_Details.dart';
import '../../../new modules/InteractiveSplashScreen/Invoice_Interactive_VM.dart';
import '../../../new modules/common_widget.dart';
import '../../../util/GreetMessageModel/greetMessageDialog.dart';
import '../../../util/GreetMessageModel/greetMessageModel.dart';
import '../../../util/common/enum_constants.dart';
import '../../theme/constants.dart';
import '../../widgets/bhome_widgets/bhomeHeading_widget.dart';
import '../../widgets/bhome_widgets/guide_widget.dart';
import '/new modules/image_assetpath_constants.dart';
import 'package:easy_localization/easy_localization.dart';

class BhomeScreen extends StatefulWidget {
  const BhomeScreen({Key? key}) : super(key: key);

  @override
  State<BhomeScreen> createState() => _BhomeScreenState();
}

class _BhomeScreenState extends State<BhomeScreen> {
  ScrollController controllerForScroll = new ScrollController();

  Credit_Details_VM credit_details_vm = Get.put(Credit_Details_VM());
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  TransactionManager transactionManager = Get.put(TransactionManager());
  RewardManager rewardManager = Get.put(RewardManager());
  AuthManager authManager = Get.put(AuthManager());

  InteractiveDialogViewModel interactiveDialogViewModel =
      Get.put(InteractiveDialogViewModel());

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("card_images");

  StreamSubscription? greetStreamSubscribed;
  StreamSubscription? invoiceStreamSubscribed;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      credit_details_vm.getCreditDetails();
      transactionManager.fetchInvoicesList(
        statusA: 'Confirmed',
        statusB: "Partpay",
        type: 'IN',
        resetFlag: true,
      );
      rewardManager.getRewards();

      // interactiveDialogViewModel.getInteractiveDialogueData(
      //     dialogType: DialogOptions.greet.name);
      interactiveDialogViewModel.getInteractiveDialogueData(
          dialogType: DialogOptions.invoice.name,
          buyerId: companyListViewModel.selectedCompany.value?.sId ?? "");
    });

    showPendingOverDueInvoicesAction();
    controllerForScroll.addListener(() async {
      if (controllerForScroll.offset >
          controllerForScroll.position.maxScrollExtent - 500) {
        transactionManager.fetchInvoicesList(
            statusA: 'Confirmed', statusB: "Partpay", type: 'IN');
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    greetStreamSubscribed?.cancel();
    invoiceStreamSubscribed?.cancel();
    super.dispose();
  }

  bool checkIfDialogWasShownRecentlyForSelectedCompany() {
    String? recentSelectedCompany = getIt<SharedPreferences>()
        .getString(SharedPrefKeyValue.recentSelectedCompany);
    if (recentSelectedCompany == null) {
      return false;
    }
    if (recentSelectedCompany ==
        companyListViewModel.selectedCompany.value?.companyId) {
      return true;
    } else {
      return false;
    }
  }

  void showPendingOverDueInvoicesAction() {
    invoiceStreamSubscribed?.cancel();

    invoiceStreamSubscribed = interactiveDialogViewModel
        .interactiveMessageForInvoice
        ?.listen((p0) async {
      if (transactionManager.landingScreenIndex == 1 || p0 == null) {
        if (p0 == null &&
            interactiveDialogViewModel.gettingSplashScreenDataForInvoice ==
                false) {
          await getIt<SharedPreferences>().setString(
              SharedPrefKeyValue.recentSelectedCompany,
              companyListViewModel.selectedCompany.value?.companyId ?? "");
        }
        return;
      }
      showDialogOnBHomeScreenForInvoices();
    });
  }

  // showGreetDialogIfNoInvoicesArePresent() {
  //   greetStreamSubscribed?.cancel();
  //   if (interactiveDialogViewModel.gettingSplashScreenDataForGreet == true) {
  //     greetStreamSubscribed =
  //         interactiveDialogViewModel.interactiveMessageForGreet?.listen(
  //       (p0) {
  //         showGreetDialogUI(p0: p0);
  //       },
  //     );
  //   } else {
  //     showGreetDialogUI(
  //         p0: interactiveDialogViewModel.interactiveMessageForGreet?.value);
  //   }
  // }

  // showGreetDialogUI({required InteractiveDialogModel? p0}) {
  //   if (interactiveDialogViewModel.gettingSplashScreenDataForGreet.value ==
  //       true) {
  //     return;
  //   }
  //
  //   if ((p0 == null || p0.message == null) ||
  //       transactionManager.landingScreenIndex.value != 0) {
  //     return;
  //   } else if (transactionManager.landingScreenIndex.value != 0) {
  //     return;
  //   }
  //
  //   showInteractiveDialog(
  //     greetTitleMessage: interactiveDialogViewModel
  //                 .interactiveMessageForInvoice?.value?.message?.greet ==
  //             null
  //         ? (interactiveDialogViewModel
  //                 .interactiveMessageForInvoice?.value?.message?.title ??
  //             "")
  //         : (interactiveDialogViewModel
  //                 .interactiveMessageForInvoice?.value?.message?.greet ??
  //             ""),
  //     onDismiss: () {
  //       Get.until((route) {
  //         if (Get.currentRoute != landing) {
  //           Get.back();
  //           return true;
  //         }
  //         return false;
  //       });
  //       showDialogOnBHomeScreenForInvoices();
  //     },
  //     dismissIn: Duration(seconds: 7),
  //     dialogOption: DialogOptions.greet,
  //     dialogTitle: p0.message?.title,
  //     dialogSubTitle: p0.message?.subtitle,
  //     image: p0.message?.image,
  //     topAnimationWidget: Center(
  //       child: Padding(
  //         padding: EdgeInsets.only(top: 20),
  //         child: Lottie.network(
  //           p0.message?.image ?? "",
  //           height: 150,
  //           fit: BoxFit.fill,
  //           repeat: false,
  //           errorBuilder: (lottieContext, obj, trace) {
  //             return Center(child: CircularProgressIndicator());
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  showDialogOnBHomeScreenForInvoices() async {
    ///Priorities to show invoice dialogs
    // P1 - Overdue invoices
    // P2 - Pending invoices
    // P3 - Confirmed invoices

    GreetAssetDimensionsAndMessage? greetDialog =
        await DateTime.now().getGreetMessage(checkLastTimeStamp: false);

    if (interactiveDialogViewModel.interactiveMessageForInvoice?.value ==
            null ||
        interactiveDialogViewModel
                .interactiveMessageForInvoice?.value?.message ==
            null ||
        interactiveDialogViewModel
                .interactiveMessageForInvoice?.value?.message?.title
                ?.toLowerCase() ==
            "no invoices" ||
        interactiveDialogViewModel
                .interactiveMessageForInvoice?.value?.message?.greet ==
            null) {
      await getIt<SharedPreferences>().setString(
          SharedPrefKeyValue.recentSelectedCompany,
          companyListViewModel.selectedCompany.value?.companyId ?? "");
      showGreetDialogWRTToCurrentTime();
      return;
    }
    if (checkIfDialogWasShownRecentlyForSelectedCompany()) {
      return;
    } else {
      await getIt<SharedPreferences>().setString(
          SharedPrefKeyValue.recentSelectedCompany,
          companyListViewModel.selectedCompany.value?.companyId ?? "");
    }

    await getIt<SharedPreferences>().setString(
        SharedPrefKeyValue.greetTimeStampShownAt,
        DateTime.now().parseDateIn(requiredFormat: "yyyy-MM-dd HH:mm:ss") ??
            "");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      showInteractiveDialog(
        greetTitleMessage: (greetDialog?.message ?? "") +
            " " +
            (authManager.userDetails?.value?.user?.name ?? ""),
        onDismiss: () {
          Get.until((route) {
            if (Get.currentRoute != landing) {
              Get.back();
              return true;
            }
            return false;
          });
        },
        dismissIn: Duration(seconds: 5),
        actionButtons: interactiveDialogViewModel.interactiveMessageForInvoice
                    ?.value?.message?.actionButton !=
                null
            ? GestureDetector(
                onTap: () {
                  Get.until((route) {
                    if (Get.currentRoute != landing) {
                      Get.back();
                      return true;
                    }
                    return false;
                  });

                  if (interactiveDialogViewModel.interactiveMessageForInvoice
                          ?.value?.message?.actionName
                          ?.toLowerCase() ==
                      "pending") {
                    transactionManager.invoiceScreenIndex.value = 0;
                    transactionManager.landingScreenIndex.value = 1;
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => XuritiPayUrl()),
                    );
                  }
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(73, 148, 236, 1),
                    borderRadius: BorderRadius.circular(
                      22.5,
                    ),
                  ),
                  child: ConstantText(
                    text: interactiveDialogViewModel
                            .interactiveMessageForInvoice
                            ?.value
                            ?.message
                            ?.actionButton ??
                        "", //dialogInvoiceType == null ? "Approve Now" : (dialogInvoiceType == InvoiceDialogShowing.confirmedInvoices ?  :) : "" ,
                    color: Colors.white,
                  ),
                ),
              )
            : null,
        dialogOption: interactiveDialogViewModel.interactiveMessageForInvoice
                    ?.value?.message?.actionButton ==
                null
            ? DialogOptions.greet
            : DialogOptions.invoice,
        dialogTitle: interactiveDialogViewModel
                .interactiveMessageForInvoice?.value?.message?.title ??
            "",
        dialogSubTitle: interactiveDialogViewModel
                .interactiveMessageForInvoice?.value?.message?.subtitle ??
            "",
        bgColorForGreetInInvoicesDialog: interactiveDialogViewModel
                    .interactiveMessageForInvoice
                    ?.value
                    ?.message
                    ?.actionButton !=
                null
            ? (interactiveDialogViewModel.interactiveMessageForInvoice?.value
                        ?.message?.actionName
                        ?.toLowerCase() ==
                    "overdue"
                ? Colors.red
                : Color.fromRGBO(52, 123, 128, 1))
            : Colors.white,
        topAnimationWidget: Container(
          padding: EdgeInsets.only(
            top: 15.0,
            bottom: 15.0,
          ),
          color: interactiveDialogViewModel.interactiveMessageForInvoice?.value
                      ?.message?.actionButton !=
                  null
              ? (interactiveDialogViewModel.interactiveMessageForInvoice?.value
                          ?.message?.actionName
                          ?.toLowerCase() ==
                      "overdue"
                  ? Colors.red
                  : Color.fromRGBO(52, 123, 128, 1))
              : Colors.white,
          child: Center(
            child: Lottie.network(
                interactiveDialogViewModel
                        .interactiveMessageForInvoice?.value?.message?.image ??
                    "",
                height: interactiveDialogViewModel.interactiveMessageForInvoice
                            ?.value?.message?.actionButton !=
                        null
                    ? 100
                    : 150,
                fit: BoxFit.contain,
                repeat: true, errorBuilder: (lottieContext, obj, trace) {
              return Center(child: CircularProgressIndicator());
            }),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxHeight = constraints.maxHeight;
        double maxWidth = constraints.maxWidth;
        double h1p = maxHeight * 0.01;
        double h10p = maxHeight * 0.1;
        double w10p = maxWidth * 0.1;
        return Scaffold(
          backgroundColor: Colours.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () {
                  debugPrint(
                      transactionManager.selectedSeller.value.toString());
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 10.0,
                      top: 10.0,
                      bottom: 10.0,
                      right: 10.0,
                    ),
                    child: HeaderWidgetForCreditLimitAndSellerSelection(
                      selectedSeller: (CreditDetails? sellerObject) async {
                        transactionManager.selectedSeller.value = sellerObject;

                        transactionManager.fetchInvoicesList(
                          statusA: 'Confirmed',
                          statusB: "Partpay",
                          type: 'IN',
                          resetFlag: true,
                        );
                      },
                      showSellerFilter: true,
                    ),
                  );
                },
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colours.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        26,
                      ),
                      topRight: Radius.circular(
                        26,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 2.0,
                    ),
                    child: Obx(
                      () {
                        return (transactionManager
                                    .invoices?.value?.invoice?.isEmpty ??
                                true)
                            ? Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 18, vertical: h1p * 4),
                                    child: const ConstantText(
                                        text: upcoming_payment,
                                        style: TextStyles.textStyle38),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: w10p * .6,
                                      vertical: h1p * 1,
                                    ),
                                    child: Container(
                                        width: maxWidth,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          color: Colours.offWhite,
                                        ),
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
                                    child: ImageFromAssetPath<Widget>(
                                            assetPath: ImageAssetpathConstant
                                                .onboardImage3)
                                        .imageWidget,
                                  ),
                                ],
                              )
                            : CustomScrollView(
                                controller: controllerForScroll,
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: w10p * 0.6,
                                        vertical: h1p * 4,
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
                                                text: outstanding_amount,
                                                style: TextStyles.textStyle99,
                                              ),
                                              ConstantText(
                                                  text: transactionManager
                                                      .invoices
                                                      ?.value
                                                      ?.totalOutstandingAmount
                                                      .getDoubleValue()
                                                      .toString()
                                                      .setCurrencyFormatter(),
                                                  //  "${transactionManager.invoices?.value?.invoice?.fold<double?>(0.0, (previousValue, element) {
                                                  //   if (previousValue == null) {
                                                  //     0.0;
                                                  //   }
                                                  //   ;
                                                  //   return previousValue = (previousValue == null
                                                  //           ? 0.0
                                                  //           : previousValue) +
                                                  //       ((((double.tryParse(element.outstandingAmount ?? "0.0") != null
                                                  //                       ? double.parse(element.outstandingAmount ??
                                                  //                           "0.0")
                                                  //                       : 0.0)
                                                  //                   .toDouble()) +
                                                  //               ((double.tryParse(element.interest.toString()) != null
                                                  //                       ? double.parse(element
                                                  //                           .interest
                                                  //                           .toString())
                                                  //                       : 0.0)
                                                  //                   .toDouble())) -
                                                  //           ((double.tryParse(element.discount.toString()) !=
                                                  //                       null
                                                  //                   ? double.parse(element.discount.toString())
                                                  //                   : 0.0)
                                                  //               .toDouble()));
                                                  // })}"
                                                  //         .setCurrencyFormatter(),
                                                  style:
                                                      TextStyles.textStyleUp),
                                            ],
                                          ),
                                          Container(
                                            height: h1p * 5.5,
                                            width: w10p * 2,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colours.successPrimary,
                                            ),
                                            child: Center(
                                              child: InkWell(
                                                onTap: () async {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            XuritiPayUrl()),
                                                  );
                                                },
                                                child: ConstantText(
                                                  text: pay_now,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyles.textStyle46,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SliverToBoxAdapter(
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: w10p * .4),
                                        child: SubHeadingWidget(
                                          maxHeight: maxHeight,
                                          maxWidth: maxWidth,
                                          heading1: upcoming_payment,
                                        )),
                                  ),
                                  SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                    ((context, index) {
                                      return HomeUpcoming(
                                        companyName: transactionManager
                                                .invoices
                                                ?.value
                                                ?.invoice?[index]
                                                .seller
                                                ?.companyName ??
                                            "",
                                        payableAmount: transactionManager
                                                .invoices
                                                ?.value
                                                ?.invoice?[index]
                                                .payableAmount ??
                                            "",
                                        fullDetails: transactionManager
                                            .invoices?.value?.invoice?[index],
                                      );
                                    }),
                                    childCount: transactionManager
                                            .invoices?.value?.invoice?.length ??
                                        0,
                                  )),
                                  SliverToBoxAdapter(
                                    child: transactionManager
                                            .hasMoreItemsToScroll.value
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: Colours.pumpkin,
                                            ),
                                          )
                                        : Container(),
                                  ),
                                  SliverPadding(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    sliver: SliverToBoxAdapter(
                                      child: GuideWidget(
                                        maxWidth: maxWidth,
                                        maxHeight: maxHeight,
                                      ),
                                    ),
                                  ),
                                  Obx(() {
                                    return (rewardManager
                                                    .rewardsDataResponse
                                                    .value
                                                    ?.data
                                                    ?.rewards
                                                    ?.length ??
                                                0) !=
                                            0
                                        ? SliverToBoxAdapter(
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: w10p * .4,
                                                    vertical: 18),
                                                child: SubHeadingWidget(
                                                  maxHeight: maxHeight,
                                                  maxWidth: maxWidth,
                                                  heading1: rewards_constant,
                                                )))
                                        : SliverToBoxAdapter();
                                  }),
                                  Obx(
                                    () {
                                      return SliverToBoxAdapter(
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            height: 140,
                                            width: maxWidth,
                                            child: Swiper(
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                Rewards? currentReward =
                                                    rewardManager
                                                        .rewardsDataResponse
                                                        .value
                                                        ?.data
                                                        ?.rewards?[index];
                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 9.0,
                                                      vertical: 8),
                                                  child: Stack(children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              2),
                                                      width: w10p * 9,
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  image: AssetImage(currentReward
                                                                              ?.status ==
                                                                          "CLAIMED"
                                                                      ? "assets/images/completed-reward.png"
                                                                      : currentReward?.status ==
                                                                              "UNCLAIMED"
                                                                          ? "assets/images/home_images/bgimage1.png"
                                                                          : currentReward?.status ==
                                                                                  "LOCKED"
                                                                              ? "assets/images/home_images/bgimage2.png"
                                                                              : "assets/images/home_images/bgimage2.png")),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(28),
                                                          color: Colours.white,
                                                          // border: Border.all(color: Colours.black,width: 0.5),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                spreadRadius:
                                                                    0.1,
                                                                blurRadius: 1,
                                                                offset: Offset(
                                                                  0,
                                                                  1,
                                                                )),
                                                            // BoxShadow(color: Colors.grey,spreadRadius: 0.5,blurRadius: 1,
                                                            //     offset: Offset(1,1,))
                                                          ]),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
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
                                                                        text: context.tr(level) +
                                                                            "${currentReward?.level ?? 0}",
                                                                        style: currentReward?.status ==
                                                                                "CLAIMED"
                                                                            ? TextStyles.textStyle46
                                                                            : TextStyles.textStyle38),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text("15",
                                                                        style: currentReward?.status ==
                                                                                "CLAIMED"
                                                                            ? TextStyles.textStyle105
                                                                            : TextStyles.textStyle39),
                                                                    Text("/15",
                                                                        style: currentReward?.status ==
                                                                                "CLAIMED"
                                                                            ? TextStyles.textStyle106
                                                                            : TextStyles.textStyle38),
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
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 18.0),
                                                                        child: LinearPercentIndicator(
                                                                            padding: EdgeInsets.all(0), //leaner progress bar
                                                                            animation: true,
                                                                            animationDuration: 1000,
                                                                            lineHeight: 15,
                                                                            percent: 50 / 100,
                                                                            progressColor: Colours.pumpkin,
                                                                            backgroundColor: Colors.grey.withOpacity(0.3)),
                                                                      )
                                                                    : currentReward?.status ==
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
                                                                text: currentReward?.status ==
                                                                        "CLAIMED"
                                                                    ? reward_claimed
                                                                    : currentReward?.status ==
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
                                                              height:
                                                                  h10p * 0.4,
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
                                                            child: SvgPicture.asset(
                                                                "assets/images/leading-star.svg"),
                                                          )
                                                        : currentReward
                                                                    ?.status ==
                                                                "UNCLAIMED"
                                                            ? Positioned(
                                                                top:
                                                                    h10p * 0.85,
                                                                right:
                                                                    w10p * 3.4,
                                                                child: SvgPicture
                                                                    .asset(
                                                                        "assets/images/leading-star.svg"),
                                                              )
                                                            : currentReward
                                                                        ?.status ==
                                                                    "LOCKED"
                                                                ? Positioned(
                                                                    top: h10p *
                                                                        0.85,
                                                                    right:
                                                                        w10p *
                                                                            3.5,
                                                                    child: SvgPicture
                                                                        .asset(
                                                                            "assets/images/reward-lockedImage.svg"),
                                                                  )
                                                                : Container(),
                                                  ]),
                                                );
                                              },
                                              itemCount: rewardManager
                                                      .rewardsDataResponse
                                                      .value
                                                      ?.data
                                                      ?.rewards
                                                      ?.length ??
                                                  0,
                                              loop: false,
                                              viewportFraction: 0.8,
                                              scale: 0.99,
                                              onIndexChanged: (value) {},
                                            )),
                                      );
                                    },
                                  ),
                                ],
                              );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class XuritiPayUrl extends StatefulWidget {
  final String? xuritiPayUrl;

  XuritiPayUrl({this.xuritiPayUrl});

  @override
  State<XuritiPayUrl> createState() => _XuritiPayUrlState();
}

class _XuritiPayUrlState extends State<XuritiPayUrl> {
  // final flutterWebviewPlugin = new FlutterWebviewPlugin();

  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  AuthManager authManager = Get.put(AuthManager());

  WebViewController controller = WebViewController();
  bool flag = false;
  bool isCompleted = false;
  int counter = 0;
  StreamSubscription? _onDestroy;
  StreamSubscription<String>? _onUrlChanged;
  // late StreamSubscription<WebViewStateChanged> _onStateChanged;

  @override
  void dispose() {
    counter = 0;
    _onDestroy?.cancel();
    _onUrlChanged?.cancel();
    // _onStateChanged.cancel();
    // flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    String? token = authManager.userDetails?.value?.token ?? "";
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(const Color(0x00000000));
    controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {
          ///If found below conditions true it will navigate to landing screen

          if (url.contains("companies") &&
              url.contains("invoices") &&
              url.contains("purchases")) {
            Navigator.pushNamed(context, landing);
          }
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith(
              'https://biz.xuriti.app/#/invoices/invoicelist?uid=${companyListViewModel.selectedCompany.value?.companyId ?? ""}&type=payment&source=mobile&token=$token')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
    controller.loadRequest(Uri.parse(
        "https://biz.xuriti.app/#/invoices/invoicelist?uid=${companyListViewModel.selectedCompany.value?.companyId ?? ""}&type=payment&source=mobile&token=$token"));
    super.initState();
    flag = false;
    isCompleted = false;
    counter = 0;

    // _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {});

    // _onStateChanged =
    //     flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
    //   if (mounted) {}
    // });

    // _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
    //   if (mounted) {
    //     // if (url.contains("login") || url.contains("redirect")) {
    //     //         Navigator.pushNamed(context, landing);
    //     //         flutterWebviewPlugin.close();
    //     // } else

    //   }
    // });
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    // print("paymentUrl: ${widget.paymentUrl}");
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: ConstantText(
          text: msgForRefresh,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          controller.reload();
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff6f21d1),
        title: ConstantText(
          text: pay_now,
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
