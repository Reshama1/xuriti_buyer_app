import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:xuriti/ui/routes/router.dart';
import '../../../../logic/view_models/reward_manager.dart';
import '../../../../models/core/reward_model.dart';
import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../theme/constants.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({Key? key}) : super(key: key);

  @override
  State<RewardScreen> createState() => _OnboardState();
}

class _OnboardState extends State<RewardScreen> {
  int currentIndex = 0;

  RewardManager rewardManager = Get.put(RewardManager());

  List<Widget> listScreens = [
    const LevelOneList(),
    const LevelTwoList(),
    const LevelThreeList(),
  ];
  List<Map<String, String>> listHeading = [
    {
      "heading": "Level 1 Rewards",
      "image": ImageAssetpathConstant.level1,
    },
    {
      "heading": "Level 2 Rewards",
      "image": ImageAssetpathConstant.level2,
    },
    {
      "heading": "Level 3 Rewards",
      "image": ImageAssetpathConstant.level3,
    },
  ];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      rewardManager.getRewards();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;

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
              Padding(
                padding: const EdgeInsets.all(15),
                child: ImageFromAssetPath<Widget>(
                        assetPath: ImageAssetpathConstant.menuBars)
                    .imageWidget,
              )
            ]),
        body: Container(
            width: maxWidth,
            height: maxHeight,
            decoration: const BoxDecoration(
                color: Colours.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
            // child:

            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 18, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: ImageFromAssetPath<Widget>(
                                        assetPath:
                                            ImageAssetpathConstant.arrowBack)
                                    .imageWidget),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: ConstantText(
                                    text: "Rewards",
                                    style: TextStyles.textStyle41)),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, allRewards);
                          },
                          child: Container(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 12),
                              child: ConstantText(
                                  text: "View All Rewards",
                                  style: TextStyles.textStyle42),
                            ),
                            decoration: BoxDecoration(
                                color: Colours.pumpkin,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      height: 140,
                      width: maxWidth,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          Rewards? currentReward = rewardManager
                              .rewardsDataResponse.value?.data?.rewards?[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9.0, vertical: 8),
                            child: Stack(children: [
                              Container(
                                margin: const EdgeInsets.all(2),
                                width: w10p * 9,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: ImageFromAssetPath<Widget>(
                                                assetPath: currentReward
                                                            ?.status ==
                                                        "CLAIMED"
                                                    ? ImageAssetpathConstant
                                                        .completedReward
                                                    : currentReward?.status ==
                                                            "UNCLAIMED"
                                                        ? ImageAssetpathConstant
                                                            .bgImage1
                                                        : currentReward
                                                                    ?.status ==
                                                                "LOCKED"
                                                            ? ImageAssetpathConstant
                                                                .bgImage2
                                                            : ImageAssetpathConstant
                                                                .bgImage2)
                                            .provider),
                                    borderRadius: BorderRadius.circular(28),
                                    color: Colours.white,
                                    // border: Border.all(color: Colours.black,width: 0.5),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 0.1,
                                          blurRadius: 1,
                                          offset: Offset(
                                            0,
                                            1,
                                          )),
                                      // BoxShadow(color: Colors.grey,spreadRadius: 0.5,blurRadius: 1,
                                      //     offset: Offset(1,1,))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 18),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const ConstantText(
                                                  text: "Xuriti Rewards",
                                                  style:
                                                      TextStyles.textStyle104),
                                              ConstantText(
                                                  text:
                                                      "Level ${currentReward?.level}",
                                                  style: currentReward
                                                              ?.status ==
                                                          "CLAIMED"
                                                      ? TextStyles.textStyle46
                                                      : TextStyles.textStyle38),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              ConstantText(
                                                  text: "15",
                                                  style: currentReward
                                                              ?.status ==
                                                          "CLAIMED"
                                                      ? TextStyles.textStyle105
                                                      : TextStyles.textStyle39),
                                              ConstantText(
                                                  text: "/15",
                                                  style: currentReward
                                                              ?.status ==
                                                          "CLAIMED"
                                                      ? TextStyles.textStyle106
                                                      : TextStyles.textStyle38),
                                            ],
                                          ),
                                        ],
                                      ),
                                      currentReward?.status == "CLAIMED"
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18.0),
                                              child: LinearPercentIndicator(
                                                  padding: EdgeInsets.all(
                                                      0), //leaner progress bar
                                                  animation: true,
                                                  animationDuration: 1000,
                                                  lineHeight: 15,
                                                  percent: 100 / 100,
                                                  progressColor:
                                                      Colours.pumpkin,
                                                  backgroundColor: Colors.grey
                                                      .withOpacity(0.3)),
                                            )
                                          : currentReward?.status == "UNCLAIMED"
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 18.0),
                                                  child: LinearPercentIndicator(
                                                      padding: EdgeInsets.all(
                                                          0), //leaner progress bar
                                                      animation: true,
                                                      animationDuration: 1000,
                                                      lineHeight: 15,
                                                      percent: 50 / 100,
                                                      progressColor:
                                                          Colours.pumpkin,
                                                      backgroundColor: Colors
                                                          .grey
                                                          .withOpacity(0.3)),
                                                )
                                              : currentReward?.status ==
                                                      "LOCKED"
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 18.0),
                                                      child:
                                                          LinearPercentIndicator(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      0), //leaner progress bar
                                                              animation: true,
                                                              animationDuration:
                                                                  1000,
                                                              lineHeight: 15,
                                                              percent: 0 / 100,
                                                              progressColor:
                                                                  Colours
                                                                      .pumpkin,
                                                              backgroundColor:
                                                                  Colors.grey
                                                                      .withOpacity(
                                                                          0.3)),
                                                    )
                                                  : Container(),
                                      ConstantText(
                                          text: currentReward?.status ==
                                                  "CLAIMED"
                                              ? "Level Completed"
                                              : currentReward?.status ==
                                                      "UNCLAIMED"
                                                  ? "Complete 9 transactions to next reward"
                                                  : currentReward?.status ==
                                                          "LOCKED"
                                                      ? "Locked 🔒"
                                                      : "",
                                          style:
                                              currentReward?.status == "CLAIMED"
                                                  ? TextStyles.textStyle107
                                                  : TextStyles.textStyle40)
                                    ],
                                  ),
                                ),
                              ),
                              currentReward?.status == "CLAIMED"
                                  ? Positioned(
                                      top: h10p * 0.5,
                                      left: w10p * 2.5,
                                      child: Container(
                                        height: h10p * 0.4,
                                        width: w10p * 2.5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Colours.pumpkin,
                                        ),
                                        child: Center(
                                          child: ConstantText(
                                            text: "View Rewards",
                                            style: TextStyles.textStyle47,
                                          ),
                                        ),
                                      ))
                                  : Container(),
                              currentReward?.status == "CLAIMED"
                                  ? Positioned(
                                      top: h10p * 0.63,
                                      right: w10p * 0.67,
                                      child: ImageFromAssetPath<Widget>(
                                              assetPath: ImageAssetpathConstant
                                                  .leadingStar)
                                          .imageWidget,
                                    )
                                  : currentReward?.status == "UNCLAIMED"
                                      ? Positioned(
                                          top: h10p * 0.69,
                                          right: w10p * 3.4,
                                          child: ImageFromAssetPath<Widget>(
                                                  assetPath:
                                                      ImageAssetpathConstant
                                                          .leadingStar)
                                              .imageWidget,
                                        )
                                      : currentReward?.status == "LOCKED"
                                          ? Positioned(
                                              top: h10p * 0.7,
                                              right: w10p * 3.5,
                                              child: ImageFromAssetPath<Widget>(
                                                      assetPath:
                                                          ImageAssetpathConstant
                                                              .rewardLockedImage)
                                                  .imageWidget,
                                            )
                                          : Container(),
                            ]),
                          );
                        },
                        itemCount: 3,
                        // rewards.data!.rewards!.length,
                        loop: false,
                        viewportFraction: 0.8,
                        scale: 0.99,
                        onIndexChanged: (value) {
                          setState(() {
                            currentIndex = value;
                          });
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("${listHeading[currentIndex]["image"]}"),
                        SizedBox(
                          width: 8,
                        ),
                        ConstantText(
                          text: "${listHeading[currentIndex]["heading"]}",
                          style: TextStyles.textStyle43,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: maxWidth,
                      child: listScreens[currentIndex],
                    ),
                  )
                ],
              ),
            )),
      );
    });
  }
}

