import 'package:flutter/material.dart';

import 'package:xuriti/util/loaderWidget_second.dart';

import '../../new modules/common_widget.dart';
import '../../new modules/image_assetpath_constants.dart';
import '../../util/common/string_constants.dart';
import '../../util/common/text_constant_widget.dart';
import '../theme/constants.dart';

class InvoiceLoader extends StatefulWidget {
  final double maxHeight;
  final double maxWidth;
  final String name;
  // double h1p;
  // double h10p;
  // double w10p;
  InvoiceLoader(
      {required this.maxHeight, required this.maxWidth, required this.name});
  @override
  State<StatefulWidget> createState() {
    return StateInvoiceLoader();
  }
}

class StateInvoiceLoader extends State<InvoiceLoader> {
  late double maxHeight;
  late double maxWidth;
  late double h1p;
  late double h10p;
  late double w10p;
  late String name;
  @override
  void initState() {
    maxHeight = widget.maxHeight;
    maxWidth = widget.maxWidth;
    h1p = maxHeight * 0.01;
    h10p = maxHeight * 0.1;
    w10p = maxWidth * 0.1;
    name = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Container(
              width: maxWidth,
              height: maxHeight,
              decoration: const BoxDecoration(
                  color: Colours.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18, vertical: h1p * 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ConstantText(
                              text: "$name", style: TextStyles.textStyle38),
                          // Row(
                          //   children: [
                          //     Text(
                          //       "Filters     ",
                          //       style: TextStyles.textStyle38,
                          //     ),
                          //     ImageFromAssetPath<Widget>(assetPath: "assets/images/filterRight.svg"),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w10p * .6, vertical: h1p * 1),
                      child: Container(
                          width: maxWidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colours.offWhite),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: h1p * 3, horizontal: w10p * .3),
                            child: Row(children: [
                              ImageFromAssetPath<Widget>(
                                      assetPath: ImageAssetpathConstant.logo1)
                                  .imageWidget,
                              SizedBox(
                                width: w10p * 0.5,
                              ),
                              Expanded(
                                child: ConstantText(
                                  text:
                                      please_wait_while_we_connect_you_with_your_sellers,
                                  style: TextStyles.textStyle34,
                                ),
                              ),
                            ]),
                          )),
                    ),
                    SizedBox(
                      height: h1p * 8,
                    ),
                    Center(
                      child: ImageFromAssetPath<Widget>(
                              assetPath: ImageAssetpathConstant.onboardImage3)
                          .imageWidget,
                    ),
                  ],
                ),
              ),
            )),
        Container(
            color: Colors.transparent.withOpacity(0.5),
            child: context.getLoaderWidget_2()),
      ],
    );
  }
}
