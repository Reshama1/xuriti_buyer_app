import 'package:flutter/material.dart';
import 'package:xuriti/ui/theme/constants.dart';

import '../../new modules/common_widget.dart';
import '../../new modules/image_assetpath_constants.dart';
import '../../util/common/string_constants.dart';
import '../../util/common/text_constant_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          body: ListView(children: [
            SizedBox(
              height: h1p * 2,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 64,
                      height: 23,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: ImageFromAssetPath<Widget>(
                                assetPath: ImageAssetpathConstant.xuriti1)
                            .provider,
                        fit: BoxFit.fill,
                      ))),
                  // Vector
                  Column(
                    children: [
                      Container(
                          width: 20,
                          height: 1.25,
                          decoration: const BoxDecoration(color: Colors.white)),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: 20,
                          height: 1.25,
                          decoration: const BoxDecoration(color: Colors.white)),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: 20,
                          height: 1.25,
                          decoration: const BoxDecoration(color: Colors.white)),
                    ],
                  )
                  //   ),
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 25,
                ),
                Stack(children: [
                  Container(
                      width: w10p * 1.3,
                      height: h10p * 0.8,
                      decoration: BoxDecoration(
                          color: Colours.black,
                          image: DecorationImage(
                            image: ImageFromAssetPath<Widget>(
                                    assetPath: ImageAssetpathConstant.hexagon)
                                .provider,
                            fit: BoxFit.fill,
                          ))),
                ]),
                const SizedBox(
                  width: 25,
                ),
                Opacity(
                    opacity: 0.6000000238418579,
                    child: Container(
                      width: w10p * 3.1,
                      height: h10p * 0.7,
                      decoration: const BoxDecoration(
                        color: Colours.almostBlack,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: h1p * 1,
                          ),
                          const ConstantText(
                            text: "Total Credit Limit",
                            style: TextStyles.textStyle21,
                          ),
                          SizedBox(
                            height: h1p * 0.1,
                          ),
                          const ConstantText(
                            text: "₹ 89,000",
                            style: TextStyles.textStyle22,
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  width: w10p * 2.6,
                ),
                Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: ImageFromAssetPath<Widget>(
                              assetPath: ImageAssetpathConstant.profileScreens)
                          .provider,
                      fit: BoxFit.fill,
                    ))),
              ],
            ),
            SizedBox(
              height: h1p * 3.3,
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
                child: ListView(children: [
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: h1p * 3,
                        ),
                        Card(
                          child: ListTile(
                            leading: Container(
                              width: 27.803,
                              height: 31.697,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: ImageFromAssetPath<Widget>(
                                        assetPath:
                                            ImageAssetpathConstant.polygon)
                                    .provider,
                                fit: BoxFit.fill,
                              )),
                            ),
                            title: Column(
                              children: [
                                Row(
                                  children: const [
                                    ConstantText(
                                      text: "Wohoo",
                                      style: TextStyles.textStyle20,
                                    ),
                                    ConstantText(
                                      text: "!! you have saved",
                                      style: TextStyles.textStyle34,
                                    ),
                                    ConstantText(
                                      text: " ₹ 12,345",
                                      style: TextStyles.textStyle35,
                                    ),
                                    ConstantText(
                                      text: " so far..",
                                      style: TextStyles.textStyle34,
                                    ),
                                  ],
                                ),
                                ConstantText(
                                  text: pay_early_and_save_more,
                                  style: TextStyles.textStyle34,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h1p * 5,
                        ),
                        Row(
                          children: [
                            const ConstantText(
                              text: "Upcoming Payments",
                              style: TextStyles.textStyle17,
                            ),
                            SizedBox(
                              width: w10p * 3,
                            ),
                            ConstantText(
                              text: "₹ 3,12,345",
                              style: TextStyles.textStyle24(),
                            )
                          ],
                        ),
                        SizedBox(
                          height: h1p * 3,
                        ),
                        Card(
                            child: ListTile(
                          leading: Column(
                            children: [
                              Row(
                                children: [
                                  const ConstantText(
                                    text: "#4321 ",
                                    style: TextStyles.textStyle6,
                                  ),
                                  Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          //color: Colors.black
                                          image: DecorationImage(
                                        image: ImageFromAssetPath<Widget>(
                                                assetPath:
                                                    ImageAssetpathConstant
                                                        .arrowPng)
                                            .provider,
                                        fit: BoxFit.fill,
                                      ))),
                                ],
                              ),
                              ConstantText(
                                text: "Asian Paints",
                                style: TextStyles.textStyle18,
                              )
                            ],
                          ),
                          trailing: Column(
                            children: [
                              SizedBox(
                                width: w10p * 30,
                              ),
                              const ConstantText(
                                text: "05 days left",
                                style: TextStyles.textStyle16,
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  )
                ]))
          ]));
    });
  }
}
