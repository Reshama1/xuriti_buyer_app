import 'package:flutter/material.dart';

import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/payment_history_widgets/leading.dart';

class AllGuideScreen extends StatefulWidget {
  const AllGuideScreen({Key? key}) : super(key: key);

  @override
  State<AllGuideScreen> createState() => _AllGuideScreenState();
}

class _AllGuideScreenState extends State<AllGuideScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      List<String> guideTitle = [
        save_more,
        get_rewarded,
      ];
      List<String> guideImage = [
        ImageAssetpathConstant.allGuide1,
        ImageAssetpathConstant.allGuide2,
      ];
      List<String> guideSimage = [
        ImageAssetpathConstant.guideSimage1,
        ImageAssetpathConstant.guideSimage2,
      ];
      List<String> guideSubTitle = [
        "Discounts on prompt payment",
        "Pay on time to get rewards",
      ];
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Scaffold(
        backgroundColor: Colours.black,
        appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            toolbarHeight: h10p * .8,
            flexibleSpace: AppbarWidget()),
        body: Container(
            width: maxWidth,
            height: maxHeight,
            decoration: const BoxDecoration(
                color: Colours.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
            child: Column(
              children: [
                LeadingWidget(
                  heading: "All Guides",
                ),
                SizedBox(
                  height: h1p * 2,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, guideDetails);
                    },
                    child: Container(
                      width: maxWidth,
                      child: ListView.builder(
                        itemCount: 2,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: w10p * .2),
                            child: Column(
                              children: [
                                Container(
                                  width: maxWidth,
                                  height: h10p * 2.5,
                                  color: Colors.transparent,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          // height: h10p * 2.7,
                                          width: maxWidth,

                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colours.brownishOrange,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: w10p * .5,
                                                    vertical: h10p * .05),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ConstantText(
                                                      text: guideTitle[index],
                                                      style:
                                                          TextStyles.subHeading,
                                                    ),
                                                    const ConstantText(
                                                      text: "Rp 5.000.000",
                                                      style:
                                                          TextStyles.subValue,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ImageFromAssetPath<Widget>(
                                                assetPath: guideImage[index],
                                                width: maxWidth,
                                              ).imageWidget,
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: w10p * .5,
                                                    vertical: h1p * .7),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: ConstantText(
                                                      text:
                                                          guideSubTitle[index],
                                                      style: TextStyles
                                                          .guideSubTitle,
                                                    )),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                            onTap: () {},
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          w10p *
                                                                              .3),
                                                              child: ImageFromAssetPath<
                                                                          Widget>(
                                                                      assetPath:
                                                                          ImageAssetpathConstant
                                                                              .guideArrow)
                                                                  .imageWidget,
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
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
                                (index < 1)
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: w10p * 1),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Opacity(
                                              opacity: 0.6000000238418579,
                                              child: Container(
                                                height: h10p * .8,
                                                width: w10p * .07,
                                                color: Colours.grey,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )),
      );
    });
  }
}
