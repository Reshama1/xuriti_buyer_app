import 'package:flutter/material.dart';

import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../routes/router.dart';
import '../../../theme/constants.dart';

class HomeSaveMore extends StatefulWidget {
  const HomeSaveMore({Key? key}) : super(key: key);

  @override
  State<HomeSaveMore> createState() => _HomeSaveMoreState();
}

class _HomeSaveMoreState extends State<HomeSaveMore> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      // double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return ExpansionTile(
        tilePadding: const EdgeInsets.only(
          left: 20,
        ),
        trailing: Container(
          width: w10p * .001,
          height: h1p * .001,
          decoration: BoxDecoration(border: Border.all(color: Colours.white)),
        ),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colours.offWhite,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const ConstantText(
                            text: "#4321",
                            style: TextStyles.textStyle6,
                          ),
                          ImageFromAssetPath<Widget>(
                                  assetPath: ImageAssetpathConstant.arrowRight)
                              .imageWidget,
                        ],
                      ),
                      const ConstantText(
                        text: "Company Name",
                        style: TextStyles.textStyle59,
                      ),
                      const ConstantText(
                        text: "You Save",
                        style: TextStyles.textStyle60,
                      ),
                      const ConstantText(
                        text: "₹ 545",
                        style: TextStyles.textStyle68,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const ConstantText(
                        text: "30 days left",
                        style: TextStyles.textStyle57,
                      ),
                      const ConstantText(
                        text: "₹ 1,42,345",
                        style: TextStyles.textStyle58,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, paynow);
                          },
                          child: ImageFromAssetPath<Widget>(
                                  assetPath: ImageAssetpathConstant.button)
                              .imageWidget),
                    ],
                  )
                ]),
          ),
        ),
        children: [
          Card(
            elevation: .5,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 25,
              ),
              child: Container(
                // decoration: BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                            height: 4,
                          ),
                          ConstantText(
                            text: "Invoice Date",
                            style: TextStyles.textStyle62,
                          ),
                          ConstantText(
                            text: "12.Jun.2022",
                            style: TextStyles.textStyle63,
                          ),
                          ConstantText(
                            text: "Company Name",
                            style: TextStyles.textStyle64,
                          ),
                        ],
                      ),
                      ImageFromAssetPath<Widget>(
                              assetPath: ImageAssetpathConstant.arrowSvg)
                          .imageWidget,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          SizedBox(
                            height: 4,
                          ),
                          ConstantText(
                            text: "Due Date",
                            style: TextStyles.textStyle62,
                          ),
                          ConstantText(
                            text: "28.Jun.2022",
                            style: TextStyles.textStyle63,
                          ),
                          ConstantText(
                            text: "Company Name",
                            style: TextStyles.textStyle64,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 25,
            ),
            child: Card(
              elevation: .5,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(
                                height: 4,
                              ),
                              ConstantText(
                                text: "Invoice Amount",
                                style: TextStyles.textStyle62,
                              ),
                              ConstantText(
                                text: "₹ 1,42,345",
                                style: TextStyles.textStyle65,
                              )
                              //    ConstantText(
                              // text:"Asian Paints",style: TextStyles.textStyle34,),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              SizedBox(
                                height: 4,
                              ),
                              ConstantText(
                                text: "Pay Now",
                                style: TextStyles.textStyle62,
                              ),
                              ConstantText(
                                text: "₹ 1,41,800",
                                style: TextStyles.textStyle66,
                              ),
                              //    ConstantText(
                              // text:"Asian Paints",style: TextStyles.textStyle34,),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          ConstantText(
                            text: "You Save",
                            style: TextStyles.textStyle60,
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          ConstantText(
                            text: "₹ 545",
                            style: TextStyles.textStyle68,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, savemoreDetails);
                            },
                            child: Container(
                              width: 300,
                              height: 40,
                              child: Center(
                                  child: ConstantText(
                                text: "View Details",
                                style: TextStyles.textStyle195,
                              )),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Colours.pumpkin,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
