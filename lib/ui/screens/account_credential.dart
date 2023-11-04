import 'package:flame_lottie/flame_lottie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xuriti/ui/screens/signup_and_login_screens/login_screen.dart';
import '../../logic/view_models/auth_manager.dart';
import '../../new modules/authModule/forgotPassword/set_new_pin.dart';
import '../../new modules/common_widget.dart';
import '../../new modules/image_assetpath_constants.dart';
import '../../util/common/string_constants.dart';
import '../../util/common/text_constant_widget.dart';
import '../theme/constants.dart';
import '../widgets/appbar/app_bar_widget.dart';

class Credential extends StatefulWidget {
  const Credential({super.key});

  @override
  State<Credential> createState() => _CredentialState();
}

class _CredentialState extends State<Credential> {
  Rx<LoginOption> selectedLoginOption = LoginOption.password.obs;
  AuthManager authManager = Get.put(AuthManager());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h10p = constraints.maxHeight * 0.1;
      double w10p = constraints.maxWidth * 0.1;
      double h1p = maxHeight * 0.01;
      double w1p = maxWidth * 0.01;
      return SafeArea(
          child: Scaffold(
              backgroundColor: Colours.black,
              appBar: AppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  toolbarHeight: h10p * .9,
                  flexibleSpace: AppbarWidget()),
              body: Container(
                width: maxWidth,
                decoration: const BoxDecoration(
                    color: Colours.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: w1p * 4, vertical: h1p * 3),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: ImageFromAssetPath<Widget>(
                                    assetPath: ImageAssetpathConstant.arrowLeft)
                                .imageWidget,
                          ),
                        ),
                        Expanded(
                          child: ConstantText(
                            text: account_credentials,
                            color: Colors.black,
                            style: TextStyles.subHeading,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: w10p * 6,
                      height: h10p * 3,
                      child: Lottie.asset(
                          "assets/lottie/account_credential.json")),
                  SizedBox(
                    height: h1p * 3,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(w1p * 2),
                  //   child: InkWell(
                  //     onTap: () {
                  //       // Navigator.pushNamed(context, signUp);
                  //       // Navigator.of(context).push(
                  //       //   MaterialPageRoute(
                  //       //     builder: (forgotPasswordPinContext) =>
                  //       //         ForgetPasswordScreen(
                  //       //       loginOption: selectedLoginOption.value,
                  //       //     ),
                  //       //   ),
                  //       // );
                  //     },
                  //     child: Container(
                  //       width: w10p * 8,
                  //       padding: const EdgeInsets.symmetric(vertical: 14),
                  //       child: const Center(
                  //           child: ConstantText(
                  //               color: Color.fromARGB(255, 43, 42, 42),
                  //               text: "Change Password",
                  //               style: TextStyles.textStyle5)),
                  //       decoration: BoxDecoration(
                  //           // color: Colours.primary,
                  //           border:
                  //               Border.all(color: Colours.primary, width: 2),
                  //           borderRadius: BorderRadius.circular(7)),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: h10p * 0.2,
                  // ),
                  Padding(
                    padding: EdgeInsets.all(w1p * 2),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (setNewPinContext) => SetNewPin(
                                isFromForgotPinFlow: false,
                                emailId: authManager
                                        .userDetails?.value?.user?.email ??
                                    "",
                              ),
                            ));
                      },
                      child: Container(
                        width: w10p * 8,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Center(
                            child: ConstantText(
                                color: Color.fromARGB(255, 43, 42, 42),
                                text:
                                    authManager.userDetails?.value?.login_pin ??
                                            false
                                        ? update_pin
                                        : set_new_pin,
                                style: TextStyles.textStyle5)),
                        decoration: BoxDecoration(
                            // color: const Color.fromARGB(255, 0, 0, 0),
                            border:
                                Border.all(color: Colours.primary, width: 2),
                            borderRadius: BorderRadius.circular(7)),
                      ),

                      // child: Container(
                      //   width: w10p * 8,
                      //   padding: const EdgeInsets.symmetric(vertical: 14),
                      //   child: const Center(
                      //       child: ConstantText(
                      //           color: Color.fromARGB(255, 43, 42, 42),
                      //           text: "Change PIN",
                      //           style: TextStyles.textStyle5)),
                      //   decoration: BoxDecoration(
                      //       // color: const Color.fromARGB(255, 0, 0, 0),
                      //       border:
                      //           Border.all(color: Colours.primary, width: 2),
                      //       borderRadius: BorderRadius.circular(7)),
                      // ),
                    ),
                  ),
                ]),
              )));
    });
  }
}