class LevelOneList extends StatefulWidget {
  const LevelOneList({Key? key}) : super(key: key);

  @override
  State<LevelOneList> createState() => _LevelOneListState();
}

class _LevelOneListState extends State<LevelOneList> {
  RewardManager rewardManager = Get.put(RewardManager());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;

      double w1p = maxWidth * 0.01;
      return ListView.builder(
          itemCount: rewardManager.rewardsDataResponse.value?.data?.rewards
              ?.where((element) => element.level == 1)
              .length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 9),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, singleReward);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colours.lightGrey,
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 18, horizontal: w1p * 2.5),
                        child: Column(
                          children: [
                            Container(
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 8),
                                child: ConstantText(
                                    text: "Xuriti Rewards",
                                    style: TextStyles.textStyle45),
                              ),
                              decoration: BoxDecoration(
                                  color: Colours.peach,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            ConstantText(
                                text: rewardManager.rewardsDataResponse.value
                                        ?.data?.rewards
                                        ?.where((element) => element.level == 1)
                                        .toList()[index]
                                        .reward ??
                                    '',
                                style: TextStyles.textStyle44),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colours.black80,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3.0, horizontal: 15),
                                  child: ConstantText(
                                      text: rewardManager.rewardsDataResponse
                                              .value?.data?.rewards
                                              ?.where((element) =>
                                                  element.level == 1)
                                              .toList()[index]
                                              .status ??
                                          '',
                                      style: TextStyles.textStyle46),
                                ))
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Image.asset(ImageAssetpathConstant.rewards),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}

