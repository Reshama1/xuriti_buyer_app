import 'package:flutter/material.dart';
import 'package:xuriti/ui/screens/signup_and_login_screens/login_screen.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';

import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class ForgetPasswordSecondScreen extends StatefulWidget {
  final LoginOption loginOption;
  const ForgetPasswordSecondScreen({Key? key, required this.loginOption})
      : super(key: key);

  @override
  State<ForgetPasswordSecondScreen> createState() =>
      _ForgetPasswordSecondScreen();
}

class _ForgetPasswordSecondScreen extends State<ForgetPasswordSecondScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Scaffold(
          backgroundColor: Colours.black,
          resizeToAvoidBottomInset: true,
          body: ListView(children: [
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
                child: Column(children: [
                  Center(
                      child: Form(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                        SizedBox(
                          height: h1p * 3.5,
                        ),
                        ConstantText(
                          text: widget.loginOption == LoginOption.password
                              ? forgot_password
                              : "Forgot PIN?",
                          style: TextStyles.textStyle3,
                        ),
                        SizedBox(
                          height: h1p * 3,
                        ),
                        Container(
                          width: w10p * 9,
                          decoration: const BoxDecoration(
                            color: Colours.paleGrey,
                          ),
                          child: TextBoxField(
                            controller: emailController,
                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fillColor: Colours.paleGrey,
                            hintText: new_password,
                            hintStyle: TextStyles.textStyle4,
                          ),
                        ),
                        SizedBox(
                          height: h1p * 2.5,
                        ),
                        Container(
                          width: w10p * 9,
                          decoration: const BoxDecoration(
                            color: Colours.paleGrey,
                          ),
                          child: TextBoxField(
                            controller: emailController,
                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fillColor: Colours.paleGrey,
                            hintText: confirm_password,
                            hintStyle: TextStyles.textStyle4,
                          ),
                        ),
                        SizedBox(
                          height: h10p * .5,
                        ),
                        Container(
                          width: w10p * 4.5,
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(vertical: h1p * 1),
                            child: ConstantText(
                                text: change_password,
                                style: TextStyles.textStyle5),
                          )),
                          decoration: BoxDecoration(
                              color: Colours.primary,
                              borderRadius: BorderRadius.circular(7)),
                        ),
                      ])))
                ]))
          ]));
    });
  }
}
