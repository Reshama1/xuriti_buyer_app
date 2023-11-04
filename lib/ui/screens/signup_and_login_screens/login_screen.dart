import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/screens/signup_and_login_screens/forget_password_screen.dart';
import 'package:xuriti/ui/screens/signup_and_login_screens/signUp_screen.dart';
import 'package:xuriti/util/common/key_value_sharedpreferences.dart';
import 'package:xuriti/util/common/string_constants.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';
import 'package:xuriti/util/common/widget_constants.dart';
import 'package:xuriti/util/loaderWidget.dart';
import 'package:xuriti/util/validator/regular_expression.dart';
import 'dart:io';
import 'package:get/get.dart' hide Trans;
import '../../../logic/view_models/auth_manager.dart';
import '../../../new modules/authModule/splashScreen/success_failure_splash_screen.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

enum LoginOption { password, pin }

class LoginScreen extends StatefulWidget {
  final bool isFromPushNotification;
  const LoginScreen({Key? key, required this.isFromPushNotification})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Rx<LoginOption> selectedLoginOption = LoginOption.password.obs;

  FlipCardController flipCardController = FlipCardController();

  AuthManager authManager = Get.put(AuthManager());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  FocusNode pinFocus = FocusNode();

  RxBool isPasswordVisible = true.obs;
  RxBool isPinVisible = false.obs;
  RxBool isChecked = false.obs;
  RxBool isPinSet = false.obs;

  RxBool isLoginFlow = false.obs;

  RxString userName = ''.obs;
  RxString appVersion = ''.obs;

