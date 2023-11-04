import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xuriti/ui/screens/starting_screens/company_list.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class NotificationProfile extends StatefulWidget {
  final dynamic creditLimit;
  final dynamic availCredt;
  // NotificationProfile(
  //   @required this.creditLimit,
  //   @required this.availCredt,
  // );
  final GlobalKey<ScaffoldState>? pskey;

  NotificationProfile(
      {required this.creditLimit,
      required this.availCredt,
      Key? key,
      this.pskey})
      : super(key: key);

  @override
  State<NotificationProfile> createState() => _NotificationProfileState();
}

class _NotificationProfileState extends State<NotificationProfile> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;

      return Container(
        height: maxHeight,
        width: maxWidth,
        color: Colours.black,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 39, left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageFromAssetPath<Widget>(
                          assetPath: ImageAssetpathConstant.xuriti1)
                      .imageWidget,
                  // InkWell(
                  //     onTap: () {
                  //       widget.pskey!.currentState!.openEndDrawer();
                  //     },
                  //     child: ImageFromAssetPath<Widget>(assetPath: "assets/images/menubutton.svg"))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 30),
                          child: ImageFromAssetPath<Widget>(
                                  assetPath:
                                      ImageAssetpathConstant.rewardLevel2)
                              .imageWidget,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 29),
                          child: ConstantText(
                            text: level_two,
                            style: TextStyles.textStyle86,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 15),
                      child: Opacity(
                          opacity: 0.6000000238418579,
                          child: Container(
                            // width: w10p * 3.7,
                            height: h10p * 3.5,
                            decoration: const BoxDecoration(
                              color: Colours.almostBlack,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: h1p * 3.5,
                                ),
                                const ConstantText(
                                  text: total_credit_limit_credit_available,
                                  style: TextStyles.textStyle71,
                                ),
                                SizedBox(
                                  height: h1p * 0.2,
                                ),
                                ConstantText(
                                  text:
                                      "₹ ${widget.creditLimit} ${lacs}/₹ ${widget.availCredt} ${lacs}",
                                  style: TextStyles.textStyle22,
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAll(CompanyList());
                  },
                  child: Padding(
                      padding: EdgeInsets.only(right: 15, top: 10),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1, color: Colors.white)
                            //more than 50% of width makes circle
                            ),
                        child: Icon(
                          Icons.business_center,
                          color: Colours.tangerine,
                        ),
                      )),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
