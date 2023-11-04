import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:xuriti/ui/theme/constants.dart';

import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';

class LevelContainer extends StatelessWidget {
  final int index;
  LevelContainer(this.index);
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> list = [
      {"level": "1", "bgimage": ""},
      {"level": "2", "bgimage": ImageAssetpathConstant.bgImage1},
      {"level": "3", "bgimage": ImageAssetpathConstant.bgImage2}
    ];
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 8),
        child: Container(
          margin: const EdgeInsets.all(2),
          width: 250,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: ImageFromAssetPath<Widget>(
                          assetPath: "${list[index]["bgimage"]}")
                      .provider),
              borderRadius: BorderRadius.circular(28),
              color: Colours.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.1,
                    blurRadius: 1,
                    offset: Offset(
                      0,
                      1,
                    )),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ConstantText(
                            text: xuriti_rewards,
                            style: TextStyles.textStyle37),
                        ConstantText(
                            text: rewardLevel_(list[index]["level"]),
                            style: TextStyles.textStyle38),
                      ],
                    ),
                    Row(
                      children: const [
                        ConstantText(text: "0", style: TextStyles.textStyle39),
                        ConstantText(text: "50", style: TextStyles.textStyle38),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: LinearPercentIndicator(
                      padding: EdgeInsets.all(0), //leaner progress bar
                      animation: true,
                      animationDuration: 1000,
                      lineHeight: 15,
                      percent: 70 / 100,
                      progressColor: Colors.amber,
                      backgroundColor: Colors.grey.withOpacity(0.3)),
                ),
                const ConstantText(
                  text: reward_claimed,
                  style: TextStyles.textStyle40,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
