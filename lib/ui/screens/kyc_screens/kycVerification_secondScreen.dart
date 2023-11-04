import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/logic/view_models/kyc_manager.dart';
import 'package:xuriti/ui/screens/kyc_screens/kyc_submission_screen.dart';
import 'package:xuriti/util/common/string_constants.dart';
import '../../../logic/view_models/transaction_manager.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/kyc_details.dart';

class KycVerificationNextStep extends StatefulWidget {
  const KycVerificationNextStep({Key? key}) : super(key: key);

  @override
  State<KycVerificationNextStep> createState() =>
      _KycVerificationNextStepState();
}

class _KycVerificationNextStepState extends State<KycVerificationNextStep> {
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  TransactionManager transactionManager = Get.put(TransactionManager());
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
    return LayoutBuilder(builder: (context, constraints) {
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
                child: Builder(builder: (context) {
                  return Container(
                    width: maxWidth,
                    decoration: const BoxDecoration(
                        color: Colours.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )),
                    child: Obx(() {
                      return ListView(
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
                                          AutoSizeText(
                                            companyListViewModel.selectedCompany
                                                    .value?.companyName ??
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
                          InkWell(
                            onTap: () async {
                              await Navigator.pushNamed(
                                  context, residenceProof);
                              // if (err.runtimeType == bool) {
                              //   setState(() {
                              //     details?['residence']?['verified'] =
                              //         err ? false : true;
                              //   });
                              // }
                            },
                            child: KycDetails(
                              title: residence_proof,
                              maxWidth: maxWidth,
                              maxHeight: maxHeight,
                              isMandatory: true,
                              kycStatus: ((kycManager
                                              .kycStatusModel
                                              ?.value
                                              ?.data
                                              ?.residence
                                              ?.files
                                              ?.length ??
                                          0) >
                                      0 ||
                                  (kycManager.kycStatusModel?.value?.data
                                          ?.residence?.verified ??
                                      false)),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await Navigator.pushNamed(context, businessProof);
                              // var companyId = getIt<SharedPreferences>()
                              //     .getString('companyId');
                              // dynamic responseData =
                              //     await getIt<DioClient>().KycDetails(companyId!);
                              // if (err.runtimeType == bool) {
                              //   setState(() {
                              //     details?['business']?['verified'] =
                              //         err ? false : true;
                              //     // kycStatus = KycStatus.fromJson(details);
                              //   });
                              // }
                            },
                            child: KycDetails(
                              title: business_proof,
                              subtitle: any_one_of_the_following,
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                              isMandatory: true,
                              kycStatus: ((kycManager.kycStatusModel?.value
                                              ?.data?.business?.files?.length ??
                                          0) >
                                      0 ||
                                  (kycManager.kycStatusModel?.value?.data
                                          ?.business?.verified ??
                                      false)), //kycStatus?.businessStatus,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await Navigator.pushNamed(
                                  context, ownershipProof);
                              // var companyId = getIt<SharedPreferences>()
                              //     .getString('companyId');
                              // dynamic responseData =
                              //     await getIt<DioClient>().KycDetails(companyId!);
                              // if (err.runtimeType == bool) {
                              //   setState(() {
                              //     details?['ownership']?['verified'] =
                              //         err ? false : true;
                              //     // kycStatus = KycStatus.fromJson(details);
                              //   });
                              // }
                            },
                            child: KycDetails(
                              title: ownership_proof,
                              subtitle: business_residence_any_one,
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                              isMandatory: true,
                              kycStatus: ((kycManager
                                              .kycStatusModel
                                              ?.value
                                              ?.data
                                              ?.ownership
                                              ?.files
                                              ?.length ??
                                          0) >
                                      0 ||
                                  (kycManager.kycStatusModel?.value?.data
                                          ?.ownership?.verified ??
                                      false)), //kycStatus?.ownershipStatus,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await Navigator.pushNamed(context, vintageProof);
                              // var companyId = getIt<SharedPreferences>()
                              //     .getString('companyId');
                              // dynamic responseData =
                              //     await getIt<DioClient>().KycDetails(companyId!);
                              // if (err.runtimeType == bool) {
                              //   setState(() {
                              //     details?['vintage']?['verified'] =
                              //         err ? false : true;
                              //     // kycStatus = KycStatus.fromJson(details);
                              //   });
                              // }
                            },
                            child: KycDetails(
                              title: vintage_proof,
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                              isMandatory: true,
                              kycStatus: ((kycManager.kycStatusModel?.value
                                              ?.data?.vintage?.files?.length ??
                                          0) >
                                      0 ||
                                  (kycManager.kycStatusModel?.value?.data
                                          ?.vintage?.verified ??
                                      false)), //kycStatus?.vintageStatus,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await Navigator.pushNamed(context, firmDetails);
                              // var companyId = getIt<SharedPreferences>()
                              //     .getString('companyId');
                              // dynamic responseData =
                              //     await getIt<DioClient>().KycDetails(companyId!);
                              // if (err.runtimeType == bool) {
                              //   setState(() {
                              //     details?['partnership']?['verified'] =
                              //         err ? false : true;
                              //     // kycStatus = KycStatus.fromJson(details);
                              //   });
                              // }
                            },
                            child: KycDetails(
                              title: firm_partnership_details,
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                              isMandatory: true,
                              kycStatus: ((kycManager
                                              .kycStatusModel
                                              ?.value
                                              ?.data
                                              ?.partnership
                                              ?.files
                                              ?.length ??
                                          0) >
                                      0 ||
                                  (kycManager.kycStatusModel?.value?.data
                                          ?.partnership?.verified ??
                                      false)), //kycStatus?.partnershipStatus,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await Navigator.pushNamed(context, bankDetails);
                              // var companyId = getIt<SharedPreferences>()
                              //     .getString('companyId');
                              // dynamic responseData =
                              //     await getIt<DioClient>().KycDetails(companyId!);
                              // if (err.runtimeType == bool) {
                              //   setState(() {
                              //     details?['bankStatement']?['verified'] =
                              //         err ? false : true;
                              //     // kycStatus = KycStatus.fromJson(details);
                              //   });
                              // }
                            },
                            child: KycDetails(
                              title: banking_details,
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                              isMandatory: true,
                              kycStatus: ((kycManager
                                              .kycStatusModel
                                              ?.value
                                              ?.data
                                              ?.bankStatement
                                              ?.files
                                              ?.length ??
                                          0) >
                                      0 ||
                                  (kycManager.kycStatusModel?.value?.data
                                          ?.bankStatement?.verified ??
                                      false)), //kycStatus?.bankStatementStatus,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await Navigator.pushNamed(context, chequeDetails);
                              // var companyId = getIt<SharedPreferences>()
                              //     .getString('companyId');
                              // dynamic responseData =
                              //     await getIt<DioClient>().KycDetails(companyId!);
                              // if (err.runtimeType == bool) {
                              //   setState(() {
                              //     details?['chequeImages']?['verified'] =
                              //         err ? false : true;
                              //     // kycStatus = KycStatus.fromJson(details);
                              //   });
                              // }
                            },
                            child: KycDetails(
                              title: cheque,
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                              isMandatory: true,
                              kycStatus: ((kycManager
                                              .kycStatusModel
                                              ?.value
                                              ?.data
                                              ?.chequeImages
                                              ?.files
                                              ?.length ??
                                          0) >
                                      0 ||
                                  (kycManager.kycStatusModel?.value?.data
                                          ?.chequeImages?.verified ??
                                      false)),
                            ),
                          ),
                          InkWell(
                              onTap: () async {
                                await Navigator.pushNamed(
                                    context, finGstDetails);
                                // var companyId = getIt<SharedPreferences>()
                                //     .getString('companyId');
                                // dynamic responseData = await getIt<DioClient>()
                                //     .KycDetails(companyId!);
                                // if (err.runtimeType == bool) {
                                //   setState(() {
                                //     details?['financial']?['verified'] =
                                //         err ? false : true;
                                //     // kycStatus = KycStatus.fromJson(details);
                                //   });
                                // }
                              },
                              child: KycDetails(
                                  title: financial_and_gst,
                                  maxHeight: maxHeight,
                                  maxWidth: maxWidth,
                                  isMandatory: true,
                                  kycStatus: (kycManager
                                                  .kycStatusModel
                                                  ?.value
                                                  ?.data
                                                  ?.financial
                                                  ?.files
                                                  ?.length ??
                                              0) >
                                          0 ||
                                      (kycManager.kycStatusModel?.value?.data
                                              ?.financial?.verified ??
                                          false))),
                          InkWell(
                              onTap: () async {
                                await Navigator.pushNamed(context, storeImages);
                                // var companyId = getIt<SharedPreferences>()
                                //     .getString('companyId');
                                // dynamic responseData = await getIt<DioClient>()
                                //     .KycDetails(companyId!);
                                // if (err.runtimeType == bool) {
                                //   setState(() {
                                //     details?['storeImages']?['verified'] =
                                //         err ? false : true;
                                //     // kycStatus = KycStatus.fromJson(details);
                                //   });
                                // }
                              },
                              child: KycDetails(
                                  title: upload_store_image,
                                  maxHeight: maxHeight,
                                  maxWidth: maxWidth,
                                  isMandatory: true,
                                  kycStatus: ((kycManager
                                                  .kycStatusModel
                                                  ?.value
                                                  ?.data
                                                  ?.storeImages
                                                  ?.files
                                                  ?.length ??
                                              0) >
                                          0 ||
                                      (kycManager.kycStatusModel?.value?.data
                                              ?.financial?.verified ??
                                          false)))),
                          SizedBox(
                            height: h1p * 3,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: w1p * 3, right: w1p * 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // Navigator.pushNamed(context, kycVerification);
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: const [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Icon(
                                          Icons.keyboard_arrow_left_rounded,
                                          size: 30,
                                        ),
                                      ),
                                      ConstantText(
                                        text: prev,
                                        style: TextStyles.textStyle44,
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => KycSubmission(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: h1p * 10,
                          ),
                        ],
                      );
                    }),
                  );
                }),
              )));
    });
  }
}