class LevelTwoList extends StatefulWidget {
  const LevelTwoList({Key? key}) : super(key: key);

  @override
  State<LevelTwoList> createState() => _LevelTwoListState();
}

class _LevelTwoListState extends State<LevelTwoList> {
  RewardManager rewardManager = Get.put(RewardManager());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;

      double w1p = maxWidth * 0.01;
      return ListView.builder(
          itemCount: rewardManager.rewardsDataResponse.value?.data?.rewards
              ?.where((element) => element.level == 2)
              .length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: w1p * 2.5, vertical: 9),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, singleReward);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colours.lightGrey,
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 18),
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 8),
                                child: ConstantText(
                                    text: "Xuriti Rewards",
                                    style: TextStyles.textStyle45),
                              ),
                              decoration: BoxDecoration(
                                  color: Colours.peach,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            ConstantText(
                                text: rewardManager.rewardsDataResponse.value
                                        ?.data?.rewards
                                        ?.where((element) => element.level == 2)
                                        .toList()[index]
                                        .reward ??
                                    '',
                                style: TextStyles.textStyle44),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colours.black80,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3.0, horizontal: 15),
                                  child: ConstantText(
                                      text: rewardManager.rewardsDataResponse
                                              .value?.data?.rewards
                                              ?.where((element) =>
                                                  element.level == 2)
                                              .toList()[index]
                                              .status ??
                                          '',
                                      style: TextStyles.textStyle46),
                                ))
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Image.asset(ImageAssetpathConstant.rewards),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}

class LevelThreeList extends StatefulWidget {
  const LevelThreeList({Key? key}) : super(key: key);

  @override
  State<LevelThreeList> createState() => _LevelThreeListState();
}

class _LevelThreeListState extends State<LevelThreeList> {
  RewardManager rewardManager = Get.put(RewardManager());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;

      double w1p = maxWidth * 0.01;
      return ListView.builder(
          itemCount: rewardManager.rewardsDataResponse.value?.data?.rewards
              ?.where((element) => element.level == 3)
              .toList()
              .length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: w1p * 2.5, vertical: 9),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, singleReward);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colours.lightGrey,
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 18),
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 8),
                                child: ConstantText(
                                    text: "Xuriti Rewards",
                                    style: TextStyles.textStyle45),
                              ),
                              decoration: BoxDecoration(
                                  color: Colours.peach,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            ConstantText(
                                text: rewardManager.rewardsDataResponse.value
                                        ?.data?.rewards
                                        ?.where((element) => element.level == 3)
                                        .toList()[index]
                                        .reward ??
                                    '',
                                style: TextStyles.textStyle44),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colours.black80,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3.0, horizontal: 15),
                                  child: ConstantText(
                                      text: rewardManager.rewardsDataResponse
                                              .value?.data?.rewards
                                              ?.where((element) =>
                                                  element.level == 3)
                                              .toList()[index]
                                              .status ??
                                          '',
                                      style: TextStyles.textStyle46),
                                ))
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Image.asset(ImageAssetpathConstant.rewards),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}
