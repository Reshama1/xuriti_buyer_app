import 'package:flutter/material.dart';
import '../../new modules/common_widget.dart';
import '../../new modules/image_assetpath_constants.dart';
import '../../util/common/text_constant_widget.dart';
import '../theme/constants.dart';

class InvoiceNotFound extends StatefulWidget {
  final double maxHeight;
  final double maxWidth;
  final String notFoundMssg;
  final String name;
  InvoiceNotFound(
      {required this.maxHeight,
      required this.maxWidth,
      required this.notFoundMssg,
      required this.name});
  @override
  State<StatefulWidget> createState() {
    return StateInvoiceNotFound();
  }
}

class StateInvoiceNotFound extends State<InvoiceNotFound> {
  late double maxHeight;
  late double maxWidth;
  late double h1p;
  late double h10p;
  late double w10p;
  late String notFoundMssg;
  late String name;
  @override
  void initState() {
    maxHeight = widget.maxHeight;
    maxWidth = widget.maxWidth;
    h1p = maxHeight * 0.01;
    h10p = maxHeight * 0.1;
    w10p = maxWidth * 0.1;
    notFoundMssg = widget.notFoundMssg;
    name = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                        vertical: h1p * 4, horizontal: w10p * .3),
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
                              vertical: h1p * 4, horizontal: w10p * .3),
                          child: Row(children: [
                            ImageFromAssetPath<Widget>(
                                    assetPath: ImageAssetpathConstant.logo1)
                                .imageWidget,
                            SizedBox(
                              width: w10p * 0.5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ConstantText(
                                text: "$notFoundMssg",
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
            )));
  }
}
