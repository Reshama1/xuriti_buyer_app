import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/new%20modules/Credit_Details/model/Credit_Details.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/screens/kyc_screens/kyc_verification_screen.dart';
import 'package:xuriti/util/common/widget_constants.dart';
import '../../../new modules/InteractiveSplashScreen/Invoice_Interactive_VM.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/GreetMessageModel/greetMessageDialog.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class CompanyList extends StatefulWidget {
  final bool? showBackButton;
  const CompanyList({Key? key, this.showBackButton}) : super(key: key);

  @override
  State<CompanyList> createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList>
    with SingleTickerProviderStateMixin {
  RxBool _showbtn = true.obs;
  final Duration duration = Duration(milliseconds: 300);
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  TransactionManager transactionManager = Get.put(TransactionManager());
  AuthManager authManager = Get.put(AuthManager());
  InteractiveDialogViewModel interactiveDialogViewModel =
      Get.put(InteractiveDialogViewModel());
  StreamSubscription? streamSubscribed;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      String? id = authManager.userDetails?.value?.user?.sId ?? "";
      companyListViewModel.getCompanyList(id, (value) => null);
      // interactiveDialogViewModel.getInteractiveDialogueData(
      //     dialogType: DialogOptions.greet.name);

      showGreetDialogWRTToCurrentTime();
    });

    companyListViewModel.companyList?.listen((p0) {
      if (companyListViewModel.companyListLoading.value == true) {
        return;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    streamSubscribed?.cancel();
    super.dispose();
  }

  Future<bool> onWillPop() async {
    DateTime _lastExitTime = DateTime.now();

    if (DateTime.now().difference(_lastExitTime) >= Duration(seconds: 3)) {
      //showing message to user
      final snack = SnackBar(
        content: ConstantText(text: pressBackButtonAgainToExit),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
      _lastExitTime = DateTime.now();
      return false; // disable back press
    } else {
      return true; //  exit the app
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxHeight = constraints.maxHeight;
        double maxWidth = constraints.maxWidth;
        double h1p = maxHeight * 0.01;

        double w1p = maxWidth * 0.01;

        return WillPopScope(
          onWillPop: onWillPop,
          child: SafeArea(
            child: Scaffold(
              floatingActionButton: Obx(() {
                return AnimatedSlide(
                  offset: _showbtn.value ? Offset.zero : Offset(0, 2),
                  duration: duration,
                  child: AnimatedOpacity(
                    opacity: _showbtn.value ? 1 : 0,
                    duration: duration,
                    child: FloatingActionButton(
                      backgroundColor: Colours.tangerine,
                      child: Icon(
                        Icons.logout,
                        color: Colours.white,
                      ),
                      onPressed: () async => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const ConstantText(text: logging_out),
                          content: const ConstantText(text: are_you_sure),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, cancel),
                              child: const ConstantText(
                                text: cancel,
                                style: TextStyle(color: Colours.tangerine),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                await authManager.logOut();

                                Navigator.pushNamed(context, login);
                              },
                              child: const ConstantText(
                                text: ok,
                                style: TextStyle(color: Colours.tangerine),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
              backgroundColor: Colours.black,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colours.black,
                automaticallyImplyLeading: false,
                toolbarHeight: h1p * 7.5,
                flexibleSpace: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: h1p * 2, horizontal: w1p * 4),
                      child: Image.asset(
                        ImageAssetpathConstant.xuriti1,
                      ),
                    ),
                  ],
                ),
              ),
              body: OrientationBuilder(
                builder: (context, orientation) {
                  return ProgressHUD(
                    child: Container(
                      width: maxWidth,
                      decoration: const BoxDecoration(
                          color: Colours.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26),
                            topRight: Radius.circular(26),
                          )),
                      child: NotificationListener<UserScrollNotification>(
                        onNotification: (notification) {
                          final ScrollDirection direction =
                              notification.direction;

                          if (direction == ScrollDirection.reverse) {
                            _showbtn.value = false;
                          } else if (direction == ScrollDirection.forward) {
                            _showbtn.value = true;
                          }

                          return true;
                        },
                        child: Container(
                          height: double.infinity,
                          child: Obx(() {
                            return CustomScrollView(shrinkWrap: true, slivers: [
                              SliverList(
                                  delegate: SliverChildListDelegate(
                                [
                                  SizedBox(
                                    height: 55.0,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, left: 15.0, right: 15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          widget.showBackButton == true
                                              ? GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Icon(
                                                    Icons.arrow_back,
                                                    color: Colors.black,
                                                  ),
                                                )
                                              : SizedBox(),
                                          ConstantText(
                                            text: retailer,
                                            style: TextStyles.textStyle56,
                                            textAlign: TextAlign.center,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, businessRegister);
                                            },
                                            child: Icon(
                                              Icons.add,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  if ((companyListViewModel.companyList?.value
                                              ?.company?.length ??
                                          0) ==
                                      0) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: h1p * 26),
                                      child: Center(
                                        child: ConstantText(
                                          text:
                                              please_add_your_company_to_get_started,
                                          style: TextStyle(
                                              color: Colours.warmGrey75,
                                              fontSize: 21),
                                        ),
                                      ),
                                    );
                                  }

                                  final gstno = companyListViewModel
                                          .companyList
                                          ?.value
                                          ?.company?[index]
                                          .company
                                          ?.gstin ??
                                      '';

                                  return InkWell(
                                      onTap: () async {
                                        print("clicked...........");
                                        companyListViewModel
                                                .selectedCompany.value =
                                            companyListViewModel
                                                .companyList
                                                ?.value
                                                ?.company?[index]
                                                .company;

                                        if (companyListViewModel.selectedCompany
                                                .value?.status ==
                                            "Approved") {
                                          transactionManager.fetchInvoicesList(
                                              statusA: 'Confirmed',
                                              statusB: "Partpay",
                                              type: 'IN',
                                              resetFlag: true);
                                          transactionManager
                                              .landingScreenIndex.value = 0;
                                          transactionManager
                                                  .selectedSeller.value =
                                              CreditDetails(
                                                  anchorName: all_sellers.tr);
                                          transactionManager
                                              .invoiceScreenIndex.value = 0;
                                          Navigator.pushReplacementNamed(
                                              context, landing);
                                        } else if (companyListViewModel
                                                .selectedCompany
                                                .value
                                                ?.status ==
                                            "Hold") {
                                          showDialog<String>(
                                            context: context,

                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0)),
                                              title: const ConstantText(
                                                text: update_your_KYC,
                                                style: TextStyles.textStyle56,
                                              ),
                                              content: ConstantText(
                                                text: companyStatusIsInProgress(
                                                    companyListViewModel
                                                            .selectedCompany
                                                            .value
                                                            ?.companyName ??
                                                        ""),
                                                // 'You are not allowed to perform any operation, $companyName status is $companyStatus. Please proceed to KYC Verification.',

                                                style: TextStyles.textStyle117,
                                              ),
                                              actions: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      // autofocus: true,
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            new MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        KycVerification()));
                                                      },
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                      ),
                                                      // onPressed: () =>
                                                      //     Navigator.pop(context, 'Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colours.paleRed,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),

                                            // ),
                                          );
                                        } else if (companyListViewModel
                                                .selectedCompany
                                                .value
                                                ?.status ==
                                            "Inactive") {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  duration:
                                                      Duration(seconds: 5),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: ConstantText(
                                                    text: CompanyStatusIsInactive(
                                                        companyListViewModel
                                                                .selectedCompany
                                                                .value
                                                                ?.companyName ??
                                                            "",
                                                        companyListViewModel
                                                                .selectedCompany
                                                                .value
                                                                ?.status ??
                                                            "Unknown"),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )));
                                        } else if (companyListViewModel
                                                .selectedCompany
                                                .value
                                                ?.status ==
                                            "In-Progress") {
                                          showDialog<String>(
                                            context: context,

                                            builder: (BuildContext context) =>
                                                // Container(
                                                //   decoration: const BoxDecoration(
                                                //       color: Colours.white,
                                                //       borderRadius: BorderRadius.only(
                                                //         topLeft: Radius.circular(26),
                                                //         topRight: Radius.circular(26),
                                                //       )),
                                                //   child:
                                                AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0)),
                                              title: const ConstantText(
                                                text: update_your_KYC,
                                                style: TextStyles.textStyle56,
                                              ),
                                              content: ConstantText(
                                                text: companyStatusIsInProgress(
                                                    companyListViewModel
                                                            .selectedCompany
                                                            .value
                                                            ?.companyName ??
                                                        ""),
                                                // 'You are not allowed to perform any operation, $companyName status is $companyStatus. Please proceed to KYC Verification.',

                                                style: TextStyles.textStyle117,
                                              ),
                                              actions: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      autofocus: true,
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            new MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        KycVerification()));
                                                      },
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                      ),
                                                      // onPressed: () =>
                                                      //     Navigator.pop(context, 'Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colours.paleRed,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),

                                            // ),
                                          );
                                        }
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              left: w1p * 5,
                                              right: w1p * 5,
                                              bottom: h1p * 1,
                                              top: h1p),
                                          padding: EdgeInsets.only(
                                            left: w1p * 5,
                                            right: w1p * 5,
                                            bottom: w1p * 3,
                                            top: w1p * 3,
                                          ),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 8.0,
                                                    color: Colours.primary)
                                              ],
                                              border: Border.all(
                                                  color: Colours.primary,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          child: Row(
                                            mainAxisAlignment: orientation ==
                                                    Orientation.portrait
                                                ? MainAxisAlignment.spaceBetween
                                                : MainAxisAlignment
                                                    .spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    ConstantText(
                                                      textAlign:
                                                          TextAlign.center,
                                                      text: (companyListViewModel
                                                              .companyList
                                                              ?.value
                                                              ?.company?[index]
                                                              .company
                                                              ?.companyName ??
                                                          ""),
                                                      style: TextStyles
                                                          .textStyleC85,
                                                    ),
                                                    SizedBox(
                                                      height: 7,
                                                    ),
                                                    ConstantText(
                                                      textAlign:
                                                          TextAlign.center,
                                                      text:
                                                          "${gst_number} :$gstno",
                                                      style: TextStyles
                                                          .textStyleC71,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Expanded(child: SizedBox()),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  // Text(''),
                                                  SizedBox(
                                                    width: 7.5,
                                                  ),

                                                  companyStatusToIcon(
                                                      companyListViewModel
                                                              .companyList
                                                              ?.value
                                                              ?.company?[index]
                                                              .company
                                                              ?.status ??
                                                          "unknown"),
                                                ],
                                              ),
                                            ],
                                          )));
                                },
                                childCount: (companyListViewModel.companyList
                                                ?.value?.company?.length ??
                                            0) ==
                                        0
                                    ? 1
                                    : companyListViewModel.companyList?.value
                                            ?.company?.length ??
                                        0,
                              ))
                            ]);
                          }),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
