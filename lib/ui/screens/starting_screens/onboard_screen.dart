import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/theme/constants.dart';
import 'package:xuriti/util/common/string_constants.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;
  PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    Container DotBuild({required Color color}) {
      return Container(
        margin: const EdgeInsets.all(3),
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
      );
    }

    List<String> text1 = [
      on_board_screen_slogan_first,
      on_board_screen_slogan_second,
      on_board_screen_slogan_first
    ];
    List<String> images = [
      ImageAssetpathConstant.onboardImage1,
      ImageAssetpathConstant.onboardImage2,
      ImageAssetpathConstant.onboardImage3
    ];

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;

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
        body: Stack(
          children: [
            Positioned(
              bottom: h10p * 4,
              child: currentIndex == 0
                  ? CenterWidgetOne()
                  : currentIndex == 1
                      ? CenterWidgetTwo()
                      : CenterWidgetThree(),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))),
                  width: maxWidth,
                  height: h10p * 4,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: w10p * 0.5,
                            left: w10p * 0.5,
                            top: w10p * 0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ConstantText(
                              text: "${currentIndex + 1}/3",
                              style: TextStyles.textStyle13,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (currentIndex >= 2) {
                                  getIt<SharedPreferences>()
                                      .setString('onboardViewed', 'true');
                                  Navigator.pushReplacementNamed(
                                      context, getStarted);
                                  return;
                                } else {
                                  setState(() {
                                    currentIndex = currentIndex + 1;
                                    _controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  });
                                }
                              },
                              child: ImageFromAssetPath<Widget>(
                                assetPath: ImageAssetpathConstant.arrowCircle,
                              ).imageWidget,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: PageView.builder(
                            controller: _controller,
                            onPageChanged: (value) {
                              setState(() {
                                currentIndex = value;
                              });
                            },
                            itemCount: text1.length,
                            itemBuilder: (context, index) {
                              return Center(
                                child: Container(
                                  child: ImageFromAssetPath<Widget>(
                                          assetPath: images[index])
                                      .imageWidget,
                                ),
                              );
                            }),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: h1p * 3, bottom: h1p * 3),
                              child: ConstantText(
                                text: text1[currentIndex],
                                style: TextStyles.textStyle10,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: h1p * 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DotBuild(
                                      color: currentIndex == 0
                                          ? Colors.blue
                                          : Colors.black),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: DotBuild(
                                        color: currentIndex == 1
                                            ? Colors.blue
                                            : Colors.black),
                                  ),
                                  DotBuild(
                                      color: currentIndex == 2
                                          ? Colors.blue
                                          : Colors.black),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      );
    });
  }
}

class CenterWidgetOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: ConstantText(
              text: payment_made_easy,
              style: TextStyles.textStyle11,
            ),
          ),
          Row(
            children: [
              ImageFromAssetPath<Widget>(
                      assetPath: ImageAssetpathConstant.polygon)
                  .imageWidget,
              const SizedBox(width: 10),
              ConstantText(
                text: invoice_payment_made_easy,
                style: TextStyles.textStyle12(),
              )
            ],
          ),
          Row(
            children: [
              ImageFromAssetPath<Widget>(
                      assetPath: ImageAssetpathConstant.polygon)
                  .imageWidget,
              const SizedBox(width: 10),
              ConstantText(
                text: one_click_payments,
                style: TextStyles.textStyle12(),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CenterWidgetTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: ConstantText(
              text: maximise_your_savings,
              style: TextStyles.textStyle11,
            ),
          ),
          Row(
            children: [
              ImageFromAssetPath<Widget>(
                      assetPath: ImageAssetpathConstant.polygon)
                  .imageWidget,
              const SizedBox(width: 10),
              ConstantText(
                text: pay_early_and_save_more,
                style: TextStyles.textStyle12(),
              )
            ],
          ),
          Row(
            children: [
              ImageFromAssetPath<Widget>(
                      assetPath: ImageAssetpathConstant.polygon)
                  .imageWidget,
              const SizedBox(width: 10),
              ConstantText(
                text: invoice_payment_made_easy,
                style: TextStyles.textStyle12(),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CenterWidgetThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: ConstantText(
              text: get_rewarded_on_every_transaction,
              style: TextStyles.textStyle11,
            ),
          ),
          Row(
            children: [
              ImageFromAssetPath<Widget>(
                      assetPath: ImageAssetpathConstant.polygon)
                  .imageWidget,
              const SizedBox(width: 10),
              ConstantText(
                text: invoice_payment_made_easy,
                style: TextStyles.textStyle12(),
              )
            ],
          ),
          Row(
            children: [
              ImageFromAssetPath<Widget>(
                      assetPath: ImageAssetpathConstant.polygon)
                  .imageWidget,
              const SizedBox(width: 10),
              ConstantText(
                text: one_click_payments,
                style: TextStyles.textStyle12(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
