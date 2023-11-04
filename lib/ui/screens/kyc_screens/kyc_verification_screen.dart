import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/ui/screens/kyc_screens/aadhaar_card_screen.dart';
import '../../../logic/view_models/kyc_manager.dart';
import '../../../logic/view_models/transaction_manager.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/kyc_details.dart';

class KycVerification extends StatefulWidget {
  const KycVerification({Key? key}) : super(key: key);

  @override
  State<KycVerification> createState() => _KycVerificationState();
}

class _KycVerificationState extends State<KycVerification> {
  TransactionManager transactionManager = Get.put(TransactionManager());
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());

  KycManager kycManager = Get.put(KycManager());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      kycManager.getKycStatusDetails();
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
        double h10p = maxHeight * 0.1;
        double w10p = maxWidth * 0.1;
        double w1p = maxWidth * 0.01;
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colours.black,
            appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                toolbarHeight: h10p * .9,
                flexibleSpace: AppbarWidget()),
            body: ProgressHUD(
              child: Builder(
                builder: (context) {
                  return Container(
                    width: maxWidth,
                    decoration: const BoxDecoration(
                        color: Colours.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )),
                    child: ListView(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w1p * 4, vertical: h1p * 3),
                            child: Row(
                              children: [
                                ImageFromAssetPath<Widget>(
                                        assetPath:
                                            ImageAssetpathConstant.arrowLeft)
                                    .imageWidget,
                                SizedBox(
                                  width: w10p * .3,
                                ),
                                const ConstantText(
                                  text: kyc_verification,
                                  style: TextStyles.leadingText,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: w1p * 2,
                          ),
                          child: Container(
                            height: h10p * 1.1,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0x66000000),
                                    offset: Offset(0, 1),
                                    blurRadius: 1,
                                    spreadRadius: 0)
                              ],
                              borderRadius: BorderRadius.circular(16),
                              color: Colours.offWhite,
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w1p * 3),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ImageFromAssetPath<Widget>(
                                          assetPath:
                                              ImageAssetpathConstant.logo1)
                                      .imageWidget,
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ConstantText(
                                          text: companyListViewModel
                                                  .selectedCompany
                                                  .value
                                                  ?.companyName ??
                                              "",
                                          style: TextStyles.textStyle116,
                                        ),
                                        ConstantText(
                                          text:
                                              submit_following_document_to_completeKYC,
                                          style: TextStyles.textStyle117,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          return InkWell(
                            onTap: () async {
                              await Navigator.pushNamed(context, panDetails);
                            },
                            child: KycDetails(
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                              title: pan_verification,
                              isMandatory: true,
                              kycStatus: kycManager.kycStatusModel?.value?.data
                                      ?.pan?.verified ??
                                  false,
                            ),
                          );
                        }),
                        Obx(
                          () {
                            return InkWell(
                              onTap: () async {
                                await kycManager.getCaptcha();

                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (__) => AadhaarCard(),
                                  ),
                                );
                              },
                              child: KycDetails(
                                title: aadhaar_verification,
                                maxHeight: maxHeight,
                                maxWidth: maxWidth,
                                isMandatory: true,
                                kycStatus: kycManager.kycStatusModel?.value
                                        ?.data?.aadhar?.verified ??
                                    false,
                              ),
                            );
                          },
                        ),
                        Obx(
                          () {
                            return InkWell(
                              onTap: () async {
                                await Navigator.pushNamed(
                                    context, mobileVerification);
                              },
                              child: KycDetails(
                                title: mobile_verification,
                                maxHeight: maxHeight,
                                maxWidth: maxWidth,
                                isMandatory: true,
                                kycStatus: kycManager.kycStatusModel?.value
                                        ?.data?.mobile?.verified ??
                                    false,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: h1p * 3,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: w1p * 3, right: w1p * 3),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, kycnextstep);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                ConstantText(
                                  text: next,
                                  style: TextStyles.textStyle44,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
