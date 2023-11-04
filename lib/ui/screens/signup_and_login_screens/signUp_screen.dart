import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/new%20modules/authModule/splashScreen/success_failure_splash_screen.dart';
import 'package:xuriti/util/common/key_value_sharedpreferences.dart';
import 'package:xuriti/util/common/string_constants.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../logic/view_models/auth_manager.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../../util/validator/regular_expression.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';

class SignUpScreen extends StatefulWidget {
  final bool? navigatedFromSignupGoogleButtonTapped;
  const SignUpScreen(
      {Key? key, required this.navigatedFromSignupGoogleButtonTapped})
      : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController eMailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode mobileNumberFocusNode = FocusNode();
  FocusNode verifyOTPFocusNode = FocusNode();

  Rx<FocusNode?> currentSelectedFocusNode = RxNullable<FocusNode?>().setNull();

  // OtpFieldController pinFieldController = OtpFieldController();
  // RxString pinValue = "".obs;
  // RxString confirmPinValue = "".obs;

  RxBool showPassword = false.obs;
  RxBool showConfirmPassword = false.obs;

  AuthManager authManager = Get.put(AuthManager());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
// GlobalKey<FormState> mobileKey = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authManager.otpVerificationStatusForMobileNumber =
          OTPVerificationStatus().obs;
    });

    if (widget.navigatedFromSignupGoogleButtonTapped == true) {
      eMailController.text = authManager.user.email;
      firstNameController.text =
          authManager.user.displayName?.split(" ").first ?? "";
      lastNameController.text =
          authManager.user.displayName?.split(" ").last ?? "";
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;

      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: ImageFromAssetPath<Widget>(
                assetPath: ImageAssetpathConstant.xuritiLogo,
              ).imageWidget,
            )
          ],
        ),
        backgroundColor: Colours.black,
        body: Form(
          key: formKey,
          child: Container(
            width: maxWidth,
            height: maxHeight,
            decoration: const BoxDecoration(
              color: Colours.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26),
                topRight: Radius.circular(26),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Obx(() {
                  currentSelectedFocusNode;
                  return Column(
                    children: [
                      // if (Platform.isIOS)
                      Padding(
                        padding:
                            EdgeInsets.only(right: 10.0, top: 20, bottom: 30),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (Platform.isIOS)
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: ImageFromAssetPath(
                                        assetPath:
                                            ImageAssetpathConstant.arrowLeft)
                                    .imageWidget,
                              ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: ConstantText(
                                  textAlign: TextAlign.center,
                                  text: signup,
                                  style: TextStyles.textStyle3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextBoxField(
                                  onTap: () {
                                    currentSelectedFocusNode.value =
                                        firstNameFocusNode;
                                  },
                                  autoValidateMode: currentSelectedFocusNode ==
                                          firstNameFocusNode
                                      ? AutovalidateMode.onUserInteraction
                                      : null,
                                  focusNode: firstNameFocusNode,
                                  validator: (firstName) {
                                    if (firstNameFocusNode.hasFocus) {
                                      return null;
                                    }
                                    return (firstName?.length ?? 0) == 0
                                        ? please_enter_first_name
                                        : (firstNameLastNameRegularExpression
                                                    .hasMatch(
                                                        firstName ?? "") ==
                                                true
                                            ? null
                                            : please_enter_valid_first_name);
                                  },
                                  controller: firstNameController,
                                  textStyle: TextStyles.textStyle4,
                                  errorStyle: TextStyle(fontSize: 12.0),
                                  prefix: const Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 8,
                                  ),
                                  fillColor: Colours.paleGrey,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: first_name,
                                ),
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              Expanded(
                                child: TextBoxField(
                                  onTap: () {
                                    currentSelectedFocusNode.value =
                                        lastNameFocusNode;
                                  },
                                  autoValidateMode: currentSelectedFocusNode ==
                                          lastNameFocusNode
                                      ? AutovalidateMode.onUserInteraction
                                      : null,
                                  validator: (lastName) {
                                    if (lastNameFocusNode.hasFocus) {
                                      return null;
                                    }
                                    return (lastName?.length ?? 0) == 0
                                        ? please_enter_first_name
                                        : (firstNameLastNameRegularExpression
                                                    .hasMatch(lastName ?? "") ==
                                                true
                                            ? null
                                            : please_enter_valid_first_name);
                                  },
                                  controller: lastNameController,
                                  textStyle: TextStyles.textStyle4,
                                  errorStyle: TextStyle(fontSize: 12.0),
                                  prefix: const Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 8,
                                  ),
                                  fillColor: Colours.paleGrey,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: last_name,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      TextBoxField(
                        onTap: () {
                          currentSelectedFocusNode.value = emailFocusNode;
                        },
                        autoValidateMode:
                            currentSelectedFocusNode == emailFocusNode
                                ? AutovalidateMode.onUserInteraction
                                : null,
                        validator: (email) {
                          if (emailFocusNode.hasFocus) {
                            return null;
                          }
                          return (email?.length ?? 0) == 0
                              ? please_enter_email_ID
                              : (emailRegularExpression.hasMatch(email ?? "") ==
                                      true
                                  ? null
                                  : please_enter_valid_email_ID);
                        },
                        controller: eMailController,
                        textStyle: TextStyles.textStyle4,
                        errorStyle: TextStyle(fontSize: 12.0),
                        prefix: const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 8,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Colours.paleGrey,
                        filled: true,
                        hintText: email_id,
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      TextBoxField(
                        onTap: () {
                          currentSelectedFocusNode.value =
                              mobileNumberFocusNode;
                        },
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        autoValidateMode:
                            currentSelectedFocusNode == mobileNumberFocusNode
                                ? AutovalidateMode.onUserInteraction
                                : null,
                        validator: (phoneNumber) {
                          return (phoneNumber?.length ?? 0) == 0
                              ? please_enter_mobile_number
                              : (mobileNumberRegularExpression
                                          .hasMatch(phoneNumber ?? "") ==
                                      true
                                  ? ((phoneNumber?.length ?? 0) == 10
                                      ? null
                                      : mobile_number_must_be_ten_digit)
                                  : enter_valid_mobile_number);
                        },
                        controller: mobileNumberController,
                        textStyle: TextStyles.textStyle4,
                        counterText: '',
                        errorStyle: TextStyle(fontSize: 12.0),
                        prefix: const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 8,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colours.paleGrey,
                        filled: true,
                        hintText: mobile_number,
                        suffix: Obx(
                          () {
                            return InkWell(
                              onTap: () async {
                                otpController.text = "";
                                context.showLoader();
                                // Fluttertoast.showToast(
                                //     timeInSecForIosWeb: 1,
                                //     msg:
                                //         'OTP ${authManager.otpVerificationStatusForMobileNumber.value.otpSent.value == true ? "re" : ""}sending please wait....');
                                ScaffoldFeatureController<SnackBar,
                                        SnackBarClosedReason>
                                    sendingOtpSnackBar =
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: ConstantText(
                                      text: otpSendingMsg(authManager
                                                  .otpVerificationStatusForMobileNumber
                                                  .value
                                                  .otpSent
                                                  .value ==
                                              true
                                          ? "re"
                                          : ""),
                                      style: TextStyle(color: Colours.white),
                                    ),
                                    duration: Duration(milliseconds: 180),
                                  ),
                                );
                                sendingOtpSnackBar.close;
                                Map<String, dynamic>? otpSend =
                                    await authManager.sendVerificationCodeTo(
                                        phoneNumber:
                                            mobileNumberController.text);

                                context.hideLoader();
                                if (!verifyOTPFocusNode.hasFocus) {
                                  verifyOTPFocusNode.requestFocus();
                                }
                                if (otpSend?['status'] == true) {
                                  Fluttertoast.showToast(
                                      msg: otp_sent_successfully);
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //     behavior: SnackBarBehavior.floating,
                                  //     content: ConstantText(
                                  //       text: 'OTP Sent Successfully',
                                  //       style: TextStyle(
                                  //         color: Colours.primary,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // );
                                } else {
                                  otpSend == null
                                      ? null
                                      : Fluttertoast.showToast(
                                          msg: otpSend['message']);
                                  //  ScaffoldMessenger.of(context)
                                  //     .showSnackBar(
                                  //     SnackBar(
                                  //       behavior:
                                  //           SnackBarBehavior.floating,
                                  //       content: ConstantText(
                                  //         text: otpSend?['message'],
                                  //         style: TextStyle(
                                  //           color: Colours.primary,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   );
                                }
                              },
                              child: ConstantText(
                                text: authManager
                                            .otpVerificationStatusForMobileNumber
                                            .value
                                            .otpSent
                                            .value ==
                                        true
                                    ? resend_otp
                                    : get_otp,
                                style: TextStyles.textStyle36,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Obx(() {
                        return authManager.otpVerificationStatusForMobileNumber
                                    .value.otpSent.value ==
                                true
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 13.0),
                                child: TextBoxField(
                                  onTap: () {
                                    currentSelectedFocusNode.value =
                                        verifyOTPFocusNode;
                                  },
                                  autoValidateMode: currentSelectedFocusNode ==
                                          verifyOTPFocusNode
                                      ? AutovalidateMode.onUserInteraction
                                      : null,
                                  maxLength: 4,
                                  focusNode: verifyOTPFocusNode,
                                  controller: otpController,
                                  textStyle: TextStyles.textStyle4,
                                  counterText: '',
                                  errorStyle: TextStyle(fontSize: 12.0),
                                  prefix: const Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 8,
                                  ),
                                  fillColor: Colours.paleGrey,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: enter_otp,
                                  suffix: authManager
                                              .otpVerificationStatusForMobileNumber
                                              .value
                                              .numberVerified
                                              .value ==
                                          true
                                      ? ConstantText(
                                          text: verified,
                                          style: TextStyles.verifiedText)
                                      : InkWell(
                                          onTap: () async {
                                            //  progress!.show();
                                            context.showLoader();
                                            Map<String, dynamic>? verified =
                                                await authManager.verifyOTPCode(
                                                    mobileNumber:
                                                        mobileNumberController
                                                            .text,
                                                    otp: otpController.text);
                                            //   progress.dismiss();
                                            context.hideLoader();
                                            if (verified?['status'] == true) {
                                              Fluttertoast.showToast(
                                                  msg: verified?['message']);
                                              // ScaffoldMessenger.of(context)
                                              //     .showSnackBar(
                                              //   SnackBar(
                                              //     behavior: SnackBarBehavior
                                              //         .floating,
                                              //     content: ConstantText(
                                              //       text:
                                              //           verified?['message'],
                                              //       style: TextStyle(
                                              //           color:
                                              //               Colours.primary),
                                              //     ),
                                              //   ),
                                              // );
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: verified?['message']);
                                              // ScaffoldMessenger.of(context)
                                              //     .showSnackBar(
                                              //   SnackBar(
                                              //     behavior: SnackBarBehavior
                                              //         .floating,
                                              //     content: ConstantText(
                                              //       text:
                                              //           verified?['message'],
                                              //       style: TextStyle(
                                              //           color: Colors.red),
                                              //     ),
                                              //   ),
                                              // );
                                            }
                                          },
                                          child: ConstantText(
                                            text: authManager
                                                        .otpVerificationStatusForMobileNumber
                                                        .value
                                                        .numberVerified
                                                        .value ==
                                                    true
                                                ? verified
                                                : verify,
                                            style: authManager
                                                        .otpVerificationStatusForMobileNumber
                                                        .value
                                                        .numberVerified
                                                        .value ==
                                                    true
                                                ? TextStyles.verifiedText
                                                : TextStyles.textStyle36,
                                          ),
                                        ),
                                ),
                              )
                            : SizedBox();
                      }),
                      TextBoxField(
                        onTap: () {
                          currentSelectedFocusNode.value = passwordFocusNode;
                        },
                        autoValidateMode:
                            currentSelectedFocusNode == passwordFocusNode
                                ? AutovalidateMode.onUserInteraction
                                : null,
                        validator: (password) {
                          if (passwordFocusNode.hasFocus) {
                            return null;
                          }
                          return (password?.length ?? 0) < 6
                              ? password_validation_text
                              : (passwordRegularExpression
                                          .hasMatch(password ?? "") ==
                                      true
                                  ? null
                                  : password_validation_text);
                        },
                        controller: passwordController,
                        textStyle: TextStyles.textStyle4,
                        obscureText: showPassword.value,
                        errorMaxLines: 5,
                        suffix: InkWell(
                            onTap: () {
                              showPassword.value = !showPassword.value;
                            },
                            child: showPassword.value
                                ? Icon(
                                    Icons.visibility_outlined,
                                    size: 20,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    Icons.visibility_off_outlined,
                                    size: 20,
                                    color: Colors.grey,
                                  )),
                        errorStyle: TextStyle(fontSize: 12.0),
                        prefix: const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 8,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Colours.paleGrey,
                        filled: true,
                        hintText: password,
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      TextBoxField(
                        onTap: () {
                          currentSelectedFocusNode.value =
                              confirmPasswordFocusNode;
                        },
                        autoValidateMode:
                            currentSelectedFocusNode == confirmPasswordFocusNode
                                ? AutovalidateMode.onUserInteraction
                                : null,
                        validator: (confirmPassword) {
                          if (confirmPasswordFocusNode.hasFocus) {
                            return null;
                          }
                          return (confirmPassword?.length ?? 0) == 0
                              ? password_length_validation
                              : (passwordRegularExpression
                                          .hasMatch(confirmPassword ?? "") ==
                                      true
                                  ? (passwordController.text == confirmPassword
                                      ? null
                                      : password_and_confirm_password_mismatch)
                                  : password_and_confirm_password_mismatch);
                        },
                        controller: confirmPasswordController,
                        textStyle: TextStyles.textStyle4,
                        obscureText: showConfirmPassword.value,
                        suffix: Obx(
                          () => InkWell(
                            onTap: () {
                              showConfirmPassword.value =
                                  !showConfirmPassword.value;
                            },
                            child: showConfirmPassword.value
                                ? Icon(
                                    Icons.visibility_outlined,
                                    size: 20,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    Icons.visibility_off_outlined,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                        errorStyle: TextStyle(fontSize: 12.0),
                        prefix: const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 8,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Colours.paleGrey,
                        filled: true,
                        hintText: confirm_password,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Obx(() {
                        return (authManager.otpVerificationStatusForMobileNumber
                                    .value.numberVerified.value ==
                                true)
                            ? InkWell(
                                onTap: () async {
                                  if (formKey.currentState?.validate() ==
                                      true) {
                                    if (authManager
                                            .otpVerificationStatusForMobileNumber
                                            .value
                                            .numberVerified
                                            .value ==
                                        true) {
                                      context.showLoader();
                                      Map<String, dynamic>? created =
                                          await authManager.registerUser(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        email: eMailController.text,
                                        password: passwordController.text,
                                        confirmPassword:
                                            confirmPasswordController.text,
                                        mobileNumber:
                                            mobileNumberController.text,
                                        // loginPin: pinValue.value,
                                      );

                                      context.hideLoader();

                                      if (created?['status'] == true) {
                                        getIt<SharedPreferences>().remove(
                                            SharedPrefKeyValue
                                                .recentLoggedUserIsPinSet);
                                        getIt<SharedPreferences>().setString(
                                            SharedPrefKeyValue
                                                .recentLoggedUserName,
                                            firstNameController.text +
                                                " " +
                                                lastNameController.text);
                                        getIt<SharedPreferences>().setString(
                                            SharedPrefKeyValue.loggedUserEmail,
                                            eMailController.text);
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(SnackBar(
                                        //         behavior:
                                        //             SnackBarBehavior.floating,
                                        //         content: ConstantText(
                                        //           text: created?['message'],
                                        //           style: TextStyle(
                                        //               color: Colors.green),
                                        //         )));
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (successFailureContext) =>
                                                SuccessFailureSplashScreen(
                                              emailId: eMailController.text,
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: ConstantText(
                                              text: created?['message'],
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        );
                                      }
                                      return;
                                    }

                                    return;
                                  } else {
                                    log("Error in fields");
                                    return;
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: h1p * 7,
                                  child: const Center(
                                      child: ConstantText(
                                          text: register,
                                          style: TextStyles.textStyle5)),
                                  decoration: BoxDecoration(
                                      color: Colours.primary,
                                      borderRadius: BorderRadius.circular(7)),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (successFailureContext) =>
                                  //         SuccessFailureSplashScreen(
                                  //       emailId: eMailController.text,
                                  //     ),
                                  //   ),
                                  // );
                                  formKey.currentState?.validate();
                                  if (authManager
                                          .otpVerificationStatusForMobileNumber
                                          .value
                                          .numberVerified
                                          .value ==
                                      true) {
                                    print("All fields are validated");
                                    return;
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: h1p * 7,
                                  child: const Center(
                                      child: ConstantText(
                                          text: register,
                                          style: TextStyles.textStyle5)),
                                  decoration: BoxDecoration(
                                      color: Colours.grey,
                                      borderRadius: BorderRadius.circular(7)),
                                ),
                              );
                      }),
                      SizedBox(
                        height: h1p * 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ConstantText(
                            text: already_registered,
                            style: TextStyles.textStyle6,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, login);
                            },
                            child: const ConstantText(
                              text: sign_in,
                              style: TextStyles.textStyle8,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h1p * 5,
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      );
    });
  }
}
