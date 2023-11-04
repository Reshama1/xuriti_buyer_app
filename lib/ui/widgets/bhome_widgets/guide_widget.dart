import 'package:flutter/material.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class GuideWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;

  const GuideWidget({
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    List<String> guideTitle = [
      save_more,
      get_rewarded,
      extend_credit,
    ];
    List<String> guideSimage = [
      ImageAssetpathConstant.guideSimage1,
      ImageAssetpathConstant.guideSimage2,
      ImageAssetpathConstant.guideSimage3,
    ];
    List<String> guideImage = [
      ImageAssetpathConstant.guideImage1,
      ImageAssetpathConstant.guideImage2,
      ImageAssetpathConstant.guideImage3,
    ];
    //   List<Function> _widgetOptions = [
    //   FlyyFlutterPlugin.openFlyyOffersPage(),
    //   FlyyFlutterPlugin.openFlyyRewardsPage(),
    //   FlyyFlutterPlugin.openFlyyWalletPage(),
    // ];

    //   final List<Function> listOfFunctions = [
    //   FlyyFlutterPlugin.openFlyyRewardsPage(),
    //  ];

    double h1p = maxHeight * 0.01;
    double h10p = maxHeight * 0.1;
    double w10p = maxWidth * 0.1;
    return Container(
      height: h10p * 3.6,
      color: Colors.transparent,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: w10p * .2),
            child: Container(
              width: w10p * 5,
              height: h10p * 3.6,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: InkWell(
                      onTap: () {
                        // FlyyFlutterPlugin.openFlyyOffersPage();
                      },
                      child: Container(
                        // height: h10p * 2.7,
                        width: w10p * 5,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colours.pumpkin,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w10p * .5, vertical: h10p * .2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ConstantText(
                                        text: guideTitle[index],
                                        style: TextStyles.subHeading,
                                      ),
                                      const ConstantText(
                                        text: "Rp 5.000.000",
                                        style: TextStyles.subValue,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ImageFromAssetPath<Widget>(
                                    assetPath: guideImage[index])
                                .imageWidget,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w10p * .5, vertical: h1p * 2),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: ConstantText(
                                    text: " \n \n",
                                    style: TextStyles.guideSubTitle,
                                  )),
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            //here
                                            //  FlyyFlutterPlugin.openFlyyOffersPage();
                                          },
                                          child: ImageFromAssetPath<Widget>(
                                                  assetPath:
                                                      ImageAssetpathConstant
                                                          .guideArrow)
                                              .imageWidget),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: ImageFromAssetPath<Widget>(
                              assetPath: guideSimage[index])
                          .imageWidget),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
