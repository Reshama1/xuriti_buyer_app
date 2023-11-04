import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/new%20modules/authModule/forgotPassword/set_new_pin.dart';
import 'package:xuriti/new%20modules/common_widget.dart';
import 'package:xuriti/new%20modules/image_assetpath_constants.dart';
import 'package:xuriti/util/common/text_constant_widget.dart';
import 'package:xuriti/util/common/widget_constants.dart';
import 'package:xuriti/util/loaderWidget.dart';

import '../../../ui/theme/constants.dart';
import '../../../util/common/string_constants.dart';

class VerifyOTPScreen extends StatefulWidget {
  final String emailID;
  const VerifyOTPScreen({Key? key, required this.emailID}) : super(key: key);

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final TextEditingController verifyOtpFieldController =
      TextEditingController();

  AuthManager authManager = Get.put(AuthManager());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // otpFieldState.fo.setFocus(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.black,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10.0),
              color: Colours.black,
              child: Align(
                alignment: Alignment.centerRight,
                child: ImageFromAssetPath<Widget>(
                  assetPath: ImageAssetpathConstant.xuriti1,
                  height: MediaQuery.of(context).size.height * 0.04,
                ).imageWidget,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      26.0,
                    ),
                    topRight: Radius.circular(
                      26.0,
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20.0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: ImageFromAssetPath<Widget>(
                                assetPath: ImageAssetpathConstant.arrowLeft,
                              ).imageWidget,
                            ),
                            Expanded(
                              child: ConstantText(
                                textAlign: TextAlign.center,
                                text: verify_OTP,
                                style: TextStyles.textStyle3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 40.0,
                          bottom: 40.0,
                        ),
                        child: ConstantText(
                          textAlign: TextAlign.center,
                          text: pleaseEnterVerificationCode,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 10.0,
                          bottom: 20.0,
                        ),
                        child: Pinput(
                          controller: verifyOtpFieldController,
                          obscureText: false,
                          defaultPinTheme: defaultPinTheme().copyWith(
                            decoration: defaultPinTheme().decoration!.copyWith(
                                  color: Colours.fillColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Color(0xffa2a2d0)),
                                ),
                          ),
                          focusedPinTheme: defaultPinTheme().copyWith(
                            decoration: defaultPinTheme().decoration!.copyWith(
                                  color: Colours.fillColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colours.pumpkin),
                                ),
                          ),
                          submittedPinTheme: defaultPinTheme().copyWith(
                            decoration: defaultPinTheme().decoration!.copyWith(
                                  color: Colours.fillColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Color(0xffa2a2d0)),
                                ),
                          ),
                          errorPinTheme: defaultPinTheme().copyBorderWith(
                            border: Border.all(color: Colors.redAccent),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          showCursor: true,
                          isCursorAnimationEnabled: true,
                          closeKeyboardWhenCompleted: true,
                          length: 6,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          onCompleted: (pin) => print(pin),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          verifyOtpFieldController.text = "";
                          context.showLoader();
                          await authManager.forgotPin(email: widget.emailID);
                          Fluttertoast.showToast(
                            msg:
                                // "Verification code resent to registered Email Id.",
                                verifictionCodeResentSuccessfully,
                          );

                          context.hideLoader();
                        },
                        child: ConstantText(
                          text: resend,
                          color: Colours.pumpkin,
                          fontWeight: FontWeight.w600,
                          style: TextStyles.textStyle4,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () async {
                          _verifyEnteredOTP();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 50,
                          padding: EdgeInsets.all(
                            13.0,
                          ),
                          child: ConstantText(
                            textAlign: TextAlign.center,
                            text: verify,
                            style: TextStyles.textStyle5,
                          ),
                          decoration: BoxDecoration(
                            color: Colours.primary,
                            borderRadius: BorderRadius.circular(
                              7,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _verifyEnteredOTP() async {
    if (verifyOtpFieldController.text.isEmpty ||
        verifyOtpFieldController.text.length != 6) {
      Fluttertoast.showToast(msg: pleaseEnterValidVerificationCode);
      return;
    }

    context.showLoader();
    Map<String, dynamic>? verificationResponse =
        await authManager.verifyOTPCodeWithForgetPinFlow(
      emailId: widget.emailID,
      otp: verifyOtpFieldController.text,
    );
    context.hideLoader();

    if (verificationResponse?["status"] == true) {
      Fluttertoast.showToast(msg: verification_code_verified);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (setNewPinContext) => SetNewPin(
            emailId: widget.emailID,
            isFromForgotPinFlow: true,
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: invalid_verification_code);
    }
  }
}
