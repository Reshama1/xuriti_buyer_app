import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/user_details.dart';
import 'package:xuriti/ui/routes/router.dart';
import '../../../logic/view_models/auth_manager.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TransactionManager transactionManager = Get.put(TransactionManager());
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  AuthManager authManager = Get.put(AuthManager());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      UserDetails? userInfo = authManager.userDetails?.value;
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      double w1p = maxWidth * 0.01;
      return Scaffold(
          backgroundColor: Colours.black,
          appBar: AppBar(
            backgroundColor: Colours.black,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: ImageFromAssetPath<Widget>(
                assetPath: ImageAssetpathConstant.xuritiLogo,
              ).imageWidget,
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.all(18),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ImageFromAssetPath<Widget>(
                              assetPath: ImageAssetpathConstant.menuButtonClose)
                          .imageWidget)),
            ],
          ),
          body: ProgressHUD(child: Builder(builder: (context) {
            return Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: w1p * 4, vertical: h1p * 1),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: ImageFromAssetPath<Widget>(
                          assetPath: ImageAssetpathConstant.avatar,
                        ).provider,
                      ),
                      SizedBox(
                        width: w1p * 5,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              (userInfo == null || userInfo.user == null)
                                  ? ""
                                  : userInfo.user!.name ?? '',
                              style: TextStyles.textStyle49,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, editProfile);
                              },
                              child: const AutoSizeText(
                                view_profile,
                                style: TextStyles.textStyle50,
                              ),
                            ),
                            AutoSizeText(
                              companyListViewModel
                                      .selectedCompany.value?.companyName ??
                                  "",
                              style: TextStyles.textStyle52,
                            ),
                            AutoSizeText(
                              (userInfo == null ||
                                      userInfo.user == null ||
                                      userInfo.user!.mobileNumber == null)
                                  ? ""
                                  : userInfo.user!.mobileNumber.toString(),
                              style: TextStyles.textStyle52,
                            ),
                            AutoSizeText(
                              (userInfo == null ||
                                      userInfo.user == null ||
                                      userInfo.user!.email == null)
                                  ? ""
                                  : userInfo.user!.email ?? '',
                              style: TextStyles.textStyle52,
                            ),
                          ],
                        ),
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
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          elevation: 1,
                          child: Container(
                            width: w10p * 70,
                            height: h10p * 1.7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: Colours.offWhite),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ImageFromAssetPath<Widget>(
                                              assetPath: ImageAssetpathConstant
                                                  .polygon1)
                                          .imageWidget,
                                      const ConstantText(
                                        text: "you have got",
                                        style: TextStyles.textStyle16,
                                      ),
                                      const ConstantText(
                                        text: free_credit_period,
                                        style: TextStyles.textStyle53,
                                      ),
                                      const ConstantText(
                                        text: " extension ",
                                        style: TextStyles.textStyle16,
                                      ),
                                      ImageFromAssetPath<Widget>(
                                              assetPath: ImageAssetpathConstant
                                                  .polygon1)
                                          .imageWidget,
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      ConstantText(
                                        text: "of",
                                        style: TextStyles.textStyle16,
                                      ),
                                      ConstantText(
                                        text: "60 days",
                                        style: TextStyles.textStyle53,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: h1p * .5,
                                  ),
                                  ConstantText(
                                    text: completeEarlyInvoices,
                                    style: TextStyles.textStyle48,
                                  ),
                                  ConstantText(
                                    text: maximumSavingAndMoreRewards,
                                    style: TextStyles.textStyle48,
                                  ),
                                  SizedBox(
                                    height: h1p * 0.5,
                                  ),
                                  ConstantText(
                                    text: applicableOnlyOnSelectSeller,
                                    style: TextStyles.textStyle48,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 24, top: 18),
                        child: ConstantText(
                          text: business_details,
                          style: TextStyles.textStyle43,
                        ),
                      ),
                      SizedBox(
                        height: h1p * 4,
                      ),
                      Card(
                        elevation: 2,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: w1p * 6.5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: h1p * 1,
                                ),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      company_name,
                                      style: TextStyles.textStyle54,
                                    ),
                                    AutoSizeText(
                                      companyListViewModel.selectedCompany.value
                                              ?.companyName ??
                                          "",
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h1p * .5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      address,
                                      style: TextStyles.textStyle54,
                                    ),
                                    Expanded(
                                      child: AutoSizeText(
                                        companyListViewModel.selectedCompany
                                                .value?.address ??
                                            "",
                                        style: TextStyles.textStyle55,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h1p * .5,
                                ),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      pan_number,
                                      style: TextStyles.textStyle54,
                                    ),
                                    AutoSizeText(
                                      companyListViewModel
                                              .selectedCompany.value?.pan ??
                                          "",
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h1p * .5,
                                ),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      district,
                                      style: TextStyles.textStyle54,
                                    ),
                                    AutoSizeText(
                                      companyListViewModel.selectedCompany.value
                                              ?.district ??
                                          "",
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h1p * .5,
                                ),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      state,
                                      style: TextStyles.textStyle54,
                                    ),
                                    AutoSizeText(
                                      companyListViewModel
                                              .selectedCompany.value?.state ??
                                          "",
                                      style: TextStyles.textStyle55,
                                    ),
                                    SizedBox(
                                      width: w10p * 1.7,
                                    ),
                                    const AutoSizeText(
                                      pin_code,
                                      style: TextStyles.textStyle54,
                                    ),
                                    AutoSizeText(
                                      companyListViewModel
                                              .selectedCompany.value?.pincode ??
                                          "",
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h1p * .5,
                                ),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      type_of_business,
                                      style: TextStyles.textStyle54,
                                    ),
                                    AutoSizeText(
                                      companyListViewModel
                                              .selectedCompany.value?.status ??
                                          "",
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h1p * 3,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h1p * 6,
                      )
                    ],
                  ),
                ),
              ),
            ]);
          })));
    });
  }
}
