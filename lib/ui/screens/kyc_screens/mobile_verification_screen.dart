import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/util/common/string_constants.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../logic/view_models/kyc_manager.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/submitt_button.dart';

class MobileVerification extends StatefulWidget {
  const MobileVerification({Key? key}) : super(key: key);

  @override
  State<MobileVerification> createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  GlobalKey<FormState> mobileNumberState = GlobalKey<FormState>();
  GlobalKey<FormState> otpState = GlobalKey<FormState>();

  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  KycManager kycManager = Get.put(KycManager());

  //these are validations only for format(only no allowed 4 digits) and not actual correctness of otp
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      kycManager.getKycStatusDetails();
    });

    kycManager.kycStatusModel?.listen((p0) {
      numberController.text = p0?.data?.mobile?.number ?? "";
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
                                horizontal: w1p * 3, vertical: h1p * 3),
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
                                  text: mobile_verification,
                                  style: TextStyles.leadingText,
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              left: w1p * 6, right: w1p * 6, top: h1p * 3),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x26000000),
                                    offset: Offset(0, 1),
                                    blurRadius: 1,
                                    spreadRadius: 0)
                              ],
                              color: Colours.paleGrey,
                            ),
                            child: Form(
                              key: mobileNumberState,
                              child: TextBoxField(
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (mobileNumber) {
                                  return (mobileNumber?.length ?? 0) != 0
                                      ? (int.tryParse(mobileNumber ?? "") !=
                                              null
                                          ? null
                                          : ((mobileNumber?.length ?? 0) != 10
                                              ? enter_valid_mobile_number
                                              : null))
                                      : please_enter_mobile_number_to_continue;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                controller: numberController,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: w1p * 6, vertical: h1p * .5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                fillColor: Colours.paleGrey,
                                hintText: mobile_number,
                                hintStyle: TextStyles.textStyle120,
                              ),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () async {
                            otpController.text = "";
                            if (mobileNumberState.currentState?.validate() ==
                                true) {
                              context.showLoader();
                              Map<String, dynamic> kyc = await kycManager
                                  .generateOTP(numberController.text);
                              context.hideLoader();
                              Fluttertoast.showToast(msg: kyc['msg']);
                            }
                          },
                          child: Submitbutton(
                              maxWidth: maxWidth,
                              maxHeight: maxHeight,
                              content: generate_OTP,
                              isKyc: true,
                              active: true),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              left: w1p * 6, right: w1p * 6, top: h1p * 3),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0x26000000),
                                    offset: Offset(0, 1),
                                    blurRadius: 1,
                                    spreadRadius: 0)
                              ],
                              color: Colours.paleGrey,
                            ),
                            child: Form(
                              key: otpState,
                              child: TextBoxField(
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (otpValue) {
                                  return (otpValue?.length ?? 0) != 0
                                      ? ((int.tryParse(otpValue ?? "") != null
                                          ? null
                                          : ((otpController.text.length >= 4 &&
                                                  otpController.text.length <=
                                                      6)
                                              ? null
                                              : please_enter_valid_otp)))
                                      : please_enter_otp_to_continue;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                controller: otpController,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: w1p * 6, vertical: h1p * .5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                fillColor: Colours.paleGrey,
                                hintText: otp,
                                hintStyle: TextStyles.textStyle120,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: h1p * 3,
                        // ),
                        InkWell(
                          onTap: () async {
                            if (mobileNumberState.currentState?.validate() ==
                                    true &&
                                otpState.currentState?.validate() == true) {
                              context.showLoader();
                              Map<String, dynamic> otpDetails =
                                  await kycManager.verifyOTP(
                                otpController.text,
                                numberController.text,
                              );
                              context.hideLoader();
                              Fluttertoast.showToast(msg: otpDetails['msg']);
                              if (otpDetails['error'] == false) {
                                Navigator.pop(context, false);
                                kycManager.getKycStatusDetails();
                              }
                            }
                          },
                          child: Submitbutton(
                            maxWidth: maxWidth,
                            maxHeight: maxHeight,
                            isKyc: true,
                            content: verify_OTP,
                            active: true,
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
