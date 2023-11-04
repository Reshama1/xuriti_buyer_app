import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/ui/screens/bhome_screens/bhome_screen.dart';
import 'package:xuriti/ui/screens/invoices_screens/invoices_screen.dart';
import 'package:xuriti/ui/screens/starting_screens/company_list.dart';
import 'package:xuriti/ui/theme/constants.dart';
import 'package:xuriti/util/common/widget_constants.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../logic/view_models/transaction_manager.dart';
import '../../../models/helper/service_locator.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../widgets/drawer_widget.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  TransactionManager transactionManager = Get.put(TransactionManager());
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      transactionManager.getSellerData(
          companyListViewModel.selectedCompany.value?.companyId ?? "");
    });
    super.initState();
  }

  Future<bool> onWillPop() async {
    getIt<TransactionManager>().selectedSeller.value = null;
    // Get.offAll(CompanyList());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (companyListContext) => CompanyList(
              // showBackButton: true,
              )),
      // (route) => false,
    );
    return true;
  }

  GlobalKey<ScaffoldState> sk = GlobalKey();

  String? id = '';
  bool isId = false;
  DateTime? currentBackPressTime;

  List<Widget> screens = [
    BhomeScreen(),
    InvoicesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    //
    // if (checkid == true) {
    //   if (entityid != null) {
    //     setState(() {
    //       String? id = entityid;
    //       this.id = id;
    //       isId = true;
    //       // navId != 'navId' ? currentIndex = 1 : currentIndex;
    //       if (navId == 'navId' || creditLimit) {
    //         //when come back from upcoming details page(notification nev)
    //         transactionManager.landingScreenIndex.value = 0;
    //         getIt<SharedPreferences>().remove('navId');
    //         getIt<SharedPreferences>().remove('creditLimit');
    //       } else {
    //         transactionManager.landingScreenIndex.value = 1;
    //       }
    //     });
    //   }
    // } else {
    //   setState(() {
    //     String? id =
    //         companyListViewModel.selectedCompany.value?.companyId ?? "";
    //     this.id = id;
    //     isId = false;
    //   });
    // }

    // getIt<TransHistoryManager>()
    //     .getPaymentHistory(getIt<SharedPreferences>().getString('token'), id);
    // CompanyDetails? status;

    return ProgressHUD(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxHeight = constraints.maxHeight;
          double maxWidth = constraints.maxWidth;

          double h10p = maxHeight * 0.1;
          double w10p = maxWidth * 0.1;

          return WillPopScope(
            onWillPop: onWillPop,
            child: SafeArea(
              child: Scaffold(
                body: Stack(
                  children: [
                    Center(
                      child: ImageFromAssetPath<Widget>(
                              assetPath: ImageAssetpathConstant.loader,
                              height: 70
                              // "assets/images/Spinner-3-unscreen.gif",
                              //color: Colors.orange,
                              )
                          .imageWidget,
                    ),
                    Scaffold(
                      key: sk,
                      endDrawer: DrawerWidget(
                        maxHeight: maxHeight,
                        maxWidth: maxWidth,
                      ),
                      appBar: AppBar(
                        backgroundColor: Colours.black,
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: ImageFromAssetPath<Widget>(
                                  assetPath: ImageAssetpathConstant.xuritiLogo)
                              .imageWidget,
                        ),
                        title: Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Center(
                                  child: ConstantText(
                                    text: companyListViewModel.selectedCompany
                                            .value?.companyName ??
                                        "",
                                    style: TextStyles.textStyle(),
                                  ),
                                ),
                              ),
                              companyStatusToIcon(companyListViewModel
                                      .selectedCompany.value?.status ??
                                  ""),
                            ],
                          );
                        }),
                        actions: [
                          InkWell(
                            onTap: () {
                              sk.currentState!.openEndDrawer();
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(18),
                                child: ImageFromAssetPath<Widget>(
                                        assetPath:
                                            "assets/images/menubutton.svg")
                                    .imageWidget),
                          ),
                        ],
                      ),
                      body: Obx(() {
                        return SafeArea(
                            child: screens[
                                transactionManager.landingScreenIndex.value]);
                      }),
                      bottomNavigationBar: Obx(() {
                        return Container(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    context.showLoader();

                                    transactionManager
                                        .landingScreenIndex.value = 0;

                                    transactionManager.fetchInvoicesList(
                                        statusA: "Confirmed",
                                        statusB: "Partpay",
                                        type: "IN");

                                    context.hideLoader();
                                  },
                                  child: Container(
                                    height: h10p * 0.5,
                                    width: w10p * 4.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: transactionManager
                                                    .landingScreenIndex.value ==
                                                0
                                            ? Colours.tangerine
                                            : Colours.black),
                                    child: Center(
                                      child: ConstantText(
                                        text: home,
                                        style: TextStyles.textStyle(),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    context.showLoader();

                                    await Future.delayed(
                                        const Duration(seconds: 1));

                                    transactionManager
                                        .invoiceScreenIndex.value = 0;

                                    transactionManager
                                        .landingScreenIndex.value = 1;

                                    // if (data?.invoice?.length != 0) {
                                    //   getIt<TransactionManager>()
                                    //       .changeSelectedInvoice(
                                    //       data?.invoice?[0]);
                                    // }
                                    context.hideLoader();
                                  },
                                  child: Container(
                                    height: h10p * 0.5,
                                    width: w10p * 4.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: transactionManager
                                                    .landingScreenIndex.value ==
                                                1
                                            ? Colours.tangerine
                                            : Colours.black),
                                    child: Center(
                                      child: ConstantText(
                                        text: invoices,
                                        style: TextStyles.textStyle(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
