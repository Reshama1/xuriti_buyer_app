import 'package:flutter/material.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/util/common/string_constants.dart' as string_constant;

import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _OnboardState();
}

class _OnboardState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;

      double h10p = maxHeight * 0.1;

      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
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
        body: Container(
          padding: const EdgeInsets.all(30),
          width: maxWidth,
          height: maxHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: h10p),
                    child: ImageFromAssetPath<Widget>(
                            assetPath: ImageAssetpathConstant.icon_2)
                        .imageWidget,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                child: ConstantText(
                  text: string_constant.get_started,
                  style: TextStyles.textStyle15,
                ),
              ),
              Row(children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageFromAssetPath<Widget>(
                                assetPath: ImageAssetpathConstant.google_Icon)
                            .imageWidget,
                        const SizedBox(
                          width: 18,
                        ),
                        const ConstantText(
                            text: string_constant.continue_with_google,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0)),
                      ],
                    )),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colours.black, width: 1),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7)),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(children: [
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, signUp);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 14),
                        child: const Center(
                            child: ConstantText(
                                text: string_constant.create_account,
                                style: TextStyles.textStyle5)),
                        decoration: BoxDecoration(
                            color: Colours.primary,
                            borderRadius: BorderRadius.circular(7)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, login);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: const Center(
                            child: ConstantText(
                                text: string_constant.sign_in,
                                style: TextStyles.textStyle5)),
                        decoration: BoxDecoration(
                            color: Colours.primary,
                            borderRadius: BorderRadius.circular(7)),
                      ),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      );
    });
  }
}
