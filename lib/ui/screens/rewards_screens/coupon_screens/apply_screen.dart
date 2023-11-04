import 'package:flutter/material.dart';
import '../../../../new modules/common_widget.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../theme/constants.dart';
import '../../../widgets/appbar/app_bar_widget.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({Key? key}) : super(key: key);

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  GlobalKey<ScaffoldState> ssk = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return SafeArea(
          key: ssk,
          child: Scaffold(
            backgroundColor: Colours.black,
            appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                toolbarHeight: h10p * .5,
                flexibleSpace: AppbarWidget(askey: ssk)),
            body: Column(
              children: [
                SizedBox(
                  height: h10p * 1,
                ),
                Expanded(
                  child: Container(
                      width: maxWidth,
                      decoration: const BoxDecoration(
                        color: Colours.white,
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(26),
                        //   topRight: Radius.circular(26),
                        // )
                      ),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 15),
                            child: Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: ImageFromAssetPath<Widget>(
                                            assetPath: ImageAssetpathConstant
                                                .arrowLeft)
                                        .imageWidget),
                                SizedBox(
                                  width: w10p * .3,
                                ),
                                const ConstantText(
                                  text: "Company Name",
                                  style: TextStyles.textStyle41,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                              elevation: 1,
                              child: Container(
                                height: h10p * 1,
                                width: w10p * 9.5,
                                // color: Colours.black,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colours.offWhite,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      ImageFromAssetPath<Widget>(
                                              assetPath:
                                                  ImageAssetpathConstant.logo1)
                                          .imageWidget,
                                      SizedBox(
                                        width: w10p * .3,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: const [
                                              ConstantText(
                                                text: "₹ 545",
                                                style: TextStyles.textStyle35,
                                              ),
                                              ConstantText(
                                                text:
                                                    " savings on this payment",
                                                style: TextStyles.textStyle34,
                                              ),
                                            ],
                                          ),
                                          const ConstantText(
                                            text: "with XURITI benefits",
                                            style: TextStyles.textStyle34,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: w10p * .3,
                              ),
                              const ConstantText(
                                text: "Additional Offers & Benefits",
                                style: TextStyles.textStyle78,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                              elevation: 1,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: h10p * 1,
                                  width: w10p * 9.5,
                                  // color: Colours.black,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colours.offWhite,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Row(
                                      children: [
                                        ImageFromAssetPath<Widget>(
                                                assetPath:
                                                    ImageAssetpathConstant
                                                        .logo1)
                                            .imageWidget,
                                        SizedBox(
                                          width: w10p * .1,
                                        ),
                                        const ConstantText(
                                          text: "XUR2OFF",
                                          style: TextStyles.textStyle82,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 23, left: 6),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              ConstantText(
                                                text: "Coupon",
                                                style: TextStyles.textStyle83,
                                              ),
                                              ConstantText(
                                                text: "Applied",
                                                style: TextStyles.textStyle83,
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: w10p * 2.5,
                                        ),
                                        ConstantText(
                                            text: "Remove",
                                            style: TextStyles.textStyle84)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: w10p * .3,
                              ),
                              const ConstantText(
                                text: "Invoice Details",
                                style: TextStyles.textStyle78,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                              elevation: 1,
                              child: Container(
                                height: h1p * 10.5,
                                width: w10p * 9.5,
                                decoration: BoxDecoration(
                                  color: Colours.offWhite,
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              const ConstantText(
                                                text: "#4321 ",
                                                style: TextStyles.textStyle6,
                                              ),
                                              Image.asset(ImageAssetpathConstant
                                                  .arrowPng),
                                            ],
                                          ),
                                          const ConstantText(
                                              text: "Company Name",
                                              style: TextStyles.textStyle59)
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: const [
                                              ConstantText(
                                                text: "10 days left",
                                                style: TextStyles.textStyle57,
                                              ),
                                              // Image.asset("assets/images/arrow.png"),
                                            ],
                                          ),
                                          const ConstantText(
                                              text: "₹ 11,300",
                                              style: TextStyles.textStyle58)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Card(
                              elevation: 2,
                              child: Container(
                                height: 72,
                                width: 350,
                                color: Colours.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, top: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: w10p * .2,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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

                                      SizedBox(
                                        width: w10p * 2.2,
                                      ),
                                      // Image.asset("assets/images/biarrow.png"),
                                      ImageFromAssetPath<Widget>(
                                              assetPath: ImageAssetpathConstant
                                                  .arrowSvg)
                                          .imageWidget,
                                      SizedBox(
                                        width: w10p * 2,
                                      ),

                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                          SizedBox(
                            height: h10p * .1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Container(
                              height: 130,
                              width: 360,
                              color: Colours.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 6,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: w10p * .3,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            SizedBox(
                                              height: 4,
                                            ),
                                            ConstantText(
                                              text: "Invoice Amount",
                                              style: TextStyles.textStyle62,
                                            ),
                                            ConstantText(
                                              text: "₹ 12,345",
                                              style: TextStyles.textStyle65,
                                            )
                                            //    Text("Asian Paints",style: TextStyles.textStyle34,),
                                          ],
                                        ),
                                        SizedBox(
                                          width: w10p * 5,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: const [
                                            SizedBox(
                                              height: 4,
                                            ),
                                            ConstantText(
                                              text: "Pay Now",
                                              style: TextStyles.textStyle62,
                                            ),
                                            ConstantText(
                                              text: "₹ 11,300",
                                              style: TextStyles.textStyle66,
                                            ),
                                            //    Text("Asian Paints",style: TextStyles.textStyle34,),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h1p * 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 13, right: 24),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: w10p * .1,
                                              ),
                                              const ConstantText(
                                                text: "You Save",
                                                style: TextStyles.textStyle62,
                                              ),
                                              const ConstantText(
                                                text: "₹ 1045",
                                                style: TextStyles.textStyle77,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: w10p * .1,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: const [
                                              ConstantText(
                                                text:
                                                    "Coupon Discount : XUR2OFF",
                                                style: TextStyles.textStyle62,
                                              ),
                                              ConstantText(
                                                text: "₹ 500",
                                                style: TextStyles.textStyle56,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Card(
                              elevation: 1,
                              child: Container(
                                  height: h10p * 4.9,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colours.white),
                                  child: Column(
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            ConstantText(
                                              text: "Bill Details",
                                              style: TextStyles.textStyle43,
                                            )
                                          ]),
                                      SizedBox(
                                        height: h1p * 1,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            const ConstantText(
                                              text: "No",
                                              style: TextStyles.textStyle38,
                                            ),
                                            SizedBox(
                                              width: w10p * .5,
                                            ),
                                            const ConstantText(
                                                text: "Items",
                                                style: TextStyles.textStyle38),
                                            SizedBox(
                                              width: w10p * 3.1,
                                            ),
                                            const ConstantText(
                                                text: "Oty",
                                                style: TextStyles.textStyle38),
                                            SizedBox(
                                              width: w10p * .3,
                                            ),
                                            const ConstantText(
                                                text: "Price",
                                                style: TextStyles.textStyle38),
                                            SizedBox(
                                              width: w10p * .6,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                ConstantText(
                                                    text: "Sub",
                                                    style:
                                                        TextStyles.textStyle38),
                                                ConstantText(
                                                    text: "Total",
                                                    style:
                                                        TextStyles.textStyle38),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        color: Colours.lightGrey,
                                        thickness: 3,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Row(
                                          children: [
                                            const ConstantText(
                                              text: "01",
                                              style: TextStyles.textStyle55,
                                            ),
                                            SizedBox(
                                              width: w10p * .7,
                                            ),
                                            const ConstantText(
                                              text: "Name of item 1",
                                              style: TextStyles.textStyle55,
                                            ),
                                            SizedBox(
                                              width: w10p * 2,
                                            ),
                                            const ConstantText(
                                              text: "20",
                                              style: TextStyles.textStyle55,
                                            ),
                                            SizedBox(
                                              width: w10p * .5,
                                            ),
                                            const ConstantText(
                                              text: "₹ 2,300",
                                              style: TextStyles.textStyle55,
                                            ),
                                            SizedBox(
                                              width: w10p * .5,
                                            ),
                                            const ConstantText(
                                              text: "₹ 4,600",
                                              style: TextStyles.textStyle55,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: h10p * .2,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Row(
                                          children: [
                                            const ConstantText(
                                              text: "02",
                                              style: TextStyles.textStyle55,
                                            ),
                                            SizedBox(
                                              width: w10p * .7,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                ConstantText(
                                                  text: "Name of item that is",
                                                  style: TextStyles.textStyle55,
                                                ),
                                                ConstantText(
                                                  text: "quite long",
                                                  style: TextStyles.textStyle55,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: w10p * 1.1,
                                            ),
                                            const ConstantText(
                                              text: "12",
                                              style: TextStyles.textStyle55,
                                            ),
                                            SizedBox(
                                              width: w10p * .6,
                                            ),
                                            const ConstantText(
                                              text: "₹ 300",
                                              style: TextStyles.textStyle55,
                                            ),
                                            SizedBox(
                                              width: w10p * .7,
                                            ),
                                            const ConstantText(
                                              text: "₹ 3,600",
                                              style: TextStyles.textStyle55,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: h10p * .2,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Row(
                                          children: [
                                            const ConstantText(
                                              text: "03",
                                              style: TextStyles.textStyle55,
                                            ),
                                            SizedBox(
                                              width: w10p * .7,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                ConstantText(
                                                  text: "Another Name of item",
                                                  style: TextStyles.textStyle55,
                                                ),
                                                ConstantText(
                                                  text: "that is quite long ",
                                                  style: TextStyles.textStyle55,
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: w10p * .9),
                                            const ConstantText(
                                              text: "12",
                                              style: TextStyles.textStyle55,
                                            ),
                                            SizedBox(
                                              width: w10p * .6,
                                            ),
                                            const ConstantText(
                                              text: "₹ 300",
                                              style: TextStyles.textStyle55,
                                            ),
                                            SizedBox(
                                              width: w10p * .7,
                                            ),
                                            const ConstantText(
                                              text: "₹ 3,600",
                                              style: TextStyles.textStyle55,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: h10p * .2,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: Row(
                                          children: [
                                            const ConstantText(
                                              text: "02",
                                              style: TextStyles.textStyle55,
                                            ),
                                            SizedBox(
                                              width: w10p * .7,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                ConstantText(
                                                  text: "Name of item that is",
                                                  style: TextStyles.textStyle55,
                                                ),
                                                ConstantText(
                                                  text: "quite long",
                                                  style: TextStyles.textStyle55,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: w10p * 1.1,
                                            ),
                                            const ConstantText(
                                              text: "12",
                                              style: TextStyles.textStyle55,
                                            ),
                                            SizedBox(
                                              width: w10p * .6,
                                            ),
                                            const ConstantText(
                                              text: "₹ 300",
                                              style: TextStyles.textStyle55,
                                            ),
                                            SizedBox(
                                              width: w10p * .7,
                                            ),
                                            const ConstantText(
                                              text: "₹ 3,600",
                                              style: TextStyles.textStyle55,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: h10p * .2,
                                      ),
                                      const Divider(
                                        color: Colours.lightGrey,
                                        thickness: 3,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            ConstantText(
                                              text: "Total",
                                              style: TextStyles.textStyle75,
                                            ),
                                            ConstantText(
                                              text: "₹ 12,345",
                                              style: TextStyles.textStyle76,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 140),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  const ConstantText(
                                    text: "₹ 11,800",
                                    style: TextStyles.textStyle77,
                                  ),
                                  SizedBox(
                                    width: w10p * 3.3,
                                  ),
                                  Container(
                                    height: h10p * .5,
                                    width: w10p * 4.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colours.successPrimary,
                                    ),
                                    child: const Center(
                                      child: ConstantText(
                                        text: "Proceed to payment",
                                        style: TextStyles.textStyle42,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(height: h1p*2,)
                        ],
                      )),
                ),
              ],
            ),
          ));
    });
  }
}