  List<String> cardText = [
    zero_interest,
    flexible_payment,
    multiple_payment_methods,
    easy_interfaces
  ];
  List<String> cardImgPath = [
    'credit-cards.png',
    'flexible.png',
    'operation.png',
    'login.png'
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      appVersion.value = 'App ${buildNumber}(v${version})';
    });
    emailController.text = getIt<SharedPreferences>()
            .getString(SharedPrefKeyValue.loggedUserEmail) ??
        "";

    userName.value = getIt<SharedPreferences>()
            .getString(SharedPrefKeyValue.recentLoggedUserName) ??
        "";

    isPinSet.value = getIt<SharedPreferences>()
            .getBool(SharedPrefKeyValue.recentLoggedUserIsPinSet) ??
        false;

    selectedLoginOption.value = (isPinSet.value && emailController.text != '')
        ? LoginOption.pin
        : LoginOption.password;

    isPinSet.listen((p0) {
      if (p0 == true) {
        pinFocus.requestFocus();
      }
    });
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
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              print(Get.context?.locale.languageCode);
              if (Get.context?.locale.languageCode != "hi") {
                await Get.context?.setLocale(Locale("hi", "IN"));
                Get.updateLocale(Locale("hi", "IN"));
              } else {
                await Get.context?.setLocale(Locale("en", "US"));
                Get.updateLocale(Locale("en", "US"));
              }
            },
          ),
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Obx(
              () => (isPinSet.value &&
                      (getIt<SharedPreferences>().getString(
                                  SharedPrefKeyValue.loggedUserEmail) !=
                              '' &&
                          getIt<SharedPreferences>().getString(
                                  SharedPrefKeyValue.loggedUserEmail) !=
                              null))
                  ? getPinWidget(h10p, h1p, w10p)
                  : SingleChildScrollView(
                      child: Stack(children: [
                        Container(
                          color: Colors.black,
                          padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: ImageFromAssetPath<Widget>(
                                assetPath: ImageAssetpathConstant.xuritiLogo,
                                width: 100,
                                height: 40,
                              ).imageWidget,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 70.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                26,
                              ),
                              topRight: Radius.circular(
                                26,
                              ),
                            ),
                          ),
                          child: Form(
                            child: Obx(() {
                              return getBodyWidgetForTextFields(
                                  h10p, h1p, w10p);
                            }),
                          ),
                        ),
                      ]),
                    ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildSegment(String text) {
    return Container(
      child: Text(
        text,
        style: TextStyle(fontSize: 22, color: Colors.black),
      ),
    );
  }

  getPinWidget(double h10p, double h1p, double w10p) {
    return Stack(alignment: AlignmentDirectional.topStart, children: [
      Container(
        color: Colors.white,
      ),
      Container(
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? h10p * 3.5
            : w10p * 3.5,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 34, 34, 33),
          borderRadius:
              BorderRadius.vertical(bottom: Radius.elliptical(w10p * 10, 40)),
        ),
      ),
      Positioned(
        top: 40,
        left: 20,
        right: 20,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageFromAssetPath<Widget>(
                  assetPath: ImageAssetpathConstant.xuritiLogo,
                  // width: 60,
                  height: 25,
                ).imageWidget,
                SizedBox(
                  height: h1p * 4,
                ),
                if (userName.value != '')
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: ConstantText(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      text: "Hi ${userName.value} ,",
                      color: Color.fromARGB(255, 255, 255, 255),
                      style: TextStyles.textStyle28,
                    ),
                  ),
                ConstantText(
                  // fontWeight: FontWeight.bold,
                  fontSize: 14,
                  text: getIt<SharedPreferences>()
                          .getString(SharedPrefKeyValue.loggedUserEmail) ??
                      "",
                  color: Color.fromARGB(255, 255, 255, 255),
                  style: TextStyles.textStyle28,
                ),
              ],
            ),
            // SizedBox(
            //   width: w10p * 1.5,
            // ),
            Obx(() => ConstantText(
                  text: appVersion.value,
                  color: Colors.white,
                )),
          ],
        ),
      ),
      Positioned(
        left: 30,
        right: 30,
        top: (MediaQuery.of(context).orientation == Orientation.portrait
                ? h10p * 2.2
                : w10p * 2.2) +
            (MediaQuery.of(context).orientation == Orientation.portrait
                ? h10p * 2
                : w10p * 2) +
            30,
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          runSpacing: 2,
          children: List.generate(
              4,
              (index) => Container(
                    width: ((MediaQuery.of(context).size.width) / 2) - 70,
                    height: ((MediaQuery.of(context).size.width) / 2) - 70,
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                          spreadRadius: 1.5,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ImageFromAssetPath<Widget>(
                          color: Colours.primary,
                          assetPath: 'assets/images/${cardImgPath[index]}',
                          // width: 100,
                          height: 40,
                        ).imageWidget,
                        ConstantText(
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w700,
                            text: cardText[index])
                      ],
                    ),
                  )),
        ),

        // GridView.builder(
        //   itemCount: 4,
        //   shrinkWrap: true,
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 20,
        //     crossAxisSpacing: 50.0,
        //   ),
        //   itemBuilder: (BuildContext context, int index) {
        //     return ;
        //   },
        // ),
      ),
      Positioned(
          top: MediaQuery.of(context).orientation == Orientation.portrait
              ? h10p * 2.2
              : w10p * 2.2,
          left: MediaQuery.of(context).orientation == Orientation.portrait
              ? w10p * 1
              : h10p * 5,
          child: Container(
            // margin: EdgeInsets.all(10),

            width: MediaQuery.of(context).orientation == Orientation.portrait
                ? w10p * 8
                : h10p * 9.5,
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? h10p * 2.07
                : w10p * 2,
            // color: Colours.paleGrey,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 214, 216, 217),

                // border: Border.all(width: 0),
                borderRadius: BorderRadius.circular(9)),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 0, left: 15, right: 15),
              child: Column(
                children: [
                  ConstantText(
                    fontWeight: FontWeight.bold,
                    text: verify_4_digit_security_PIN,
                    color: Color.fromARGB(208, 0, 0, 0),
                    style: TextStyles.textStyle9,
                  ),
                  // SizedBox(
                  //   height: h1p * 2,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 20, top: 10),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Pinput(
                              validator: (pin) {
                                if (pin?.length != 4) {
                                  return please_enter_valid_PIN;
                                }
                                return null;
                              },
                              errorTextStyle: TextStyle(
                                  color: Colours.paleRed,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 13.0),
                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              focusNode: pinFocus,
                              controller: pinController,
                              // autofillHints: [AutofillHints.newPassword],
                              obscureText: !isPinVisible.value,
                              obscuringCharacter: "*",
                              cursor: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 3.0,
                                  width: 56,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              defaultPinTheme: defaultPinTheme(
                                      textColor: Colors.black.withOpacity(0.5))
                                  .copyWith(
                                decoration: defaultPinTheme(
                                        textColor:
                                            const Color.fromARGB(255, 0, 0, 0))
                                    .decoration!
                                    .copyWith(
                                      color: Color.fromARGB(255, 214, 216, 217),
                                      border: Border(
                                        bottom: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0)),
                                      ),
                                    ),
                              ),

                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              showCursor: true,
                              isCursorAnimationEnabled: true,
                              closeKeyboardWhenCompleted: true,
                              length: 4,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // onCompleted: (value) {
                              //   TextInput.finishAutofillContext();
                              // },

                              onCompleted: (value) async {
                                context.showLoader();
                                Map<String, dynamic> isLogin = await authManager
                                    .signInWithEmailAndPassword(
                                  // email: emailController.text,
                                  email: getIt<SharedPreferences>().getString(
                                          SharedPrefKeyValue.loggedUserEmail) ??
                                      '',
                                  password: pinController.text,
                                  loginOption: LoginOption.pin,
                                );

                                context.hideLoader();

                                if (isLogin['status'] == true) {
                                  if (widget.isFromPushNotification == true) {
                                    Navigator.pop(context);
                                    return;
                                  }
                                  TextInput.finishAutofillContext();
                                  getIt<SharedPreferences>().setString(
                                      'password',
                                      passwordController.text.trim());

                                  Navigator.pushReplacementNamed(
                                      context, oktWrapper);
                                } else {
                                  pinController.text = '';
                                  Fluttertoast.showToast(
                                      msg:
                                          isLogin['message'] == account_inactive
                                              ? account_delete_msg
                                              : isLogin['message'],
                                      textColor: Colors.white,
                                      backgroundColor: Colors.black);
                                }
                              },
                              // onSubmitted: (value) {

                              // },
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
                  Container(
                    width: w10p * 8.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            // getIt<SharedPreferences>().remove(
                            //     SharedPrefKeyValue.recentLoggedUserIsPinSet);
                            // getIt<SharedPreferences>().remove(
                            //     SharedPrefKeyValue.recentLoggedUserName);
                            isPinSet.value = false;
                            selectedLoginOption.value = LoginOption.password;
                          },
                          child: ConstantText(
                              color: Colors.black.withOpacity(0.5),
                              text: try_with_password,
                              style: TextStyles.textStyle9),
                        ),
                        // SizedBox(
                        //   height: h1p * 6,
                        // ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (forgotPasswordPinContext) =>
                                    ForgetPasswordScreen(
                                  loginOption: LoginOption.pin,
                                ),
                              ),
                            );
                          },
                          child: ConstantText(
                            color: Colors.black.withOpacity(0.5),
                            text: forgot_PIN,
                            style: TextStyles.textStyle9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    ]);
  }

  getBodyWidgetForTextFields(double h10p, double h1p, double w10p) {
    return Padding(
      padding: EdgeInsets.only(top: h1p * 3.5),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 10.0,
              top: 5.0,
              right: 10.0,
              bottom: 5.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  5.0,
                ),
              ),
              border: Border.all(
                color: Colours.pumpkin,
                width: 1.0,
              ),
            ),
            child: const ConstantText(
              text: login_constant,
              color: Colours.pumpkin,
              style: TextStyles.textStyle3,
            ),
          ),
          SizedBox(
            height: h1p * 3,
          ),
          AutofillGroup(
              child: Column(
            children: [
              Container(
                width: w10p * 9,
                decoration: const BoxDecoration(
                  color: Colours.paleGrey,
                ),
                child: TextBoxField(
                  controller: emailController,
                  autofillHints: [AutofillHints.email],
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colours.paleGrey,
                  hintText: (selectedLoginOption.value == LoginOption.password
                          ? email_id
                          : email_or_mobile_number)
                      .tr(),
                  hintStyle: TextStyles.textStyle4,
                ),
              ),
              SizedBox(
                height: h1p * 3,
              ),
              Container(
                width: w10p * 9,
                decoration: const BoxDecoration(
                  color: Colours.paleGrey,
                ),
                child: Obx(
                  () => TextBoxField(
                    controller: passwordController,
                    obscureText: isPasswordVisible.value,
                    autofillHints: [AutofillHints.password],
                    suffix: InkWell(
                      onTap: () {
                        isPasswordVisible.value = !isPasswordVisible.value;
                      },
                      child: isPasswordVisible.value
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
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colours.paleGrey,
                    hintText: (selectedLoginOption.value == LoginOption.password
                            ? password
                            : pin)
                        .tr(),
                    hintStyle: TextStyles.textStyle4,
                  ),
                ),
              ),
              SizedBox(
                height: h1p * 1.5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (getIt<SharedPreferences>().getBool(SharedPrefKeyValue
                                    .recentLoggedUserIsPinSet) ==
                                true &&
                            (getIt<SharedPreferences>().getString(
                                        SharedPrefKeyValue.loggedUserEmail) !=
                                    null &&
                                getIt<SharedPreferences>().getString(
                                        SharedPrefKeyValue.loggedUserEmail) !=
                                    ''))
                        ? InkWell(
                            onTap: () {
                              isPinSet.value = true;
                              selectedLoginOption.value = LoginOption.pin;
                            },
                            child: ConstantText(
                              text: try_with_pin,
                              style: TextStyles.textStyle9,
                            ),
                          )
                        : SizedBox(),
                    // SizedBox(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (forgotPasswordPinContext) =>
                                ForgetPasswordScreen(
                              loginOption: selectedLoginOption.value,
                            ),
                          ),
                        );
                      },
                      child: ConstantText(
                        text: selectedLoginOption.value == LoginOption.password
                            ? "Forgot Password?"
                            : "Forgot PIN?",
                        style: TextStyles.textStyle9,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: h1p * 3,
              ),
              InkWell(
                onTap: () async {
                  // TextInput.finishAutofillContext();
                  if (LoginOption.password == selectedLoginOption.value) {
                    if (emailController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: please_enter_emailId_to_Continue);
                      return;
                    }
                    if (emailRegularExpression.hasMatch(emailController.text) ==
                        false) {
                      Fluttertoast.showToast(msg: please_enter_valid_email_ID);
                      return;
                    }
                    if (passwordController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: pleaseEnterPasswordToContinue);
                      return;
                    }
                  } else {
                    if (emailController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: please_enter_email_or_mobile_to_continue);
                      return;
                    }
                    if (int.tryParse(emailController.text) != null &&
                        emailController.text.length != 10) {
                      Fluttertoast.showToast(msg: enter_valid_mobile_number);
                      return;
                    } else if (int.tryParse(emailController.text) == null &&
                        emailRegularExpression.hasMatch(emailController.text) ==
                            false) {
                      Fluttertoast.showToast(msg: please_enter_valid_email_ID);
                      return;
                    }

                    if (pinController.text.isEmpty) {
                      Fluttertoast.showToast(msg: please_enter_pin_to_continue);
                      return;
                    }
                  }

                  context.showLoader();
                  Map<String, dynamic> isLogin =
                      await authManager.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                    loginOption: LoginOption.password,
                  );

                  context.hideLoader();
                  if (isLogin['status'] == true) {
                    if (widget.isFromPushNotification == true) {
                      Navigator.pop(context);
                      return;
                    }
                    TextInput.finishAutofillContext();
                    getIt<SharedPreferences>()
                        .setString('password', passwordController.text.trim());
                    ((selectedLoginOption == LoginOption.password) &&
                            (authManager.userDetails?.value?.login_pin ??
                                    false) ==
                                false)
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SuccessFailureSplashScreen(
                                        seconds: 0,
                                        emailId: emailController.text,
                                        customWidget: Stack(children: <Widget>[
                                          Container(
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 3, sigmaY: 3),
                                            ),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://images.pexels.com/photos/707915/pexels-photo-707915.jpeg"),
                                                  fit: BoxFit.cover),
                                            ),
                                          )
                                        ]),
                                        showCustomeWidget: false,
                                        isLoginFlow: true)),
                          )
                        : Navigator.pushReplacementNamed(context, oktWrapper);
                  } else {
                    Fluttertoast.showToast(
                        msg: isLogin['message'] == account_inactive
                            ? account_delete_msg
                            : isLogin['message'],
                        textColor: Colors.white,
                        backgroundColor: Colors.black);
                  }
                },
                child: Container(
                  width: w10p * 9,
                  height: h1p * 7,
                  child: const Center(
                      child: ConstantText(
                          text: login_constant, style: TextStyles.textStyle5)),
                  decoration: BoxDecoration(
                      color: Colours.primary,
                      borderRadius: BorderRadius.circular(7)),
                ),
              ),
            ],
          )),
          SizedBox(
            height: h1p * 3,
          ),
          if (Platform.isAndroid)
            InkWell(
              onTap: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    content: ConstantText(
                      text: signup_with_google,
                      style: TextStyle(color: Colours.primary),
                    ),
                  ),
                );

                context.showLoader();
                Map<String, dynamic>? message =
                    await authManager.googleLogin(isSignIn: false);
                //progress.dismiss();
                context.hideLoader();
                if (message != null) {
                  if (message['status'] == false) {
                    if (message['message'] == user_not_found) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => SignUpScreen(
                              navigatedFromSignupGoogleButtonTapped: true))));
                      //  Navigator.pushNamed(context, signUp);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: ConstantText(
                            text: message['message'],
                            style: TextStyle(color: Colours.primary),
                          ),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: ConstantText(
                          text: message['message'],
                          style: TextStyle(color: Colours.primary),
                        ),
                      ),
                    );
                    Navigator.pushNamed(context, oktWrapper);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: ConstantText(
                        text: message?['message'],
                        style: TextStyle(color: Colours.primary),
                      )));
                  Navigator.pushNamed(context, oktWrapper);
                }
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageFromAssetPath<Widget>(
                        assetPath: ImageAssetpathConstant.googleIcon,
                        height: 20,
                        width: 20.0,
                      ).imageWidget,
                      SizedBox(
                        width: 10.0,
                      ),
                      const ConstantText(
                        text: google_sign_in,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colours.black, width: 1),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7)),
                ),
              ),
            ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const ConstantText(
              text: new_user,
              style: TextStyles.textStyle6,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, signUp);
              },
              child: const ConstantText(
                text: signup,
                style: TextStyles.textStyle8,
              ),
            )
          ]),
        ],
      ),
    );
  }
}
