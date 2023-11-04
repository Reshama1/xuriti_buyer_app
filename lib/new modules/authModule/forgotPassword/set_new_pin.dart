import 'package:flame_lottie/flame_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/new%20modules/authModule/splashScreen/success_failure_splash_screen.dart';
import 'package:xuriti/new%20modules/common_widget.dart';
import 'package:xuriti/new%20modules/image_assetpath_constants.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/util/common/text_constant_widget.dart';
import 'package:xuriti/util/common/widget_constants.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../models/helper/service_locator.dart';
import '../../../ui/theme/constants.dart';
import '../../../util/common/key_value_sharedpreferences.dart';
import '../../../util/common/string_constants.dart';

class SetNewPin extends StatefulWidget {
  final bool isFromForgotPinFlow;
  final bool? newSignUP;
  final String emailId;
  const SetNewPin(
      {Key? key,
      required this.isFromForgotPinFlow,
      required this.emailId,
      this.newSignUP})
      : super(key: key);

  @override
  State<SetNewPin> createState() => _SetNewPinState();
}

class _SetNewPinState extends State<SetNewPin> {
  TextEditingController currentPinFieldController = TextEditingController();
  TextEditingController pinFieldController = TextEditingController();
  TextEditingController confirmPinFieldController = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  RxBool confirmButtonState = false.obs;

  RxBool isCurrentPinVisible = false.obs;
  RxBool isPinVisible = false.obs;
  RxBool isConfirmPinVisible = false.obs;
  RxBool isNewPin = true.obs;
  AuthManager authManager = Get.put(AuthManager());

  void onPinFieldSubmitted(String? value) {
    if (pinFieldController.text.isEmpty ||
        confirmPinFieldController.text.isEmpty ||
        ((widget.isFromForgotPinFlow == false &&
                (authManager.userDetails?.value?.login_pin ?? false))
            ? currentPinFieldController.text.isEmpty
            : false) ||
        pinFieldController.text.length != 4 ||
        ((widget.isFromForgotPinFlow == false &&
                (authManager.userDetails?.value?.login_pin ?? false))
            ? currentPinFieldController.text.length != 4
            : false) ||
        confirmPinFieldController.text.length != 4 ||
        (pinFieldController.text != confirmPinFieldController.text)) {
      confirmButtonState.value = false;
    } else {
      confirmButtonState.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.black,
      resizeToAvoidBottomInset: widget.newSignUP == true ? false : true,
      body: SafeArea(
        child: Form(
          key: formState,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              widget.newSignUP == true
                  ? SizedBox()
                  : Container(
                      padding:
                          EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10.0),
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
                            vertical: (widget.isFromForgotPinFlow == false &&
                                    (authManager
                                            .userDetails?.value?.login_pin ??
                                        false))
                                ? 20
                                : 10,
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
                                  text: configure_PIN,
                                  style: TextStyles.textStyle3,
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///
                        if (widget.isFromForgotPinFlow == false &&
                            (authManager.userDetails?.value?.login_pin ??
                                false))
                          const SizedBox(
                            height: 30,
                          ),
                        if (widget.isFromForgotPinFlow == false &&
                            (authManager.userDetails?.value?.login_pin ??
                                false))
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ConstantText(
                                text: enter_current_PIN,
                              ),
                            ),
                          ),
                        if (widget.isFromForgotPinFlow == false &&
                            (authManager.userDetails?.value?.login_pin ??
                                false))
                          const SizedBox(
                            height: 13,
                          ),
                        if (widget.isFromForgotPinFlow == false &&
                            (authManager.userDetails?.value?.login_pin ??
                                false))
                          Obx(() => Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Pinput(
                                        validator: (currentPinValue) {
                                          return (currentPinValue?.isEmpty ??
                                                  true)
                                              ? null
                                              : (currentPinValue?.length != 4
                                                  ? length_must_be_four
                                                  : null);
                                        },
                                        pinputAutovalidateMode:
                                            PinputAutovalidateMode.onSubmit,
                                        obscuringCharacter: "*",
                                        controller: currentPinFieldController,
                                        obscureText: !isCurrentPinVisible.value,
                                        defaultPinTheme:
                                            defaultPinTheme().copyWith(
                                          decoration: defaultPinTheme()
                                              .decoration!
                                              .copyWith(
                                                color: Colours.fillColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Color(0xffa2a2d0)),
                                              ),
                                        ),
                                        focusedPinTheme:
                                            defaultPinTheme().copyWith(
                                          decoration: defaultPinTheme()
                                              .decoration!
                                              .copyWith(
                                                color: Colours.fillColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colours.pumpkin),
                                              ),
                                        ),
                                        submittedPinTheme:
                                            defaultPinTheme().copyWith(
                                          decoration: defaultPinTheme()
                                              .decoration!
                                              .copyWith(
                                                color: Colours.fillColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Color(0xffa2a2d0)),
                                              ),
                                        ),
                                        errorPinTheme:
                                            defaultPinTheme().copyBorderWith(
                                          border: Border.all(
                                              color: Colors.redAccent),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        showCursor: true,
                                        isCursorAnimationEnabled: true,
                                        closeKeyboardWhenCompleted: true,
                                        length: 4,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // onCompleted: onPinFieldSubmitted,
                                        // onSubmitted: onPinFieldSubmitted,
                                        onChanged: onPinFieldSubmitted,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        isCurrentPinVisible.value =
                                            !(isCurrentPinVisible.value);
                                      },
                                      child: Icon(
                                        !isCurrentPinVisible.value
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              )),

