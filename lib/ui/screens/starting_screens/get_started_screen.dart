import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/ui/screens/signup_and_login_screens/signUp_screen.dart';
import 'package:xuriti/ui/theme/constants.dart';
import 'package:xuriti/util/common/string_constants.dart' as string_constant;
import 'package:xuriti/util/loaderWidget.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../routes/router.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  AuthManager authManager = Get.put(AuthManager());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;

      double w10p = maxWidth * 0.1;
      return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: ImageFromAssetPath<Widget>(
                              assetPath: ImageAssetpathConstant.xuritiLogo)
                          .imageWidget,
                    )
                  ]),
              backgroundColor: Colours.black,
              body: ProgressHUD(
                child: Builder(builder: (context) {
                  return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w10p * .5, vertical: h1p * 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstantText(
                            text: string_constant.get_started,
                            style: TextStyles.textStyle15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: Row(children: [
                              Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, signUp);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: const Center(
                                        child: ConstantText(
                                            text:
                                                string_constant.create_account,
                                            style: TextStyles.textStyle5)),
                                    decoration: BoxDecoration(
                                        color: Colours.primary,
                                        borderRadius: BorderRadius.circular(7)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, login);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: const Center(
                                        child: ConstantText(
                                            text: string_constant.sign_in,
                                            style: TextStyles.textStyle5)),
                                    decoration: BoxDecoration(
                                        color: Colours.primary,
                                        borderRadius: BorderRadius.circular(7)),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          if (Platform.isAndroid)
                            InkWell(
                              onTap: () async {
                                //     ScaffoldMessenger.of(context)
                                //         .showSnackBar(
                                //          SnackBar(
                                //           duration: Duration(seconds: 2),
                                //             behavior:
                                //             SnackBarBehavior
                                //                 .floating,

                                //               'sign up with google',
                                //               style: TextStyle(
                                //                   color: Colours
                                //                       .primary),
                                //             )));
                                //     AuthManager authManager =  getIt<AuthManager>();
                                //       String? message =   await  authManager.googleLogin();
                                // if(message == "User not found"){
                                //   Navigator.pushNamed(context, signUp);
                                // }else if(message == "User found") {
                                //   Navigator.pushNamed(context, landing);
                                // }
                                // else if(message == "company not registered"){
                                //   Navigator.pushNamed(context, businessRegister);
                                //
                                // }
                                // else if(message == "Your account is inactive"){
                                //   ScaffoldMessenger.of(context)
                                //       .showSnackBar(const SnackBar(
                                //       behavior: SnackBarBehavior.floating,

                                //         'Your account is inactive',
                                //         style: TextStyle(
                                //             color: Colours.primary),
                                //       )));
                                // }

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        duration: Duration(seconds: 2),
                                        behavior: SnackBarBehavior.floating,
                                        content: ConstantText(
                                          text: string_constant
                                              .signup_with_google,
                                          style:
                                              TextStyle(color: Colours.primary),
                                        )));

                                //progress!.show();
                                context.showLoader();
                                Map<String, dynamic>? message =
                                    await authManager.googleLogin(
                                        isSignIn: false);
                                //  progress.dismiss();
                                context.hideLoader();
                                if (message != null) {
                                  if (message['status'] == false) {
                                    if (message['message'] ==
                                        string_constant.user_not_found) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (signupContext) =>
                                                  SignUpScreen(
                                                      navigatedFromSignupGoogleButtonTapped:
                                                          true)));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: ConstantText(
                                                text: message['message'],
                                                style: TextStyle(
                                                    color: Colours.primary),
                                              )));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: ConstantText(
                                              text: message['message'],
                                              style: TextStyle(
                                                  color: Colours.primary),
                                            )));
                                    Navigator.pushNamed(context, oktWrapper);
                                  }
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: h1p),
                                child: Container(
                                  height: h1p * 7,
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ImageFromAssetPath<Widget>(
                                        assetPath:
                                            ImageAssetpathConstant.googleIcon,
                                        height: 20,
                                      ).imageWidget,
                                      const SizedBox(
                                        width: 18,
                                      ),
                                      const ConstantText(
                                          text: string_constant
                                              .signup_with_google,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Poppins",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.0)),
                                    ],
                                  )),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7)),
                                ),
                              ),
                            ),
                        ],
                      ));
                }),
              )));
    });
  }
}
