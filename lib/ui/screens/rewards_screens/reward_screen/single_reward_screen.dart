import 'package:flutter/material.dart';
import 'package:xuriti/util/common/string_constants.dart';

import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../theme/constants.dart';

class SingleReward extends StatefulWidget {
  const SingleReward({Key? key}) : super(key: key);

  @override
  State<SingleReward> createState() => _OnboardState();
}

class _OnboardState extends State<SingleReward> {
  bool isClaimed = false;
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;

      return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              title: ImageFromAssetPath<Widget>(
                assetPath: ImageAssetpathConstant.xuritiLogo,
                width: 75,
              ).imageWidget,
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: ImageFromAssetPath<Widget>(
                            assetPath: ImageAssetpathConstant.closeWhite)
                        .imageWidget,
                  ),
                )
              ]),
          body: Container(
              width: maxWidth,
              height: maxHeight,
              decoration: const BoxDecoration(
                color: Colours.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              // child:
              child: Stack(
                children: [
                  Container(
                    width: maxWidth,
                    height: h1p * 33,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ImageFromAssetPath<Widget>(
                                  assetPath: ImageAssetpathConstant.rewardImage)
                              .provider),
                      color: Colors.green,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(18)),
                    ),
                  ),
                  Positioned(
                      top: h1p * 31,
                      left: (maxWidth - w10p * 9.5) / 2,
                      right: (maxWidth - w10p * 9.5) / 2,
                      child: Column(
                        children: [
                          Container(
                            width: maxWidth,
                            height: h1p * 20,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 0.5,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1)),
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3.0, horizontal: 8),
                                          child: ConstantText(
                                              text: "Travel",
                                              style: TextStyles.textStyle45),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colours.peach,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      const ConstantText(
                                          text:
                                              "3 Star hotel stay for  2 pax x 2 nights",
                                          style: TextStyles.textStyle89),
                                      const ConstantText(
                                          text:
                                              "Flat ₹ 8,000/- OFF on MMT Website ",
                                          style: TextStyles.textStyle81)
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 18.0),
                                    child: ImageFromAssetPath<Widget>(
                                            assetPath: ImageAssetpathConstant
                                                .entertainment2)
                                        .imageWidget,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Container(
                            width: w10p * 8,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 0.5,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1)),
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const ConstantText(
                                          text: "Code:   ",
                                          style: TextStyles.textStyle44),
                                      ConstantText(
                                        text: isShow
                                            ? "MMT012FVPTG34K"
                                            : "***********",
                                        style: TextStyles.textStyle91,
                                      )
                                    ],
                                  ),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          isShow = !isShow;
                                        });
                                      },
                                      child: ConstantText(
                                          text: isShow ? "📄 Copy" : "Show",
                                          style: isShow
                                              ? TextStyles.textStyle45
                                              : TextStyles.textStyle92))
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ConstantText(
                                text: isClaimed
                                    ? reward_claimed
                                    : "Reward expires in 40 days",
                                style: TextStyles.textStyle90),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25)),
                                  ),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return Wrap(
                                      children: [
                                        Container(
                                          width: maxWidth,
                                          height: h10p * 4,
                                          child: Padding(
                                            padding: const EdgeInsets.all(18),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const ConstantText(
                                                  text: "Reward Details",
                                                  style: TextStyles.textStyle89,
                                                ),
                                                Row(
                                                  children: [
                                                    ImageFromAssetPath<Widget>(
                                                            assetPath:
                                                                ImageAssetpathConstant
                                                                    .circleYellow)
                                                        .imageWidget,
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    const Expanded(
                                                        child: ConstantText(
                                                      text:
                                                          "Get flat ₹ 8,000/- OFF on MMT Website  ",
                                                      style: TextStyles
                                                          .textStyle90,
                                                      textAlign:
                                                          TextAlign.justify,
                                                    )),
                                                    const SizedBox(
                                                      width: 10,
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    ImageFromAssetPath<Widget>(
                                                            assetPath:
                                                                ImageAssetpathConstant
                                                                    .circleYellow)
                                                        .imageWidget,
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    const Expanded(
                                                        child: ConstantText(
                                                      text:
                                                          "Minimum booking value of  ₹ 9,999/-",
                                                      style: TextStyles
                                                          .textStyle90,
                                                      textAlign:
                                                          TextAlign.justify,
                                                    )),
                                                    const SizedBox(
                                                      width: 10,
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ImageFromAssetPath<Widget>(
                                                            assetPath:
                                                                ImageAssetpathConstant
                                                                    .circleYellow)
                                                        .imageWidget,
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    const Expanded(
                                                        child: ConstantText(
                                                      text:
                                                          "Description about the reward if any. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
                                                      style: TextStyles
                                                          .textStyle90,
                                                      textAlign:
                                                          TextAlign.justify,
                                                    )),
                                                    const SizedBox(
                                                      width: 10,
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  width: maxWidth,
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8,
                                                            horizontal: 24),
                                                    child: ConstantText(
                                                        text:
                                                            "Note : This is where any special notes regarding the\nreward or offer is to be displayed",
                                                        style: TextStyles
                                                            .textStyle81),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Colours.lightGrey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    ConstantText(
                                                      text: "Learn More",
                                                      style: TextStyle(
                                                        color: Colours.primary,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: "Poppins",
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 18.0,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              width: maxWidth,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 0.5,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1)),
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const ConstantText(
                                      text: "Reward Details",
                                      style: TextStyles.textStyle44,
                                    ),
                                    ImageFromAssetPath<Widget>(
                                      assetPath: ImageAssetpathConstant
                                          .arrowCircleRight,
                                    ).imageWidget
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                  Positioned(
                      bottom: 0,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isClaimed = true;
                          });
                        },
                        child: Container(
                          width: maxWidth,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: isClaimed ? Colors.grey : Colours.pumpkin,
                          ),
                          child: Center(
                              child: ConstantText(
                                  text: isClaimed ? "Claimed" : "Claim Reward",
                                  style: TextStyles.textStyle46)),
                        ),
                      ))
                ],
              )));
    });
  }
}
