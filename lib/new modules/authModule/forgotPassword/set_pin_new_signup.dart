import 'package:flame_lottie/flame_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/util/common/common_widgets.dart';
import 'package:xuriti/util/common/key_value_sharedpreferences.dart';
import 'package:xuriti/util/common/text_constant_widget.dart';
import 'package:xuriti/util/common/widget_constants.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../ui/theme/constants.dart';
import '../../../util/common/string_constants.dart';

class SetNewPINPostSignUp extends StatefulWidget {
  final String emailId;
  final bool? isLoginFlow;

  const SetNewPINPostSignUp({Key? key, required this.emailId, this.isLoginFlow})
      : super(key: key);

  @override
  State<SetNewPINPostSignUp> createState() => _SetNewPINPostSignUpState();
}

class _SetNewPINPostSignUpState extends State<SetNewPINPostSignUp>
    with SingleTickerProviderStateMixin {
  final TextEditingController pinController = TextEditingController();
  final TextEditingController confirmPinController = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  FlipCardController controller = FlipCardController();

  RxBool isPinVisible = false.obs;
  RxBool isConfirmPinVisible = false.obs;

  AuthManager authManager = Get.put(AuthManager());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: FlipCard(
          rotateSide: RotateSide.right,
          frontWidget: Container(
            decoration: BoxDecoration(
              color: Colours.white,
              borderRadius: BorderRadius.circular(
                7.0,
              ),
            ),
            padding: EdgeInsets.only(
              top: 20.0,
              bottom: 5.0,
              right: 5.0,
              left: 5.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Lottie.asset(
                    "assets/lottie/otpScreen.json",
                  ),
                ),
                ConstantText(
                  text: want_to_sign_in_using_PIN,
                  style: TextStyles.textStyleUp,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 25.0,
                    left: 10.0,
                    right: 10.0,
                    bottom: 25.0,
                  ),
                  child: ConstantText(
                      style: TextStyles.textStyle140,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      text: havingPinMakesEasierToSignIn),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: primaryButton(
                          onTap: () {
                            controller.flipcard();
                          },
                          borderRadius: 7.0,
                          title: create_PIN,
                          isOutlined: true,
                          padding: EdgeInsets.all(
                            10.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            if (widget.isLoginFlow == true) {
                              await Navigator.pushNamed(context, oktWrapper);
                            } else {
                              Fluttertoast.showToast(
                                  timeInSecForIosWeb: 10,
                                  msg: verify_link_has_sent_on_email);
                              Navigator.pushReplacementNamed(context, login);
                            }
                          },
                          child: primaryButton(
                            borderRadius: 7.0,
                            title: do_it_later,
                            isOutlined: true,
                            padding: EdgeInsets.all(
                              10.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          backWidget: Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Lottie.asset("assets/lottie/animation_ll4pd39e.json"),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ConstantText(
                          text: create_PIN,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Obx(
                        () => Row(
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
                                obscuringCharacter: "*",
                                pinputAutovalidateMode:
                                    PinputAutovalidateMode.onSubmit,
                                controller: pinController,
                                obscureText: !isPinVisible.value,
                                defaultPinTheme: defaultPinTheme().copyWith(
                                  decoration: defaultPinTheme()
                                      .decoration!
                                      .copyWith(
                                        color: Colours.fillColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color(0xffa2a2d0)),
                                      ),
                                ),
                                focusedPinTheme: defaultPinTheme().copyWith(
                                  decoration: defaultPinTheme()
                                      .decoration!
                                      .copyWith(
                                        color: Colours.fillColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colours.pumpkin),
                                      ),
                                ),
                                submittedPinTheme: defaultPinTheme().copyWith(
                                  decoration: defaultPinTheme()
                                      .decoration!
                                      .copyWith(
                                        color: Colours.fillColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color(0xffa2a2d0)),
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
                                length: 4,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                onCompleted: (pin) => print(pin),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            InkWell(
                              onTap: () {
                                isPinVisible.value = !isPinVisible.value;
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
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ConstantText(
                          text: configure_PIN,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Obx(() => Row(
                            children: [
                              Expanded(
                                child: Pinput(
                                  validator: (confirmPinValue) {
                                    return (confirmPinValue?.isEmpty ?? true)
                                        ? null
                                        : confirmPinValue?.length != 4
                                            ? please_fill_all_values_for_confirm_pin_field
                                            : (confirmPinValue !=
                                                    pinController.text
                                                ? enteredNewPinAndConfirmPinNotMatch
                                                : null);
                                  },
                                  obscuringCharacter: "*",
                                  pinputAutovalidateMode:
                                      PinputAutovalidateMode.onSubmit,
                                  controller: confirmPinController,
                                  obscureText: !isConfirmPinVisible.value,
                                  defaultPinTheme: defaultPinTheme().copyWith(
                                    decoration:
                                        defaultPinTheme().decoration!.copyWith(
                                              color: Colours.fillColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Color(0xffa2a2d0)),
                                            ),
                                  ),
                                  focusedPinTheme: defaultPinTheme().copyWith(
                                    decoration:
                                        defaultPinTheme().decoration!.copyWith(
                                              color: Colours.fillColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colours.pumpkin),
                                            ),
                                  ),
                                  submittedPinTheme: defaultPinTheme().copyWith(
                                    decoration:
                                        defaultPinTheme().decoration!.copyWith(
                                              color: Colours.fillColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Color(0xffa2a2d0)),
                                            ),
                                  ),
                                  errorPinTheme:
                                      defaultPinTheme().copyBorderWith(
                                    border: Border.all(color: Colors.redAccent),
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
                                  onCompleted: (pin) => print(pin),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              InkWell(
                                onTap: () {
                                  isConfirmPinVisible.value =
                                      !isConfirmPinVisible.value;
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
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (formState.currentState?.validate() == false) {
                          return;
                        } else {
                          if ((pinController.text.isEmpty) ||
                              (confirmPinController.text.isEmpty)) {
                            Fluttertoast.showToast(
                                msg: please_enter_all_mandatory_fields);
                            return;
                          }

                          context.showLoader();
                          Map<String, dynamic>? setNewPinResponse =
                              await authManager.setNewPinForGivenEmail(
                            emailId: widget.emailId,
                            pin: pinController.text,
                          );
                          context.hideLoader();
                          if (setNewPinResponse?["status"] == true) {
                            getIt<SharedPreferences>().setBool(
                                SharedPrefKeyValue.recentLoggedUserIsPinSet,
                                true);
                            if (widget.isLoginFlow == true) {
                              await Navigator.pushNamed(context, oktWrapper);
                            } else {
                              Fluttertoast.showToast(
                                  timeInSecForIosWeb: 10,
                                  msg: verify_link_has_sent_on_email);
                              Navigator.pushReplacementNamed(context, login);
                            }
                            // Navigator.pushReplacementNamed(context, oktWrapper);
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
                          color: Colours.primary,
                          borderRadius: BorderRadius.circular(
                            7,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          controller: controller,
        ),
      ),
    );
  }
}