                        SizedBox(
                          height: 30.0,
                        ),

                        ///
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ConstantText(
                              text: enter_new_PIN,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Obx(
                          () => Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Pinput(
                                    validator: (pinValue) {
                                      return (pinValue?.isEmpty ?? true)
                                          ? null
                                          : (pinValue?.length != 4
                                              ? please_fill_all_values_for_pin_field
                                              : null);
                                    },
                                    pinputAutovalidateMode:
                                        PinputAutovalidateMode.onSubmit,
                                    obscuringCharacter: "*",
                                    controller: pinFieldController,
                                    obscureText: !isPinVisible.value,
                                    defaultPinTheme: defaultPinTheme().copyWith(
                                      decoration: defaultPinTheme()
                                          .decoration!
                                          .copyWith(
                                            color: Colours.fillColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Color(0xffa2a2d0)),
                                          ),
                                    ),
                                    focusedPinTheme: defaultPinTheme().copyWith(
                                      decoration: defaultPinTheme()
                                          .decoration!
                                          .copyWith(
                                            color: Colours.fillColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colours.pumpkin),
                                          ),
                                    ),
                                    submittedPinTheme:
                                        defaultPinTheme().copyWith(
                                      decoration: defaultPinTheme()
                                          .decoration!
                                          .copyWith(
                                            color: Colours.fillColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Color(0xffa2a2d0)),
                                          ),
                                    ),
                                    errorPinTheme:
                                        defaultPinTheme().copyBorderWith(
                                      border:
                                          Border.all(color: Colors.redAccent),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    showCursor: true,
                                    isCursorAnimationEnabled: true,
                                    closeKeyboardWhenCompleted: true,
                                    length: 4,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // onCompleted: onPinFieldSubmitted,
                                    // onSubmitted: onPinFieldSubmitted,
                                    onChanged: onPinFieldSubmitted,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    isPinVisible.value = !(isPinVisible.value);
                                  },
                                  child: Icon(
                                    !isPinVisible.value
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ConstantText(
                              text: confirm_new_PIN,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Obx(() => Padding(
                              padding: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Pinput(
                                      validator: (confirmPinValue) {
                                        return (confirmPinValue?.isEmpty ??
                                                true)
                                            ? null
                                            : confirmPinValue?.length != 4
                                                ? please_fill_all_values_for_confirm_pin_field
                                                : (confirmPinValue !=
                                                        pinFieldController.text
                                                    ? enteredNewPinAndConfirmPinNotMatch
                                                    : null);
                                      },
                                      pinputAutovalidateMode:
                                          PinputAutovalidateMode.onSubmit,
                                      obscuringCharacter: "*",
                                      controller: confirmPinFieldController,
                                      obscureText: !isConfirmPinVisible.value,
                                      defaultPinTheme:
                                          defaultPinTheme().copyWith(
                                        decoration: defaultPinTheme()
                                            .decoration!
                                            .copyWith(
                                              color: Colours.fillColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Color(0xffa2a2d0)),
                                            ),
                                      ),
                                      focusedPinTheme:
                                          defaultPinTheme().copyWith(
                                        decoration: defaultPinTheme()
                                            .decoration!
                                            .copyWith(
                                              color: Colours.fillColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colours.pumpkin),
                                            ),
                                      ),
                                      submittedPinTheme:
                                          defaultPinTheme().copyWith(
                                        decoration: defaultPinTheme()
                                            .decoration!
                                            .copyWith(
                                              color: Colours.fillColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Color(0xffa2a2d0)),
                                            ),
                                      ),
                                      errorPinTheme:
                                          defaultPinTheme().copyBorderWith(
                                        border:
                                            Border.all(color: Colors.redAccent),
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      showCursor: true,
                                      isCursorAnimationEnabled: true,
                                      closeKeyboardWhenCompleted: true,
                                      length: 4,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // onCompleted: onPinFieldSubmitted,
                                      onChanged: onPinFieldSubmitted,
                                      // onSubmitted: onPinFieldSubmitted,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      isConfirmPinVisible.value =
                                          !(isConfirmPinVisible.value);
                                    },
                                    child: Icon(
                                      !isConfirmPinVisible.value
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 30.0,
                        ),
                        Obx(() {
                          return InkWell(
                            onTap: () async {
                              if (confirmButtonState.value == false) {
                                return;
                              }
                              if (formState.currentState?.validate() == false) {
                                return;
                              } else {
                                if ((pinFieldController.text.isEmpty) ||
                                    (confirmPinFieldController.text.isEmpty) ||
                                    ((widget.isFromForgotPinFlow == false &&
                                            (authManager.userDetails?.value
                                                    ?.login_pin ??
                                                false))
                                        ? currentPinFieldController.text.isEmpty
                                        : false)) {
                                  Fluttertoast.showToast(
                                      msg: please_enter_all_mandatory_fields);
                                  return;
                                }
                                context.showLoader();
                                Map<String, dynamic>? setNewPinResponse =
                                    await authManager.setNewPinForGivenEmail(
                                        currentPin:
                                            (widget.isFromForgotPinFlow ==
                                                        false &&
                                                    (authManager
                                                            .userDetails
                                                            ?.value
                                                            ?.login_pin ??
                                                        false))
                                                ? currentPinFieldController.text
                                                : null,
                                        emailId: widget.emailId,
                                        pin: pinFieldController.text);
                                context.hideLoader();
                                if (setNewPinResponse?["status"] == true) {
                                  isNewPin.value = authManager
                                              .userDetails?.value?.login_pin ??
                                          false
                                      ? false
                                      : true;
                                  Map<String, dynamic>? loginResponseData =
                                      authManager.userDetails?.toJson();
                                  loginResponseData?["login_pin"] = true;
                                  if (loginResponseData != null) {
                                    // SaveUserDetail()
                                    //     .setUserDetail(loginResponseData);
                                    // SaveUserDetail().getUserDetail();
                                    await getIt<SharedPreferences>().setBool(
                                        SharedPrefKeyValue
                                            .recentLoggedUserIsPinSet,
                                        true);
                                    await getIt<SharedPreferences>().setString(
                                        SharedPrefKeyValue.recentLoggedUserName,
                                        authManager.userDetails?.value?.user
                                                ?.name ??
                                            "");
                                    await getIt<SharedPreferences>().setString(
                                        SharedPrefKeyValue.loggedUserEmail,
                                        authManager.userDetails?.value?.user
                                                ?.email ??
                                            "");
                                  }
                                  if (widget.isFromForgotPinFlow == true &&
                                      (widget.emailId !=
                                          getIt<SharedPreferences>().getString(
                                              SharedPrefKeyValue
                                                  .loggedUserEmail))) {
                                    await getIt<SharedPreferences>().setBool(
                                        SharedPrefKeyValue
                                            .recentLoggedUserIsPinSet,
                                        false);
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SuccessFailureSplashScreen(
                                        emailId: "",
                                        showCustomeWidget: true,
                                        delayedWidgetAction: () {
                                          Future.delayed(
                                            Duration(seconds: 5),
                                          ).then((value) {
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    widget.isFromForgotPinFlow ==
                                                            false
                                                        ? landing
                                                        : login_constant,
                                                    (Route route) => false);
                                            // Navigator.pushAndRemoveUntil(
                                            //     context,
                                            //     // widget.isFromForgotPinFlow ==
                                            //     //         false
                                            //     //     ? landing
                                            //     //     : login,
                                            //     '/login',
                                            //     (Route route) => false);
                                          });
                                        },
                                        customWidget: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 200,
                                              child: Center(
                                                child: Lottie.asset(
                                                  "assets/lottie/checkMark.json",
                                                  repeat: false,
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: ConstantText(
                                                text: (widget
                                                            .isFromForgotPinFlow ||
                                                        isNewPin.value)
                                                    ? pin_set_successfully
                                                    : pin_updated_successfully,
                                                style: TextStyles.textStyleUp,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      msg: setNewPinResponse?["message"]);
                                }
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 50,
                              padding: EdgeInsets.all(
                                13.0,
                              ),
                              child: ConstantText(
                                textAlign: TextAlign.center,
                                text: confirm,
                                style: TextStyles.textStyle5,
                              ),
                              decoration: BoxDecoration(
                                color: !confirmButtonState.value
                                    ? Colours.grey
                                    : Colours.primary,
                                borderRadius: BorderRadius.circular(
                                  7,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
