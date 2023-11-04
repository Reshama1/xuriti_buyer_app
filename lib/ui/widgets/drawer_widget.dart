import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/models/core/user_details.dart';
import 'package:xuriti/models/services/dio_service.dart';
import 'package:xuriti/ui/screens/starting_screens/company_list.dart';
import 'package:xuriti/util/common/enum_constants.dart';
import '../../logic/view_models/auth_manager.dart';
import '../../logic/view_models/profile_manager.dart';
import '../../logic/view_models/trans_history_manager.dart';
import '../../logic/view_models/transaction_manager.dart';
import '../../models/helper/service_locator.dart';
import '../../new modules/common_widget.dart';
import '../../new modules/image_assetpath_constants.dart';

import '../../util/Extensions.dart';
import '../../util/common/key_value_sharedpreferences.dart';

import '../../util/common/string_constants.dart' as stringConstant;

import '../../util/common/text_constant_widget.dart';
import '../routes/router.dart';
import '../screens/account_credential.dart';

import '../theme/constants.dart';

class DrawerWidget extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;
  const DrawerWidget({
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 10);
  TransactionManager transactionManager = Get.put(TransactionManager());
  TransHistoryManager transHistoryManager = Get.put(TransHistoryManager());

  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  AuthManager authManager = Get.put(AuthManager());

  late Rx<String> selectedLanguage;

  @override
  void initState() {
    String temp = getIt<SharedPreferences>()
            .getString(SharedPrefKeyValue.selectedLanguage) ??
        'English';
    selectedLanguage = temp.obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDetails? userInfo = authManager.userDetails?.value;

    double h1p = widget.maxHeight * 0.01;
    double h10p = widget.maxHeight * 0.1;
    double w10p = widget.maxWidth * 0.1;
    return Drawer(
      backgroundColor: Colours.black,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(
                //   width: w10p * .5,
                // ),
                // SizedBox(
                //   height: h10p * 1,
                // ),
                ImageFromAssetPath<Widget>(
                  assetPath: ImageAssetpathConstant.xuritiWhite,
                  height: h10p * .4,
                ).imageWidget,
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      showMenu(
                        // color: Color.fromARGB(255, 242, 255, 4),
                        // shape: Border.all(
                        //   color: Colours.primary,
                        //   width: 2,
                        // ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7.0),
                          ),
                        ),
                        // Border.all(color: Colours.primary),

                        // shadowColor: Colours.primary,

                        context: context,
                        position:
                            RelativeRect.fromLTRB(w10p * 10, h10p * 1.2, 0, 0),
                        items: Languages.values
                            .map(
                              (item) => PopupMenuItem(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ImageFromAssetPath<Widget>(
                                              color: Colours.primary,
                                              assetPath: LocalLanguageCode
                                                  .getLanguageLetter(
                                                      languages: item.name),
                                              // 'assets/images/united-kingdom.png',
                                              height: h10p * .22,
                                              width: h10p * .25)
                                          .imageWidget,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    // Container(
                                    //   padding: EdgeInsets.all(10),
                                    //   margin:
                                    //       EdgeInsets.only(left: 2, right: 6),
                                    //   width: 1,
                                    //   // height: 20,
                                    //   decoration: BoxDecoration(
                                    //     color: Colours.black,
                                    //     border: Border(
                                    //       right: BorderSide(
                                    //         color: Colours.black,
                                    //         // width: 2,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    Expanded(
                                      flex: 2,
                                      child: ConstantText(
                                        // textAlign: TextAlign.center,
                                        text: item.name,
                                        fontWeight: FontWeight.w500,
                                        color: Colours.black,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  // Get.context?.setLocale(val)
                                  await Get.context?.setLocale(
                                      LocalLanguageCode.getLocalCode(
                                          languages: item));
                                  await Get.updateLocale(
                                      LocalLanguageCode.getLocalCode(
                                          languages: item));
                                  getIt<SharedPreferences>().setString(
                                      SharedPrefKeyValue.selectedLanguage,
                                      item.name);
                                  selectedLanguage.value = item.name;
                                },
                              ),
                            )
                            .toList(),
                      );
                    },
                    child: IntrinsicHeight(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        // margin: EdgeInsets.all(5),
                        // height: 30,
                        // width: w10p * 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ImageFromAssetPath<Widget>(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                assetPath:
                                    'assets/images/language-translation.svg',
                                // LocalLanguageCode.getLanguageFlag(
                                //     languages: selectedLanguage.value),
                                height: h10p * .2,
                              ).imageWidget,
                              Container(
                                // padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(left: 8, right: 6),
                                width: .5,
                                // height: 20,
                                decoration: BoxDecoration(
                                  color: Colours.white,
                                  border: Border(
                                    right: BorderSide(
                                      color: Colours.white,
                                      // width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              ConstantText(
                                text: selectedLanguage.value,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colours.primary,
                              ),
                              // SizedBox(
                              //   width: 5,
                              // ),
                              // Divider(
                              //   color: Colors.redAccent, //color of divider
                              //   height: 5, //height spacing of divider
                              //   thickness: 3, //thickness of divier line
                              //   indent: 25, //spacing at the start of divider
                              //   endIndent: 25, //spacing at the end of divider
                              // ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: h10p * .1,
          ),
          Container(
            color: Colours.almostBlack,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: h1p * 1.9, horizontal: w10p * .5),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, profile);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 1, color: Colors.orange)
                          //more than 50% of width makes circle
                          ),
                      child: CircleAvatar(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.orange,
                        radius: 50,
                        backgroundImage: ImageFromAssetPath<Widget>(
                          assetPath: ImageAssetpathConstant.avatar,
                        ).provider,
                      ),
                      //  Icon(
                      //   Icons.business_center,
                      //   color: Colours.tangerine,
                      // ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            companyListViewModel
                                    .selectedCompany.value?.companyName ??
                                "",
                            style: TextStyles.sName,
                          ),
                          ConstantText(
                            text: (userInfo == null || userInfo.user == null)
                                ? ""
                                : userInfo.user!.name ?? '',
                            style: TextStyles.textStyle21,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                // vertical: h10p * .6,
                //
                horizontal: w10p * .7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h1p * 5,
                ),
                InkWell(
                  onTap: () {
                    transactionManager.selectedSeller.value = null;
                    transHistoryManager.disposeInvoices();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (companyListContext) => CompanyList(
                          showBackButton: true,
                        ),
                      ),
                    );
                  },
                  child: const ConstantText(
                    text: stringConstant.switch_company,
                    style: TextStyles.textStyle98,
                  ),
                ),

                SizedBox(
                  height: h1p * 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, kycVerification);
                  },
                  child: const ConstantText(
                    text: stringConstant.kyc_verification,
                    style: TextStyles.textStyle98,
                  ),
                ),
                // SizedBox(
                //   height: h1p * 5,
                // ),
                // InkWell(
                //   onTap: () {
                //     Navigator.pushNamed(context, payment_history2);
                //   },
                //   child: const Text(
                //     "Payment History",
                //     style: TextStyles.textStyle98,
                //   ),
                // ),
                SizedBox(
                  height: h1p * 5,
                ),

                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, transactionalStatement);
                  },
                  child: const ConstantText(
                    text: stringConstant.transaction_statement,
                    style: TextStyles.textStyle98,
                  ),
                ),
                // SizedBox(
                //   height: h1p * 5,
                // ),

                // InkWell(
                //   onTap: () {
                //     Navigator.pushNamed(context, reportsAllSellers);
                //   },
                //   child: const Text(
                //     "Associated Seller",
                //     style: TextStyles.textStyle98,
                //   ),
                // ),
                // SizedBox(
                //   height: h1p * 5,
                // ),
                // const Text(
                //   "Help Center",
                //   style: TextStyles.textStyle98,
                // ),
                SizedBox(
                  height: h1p * 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ledgerInvoiceScreen);
                  },
                  child: const ConstantText(
                    text: stringConstant.transaction_ledger,
                    style: TextStyles.textStyle98,
                  ),
                ),
                SizedBox(
                  height: h1p * 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Credential()),
                      // MaterialPageRoute(
                      //   builder: (setNewPinContext) => SetNewPin(
                      //     isFromForgotPinFlow: false,
                      //     emailId:
                      //         authManager.userDetails?.value?.user?.email ?? "",
                      //   ),
                      // ),
                    );
                  },
                  child: const ConstantText(
                    text: stringConstant.account_credentials,
                    style: TextStyles.textStyle98,
                  ),
                ),

                ///
                SizedBox(
                  height: h1p * 5,
                ),

                ///
                // InkWell(
                //   onTap: () {
                //     Navigator.pushNamed(context, reportsAllSellers);
                //   },
                //   child: const Text(
                //     "Associated Seller",
                //     style: TextStyles.textStyle98,
                //   ),
                // ),
                // SizedBox(
                //   height: h1p * 5,
                // ),
                // const Text(
                //   "Help Center",
                //   style: TextStyles.textStyle98,
                // ),
                ///
                // SizedBox(
                //   height: h1p * 5,
                // ),
                InkWell(
                  onTap: () async {
                    Map<String, dynamic> data =
                        await getIt<ProfileManager>().getTermsAndConditions();
                    if (data['status'] == true) {
                      _launchInBrowser(Uri.parse(
                          "https://docs.google.com/gview?embedded=true&url=${data['url']}"));
                      Fluttertoast.showToast(msg: "Opening file");
                    }
                    Fluttertoast.showToast(msg: "Technical error occurred");
                    await getIt<TransactionManager>().openFile(
                        url:
                            "https://s3.ap-south-1.amazonaws.com/xuriti.public.document/xuritiTermsofService.pdf");

                    Fluttertoast.showToast(msg: "Opening file");
                  },
                  child: const ConstantText(
                    text: stringConstant.privacy_policy,
                    style: TextStyles.textStyle98,
                  ),
                ),

                // InkWell(
                //   onTap: () async {
                //     Map<String, dynamic> data =
                //         await getIt<ProfileManager>().getTermsAndConditions();
                //     if (data['status'] == true) {
                //       _launchInBrowser(Uri.parse(
                //           "https://docs.google.com/gview?embedded=true&url=${data['url']}"));
                //       Fluttertoast.showToast(msg: "Opening file");
                //     }
                //     Fluttertoast.showToast(msg: "Technical error occurred");
                //     await getIt<TransactionManager>().openFile(
                //         url:
                //             "https://s3.ap-south-1.amazonaws.com/xuriti.public.document/xuritiTermsofService.pdf");

                //     Fluttertoast.showToast(msg: "Opening file");

                //     // _launchInWebViewOrVC(Uri.parse(
                //     //     "https://s3.ap-south-1.amazonaws.com/xuriti.public.document/xuritiTermsofService.pdf"));
                //     // Map<String, dynamic> data =
                //     //     await getIt<ProfileManager>().getTermsAndConditions();

                //     // _launchInBrowser(Uri.parse(
                //     //     "https://s3.ap-south-1.amazonaws.com/xuriti.public.document/Xuriti+Terms+of+Service+(002).docx.pdf"));
                //     // Fluttertoast.showToast(msg: "Opening file");

                //     // Fluttertoast.showToast(msg: "Technical error occurred");
                //     //     const url =
                //     //         'https://s3.ap-south-1.amazonaws.com/xuriti.public.document/Xuriti+Terms+of+Service+(002).docx.pdf';

                //     // dynamic uri =  Uri.parse(url);
                //     //     if (await canLaunchUrl(uri )) {
                //     //       await launchUrl(Uri.parse(
                //     //         url,
                //     //       ));

                //     //       Fluttertoast.showToast(msg: "Opening file");
                //     //     } else {
                //     //       Fluttertoast.showToast(msg: "Technical error occurred");
                //     //     }
                //   },
                //   child: const Text(
                //     "Terms of Use",
                //     style: TextStyles.textStyle98,
                //   ),
                // ),
                // SizedBox(
                //   height: h1p * 5,
                // ),
                // const Text(
                //   "FAQs",
                //   style: TextStyles.textStyle98,
                // ),
                // SizedBox(
                //   height: h1p * 5,
                // ),
                // const Text(
                //   "FAQs",
                //   style: TextStyles.textStyle98,
                // ),
                SizedBox(
                  height: h1p * 5,
                ),
                InkWell(
                  onTap: () async {
                    final url = DioClient().contactUrl;
                    final uri = Uri.parse(url);

                    launchUrl(uri);
                  },
                  child: const ConstantText(
                    text: stringConstant.contact_us,
                    style: TextStyles.textStyle98,
                  ),
                ),
                // SizedBox(
                //   height: h1p * 5,
                // ),
                // const Text(
                //   "FAQs",
                //   style: TextStyles.textStyle98,
                // ),
                // SizedBox(
                //   height: h1p * 5,
                // ),
                // const Text(
                //   "FAQs",
                //   style: TextStyles.textStyle98,
                // ),
                SizedBox(
                  height: h1p * 5,
                ),
                InkWell(
                  onTap: () async {
                    final url = DioClient().launchUrl;
                    final uri = Uri.parse(url);

                    launchUrl(uri);
                  },
                  child: const ConstantText(
                    text: stringConstant.about_xuriti,
                    style: TextStyles.textStyle98,
                  ),
                ),
                // SizedBox(
                //   height: h1p * 5,
                // ),
                // InkWell(
                //   onTap: () {
                //     // Navigator.push(context,
                //     // MaterialPageRoute(builder: (_) => ChangeLanguage()));
                //     companyListViewModel.isBoxVisible.value = true;
                //     Navigator.pop(context);
                //   },
                //   child: const ConstantText(
                //     text: 'Change Language',
                //     style: TextStyles.textStyle98,
                //   ),
                // ),
                SizedBox(
                  height: h1p * 5,
                ),
                InkWell(
                  onTap: () async {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const ConstantText(
                            text: stringConstant.logging_out),
                        content: const ConstantText(
                            text: stringConstant.are_you_sure),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const ConstantText(
                              text: stringConstant.cancel,
                              style: TextStyle(color: Colours.tangerine),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await authManager.logOut();

                              Navigator.pushNamed(context, login);
                            },
                            child: const ConstantText(
                              text: stringConstant.ok,
                              style: TextStyle(color: Colours.tangerine),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const ConstantText(
                    text: stringConstant.logout,
                    style: TextStyles.textStyle98,
                  ),
                ),
                SizedBox(
                  height: h1p * 3,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
