import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/new%20modules/authModule/forgotPassword/verify_otp_screen.dart';

import 'package:xuriti/ui/screens/signup_and_login_screens/login_screen.dart';
import 'package:xuriti/util/common/key_value_sharedpreferences.dart';
import 'package:xuriti/util/common/string_constants.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import 'package:xuriti/util/validator/regular_expression.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final LoginOption loginOption;
  const ForgetPasswordScreen({Key? key, required this.loginOption})
      : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  AuthManager authManager = Get.put(AuthManager());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
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
          resizeToAvoidBottomInset: true,
          body: ListView(
            children: [
              SizedBox(
                height: h1p * 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 280, right: 20),
                child: Container(
                    height: h1p * 4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: ImageFromAssetPath<Widget>(
                              assetPath: ImageAssetpathConstant.xuriti1)
                          .provider,
                      fit: BoxFit.fill,
                    ))),
              ),
              SizedBox(
                height: h1p * 3,
              ),
              Container(
                width: maxWidth,
                height: maxHeight,
                decoration: const BoxDecoration(
                    color: Colours.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    )),
                child: Column(
                  children: [
                    Center(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: h1p * 3,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: w10p * .7,
                                  vertical: h1p * 3,
                                ),
                                child: Row(
                                  children: [
                                    ImageFromAssetPath<Widget>(
                                      assetPath:
                                          ImageAssetpathConstant.arrowLeft,
                                    ).imageWidget,
                                    SizedBox(
                                      width: w10p * 2,
                                    ),
                                    ConstantText(
                                      text:
                                          widget.loginOption == LoginOption.pin
                                              ? "Forgot PIN?"
                                              : "Forgot Password?",
                                      style: TextStyles.textStyle3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h1p * 3,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: w10p * 0.6,
                                  right: w10p * 0.6,
                                  bottom: h1p * 3),
                              child: ConstantText(
                                textAlign: TextAlign.center,
                                text: widget.loginOption == LoginOption.password
                                    ? weWillSendRecoveryLinkToMail
                                    : pleaseEnterEmailidToreceiveVerificationCode,
                              ),
                            ),
                            Container(
                              width: w10p * 9,
                              decoration: const BoxDecoration(
                                color: Colours.paleGrey,
                              ),
                              child: TextBoxField(
                                onSubmitted: (_) {},
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return please_enter_email_ID;
                                  } else if (!emailRegularExpression
                                      .hasMatch(value)) {
                                    return please_enter_valid_email_ID;
                                  }
                                  return null;
                                },
                                controller: emailController,
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                fillColor: Colours.paleGrey,
                                hintText: email_id,
                                hintStyle: TextStyles.textStyle4,
                              ),
                            ),
                            SizedBox(
                              height: h10p * .5,
                            ),
                            InkWell(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  // Fluttertoast.showToast(
                                  //   msg: "Please enter email id",
                                  //   // textColor: Colors.green
                                  // );
                                  if (widget.loginOption ==
                                      LoginOption.password) {
                                    Map<String, dynamic> forgetPassword =
                                        await authManager.forgotPassword(
                                            email: emailController.text);
                                    print(forgetPassword);
                                    context.hideLoader();
                                    // progress.dismiss();
                                    if (forgetPassword['status'] == true) {
                                      Fluttertoast.showToast(
                                          msg: forgetPassword['message']
                                              .toString(),
                                          textColor: Colors.green);
                                      await getIt<SharedPreferences>().setBool(
                                          SharedPrefKeyValue
                                              .recentLoggedUserIsPinSet,
                                          false);
                                      Navigator.of(context)
                                          .pushReplacementNamed(login);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: forgetPassword['message']
                                              .toString(),
                                          textColor: Colors.red);
                                    }
                                  } else {
                                    context.showLoader();
                                    Map<String, dynamic>? forgotPinResponse =
                                        await authManager.forgotPin(
                                            email: emailController.text);
                                    context.hideLoader();
                                    if (forgotPinResponse?["status"] == true) {
                                      Fluttertoast.showToast(
                                          timeInSecForIosWeb: 8,
                                          msg: verificationCodeSentSuccessfully
                                          // "Verification code sent successully to registered Email Id"
                                          );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (verifyContext) =>
                                              VerifyOTPScreen(
                                            emailID: emailController.text,
                                          ),
                                        ),
                                      );
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: forgotPinResponse?["message"]);
                                    }
                                  }
                                }
                              },
                              child: Container(
                                width: w10p * 3,
                                padding:
                                    EdgeInsets.symmetric(vertical: h1p * 1),
                                child: const Center(
                                    child: ConstantText(
                                        text: continue_text,
                                        style: TextStyles.textStyle5)),
                                decoration: BoxDecoration(
                                    color: Colours.primary,
                                    borderRadius: BorderRadius.circular(7)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
