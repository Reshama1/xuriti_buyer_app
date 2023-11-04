import 'package:flutter/material.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/payment_history_widgets/bill_details.dart';

class PaynowScreen extends StatefulWidget {
  const PaynowScreen({Key? key}) : super(key: key);

  @override
  State<PaynowScreen> createState() => _PaynowScreenState();
}

class _PaynowScreenState extends State<PaynowScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return SafeArea(
          child: Scaffold(
        backgroundColor: Colours.black,
        appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            toolbarHeight: h10p * .8,
            flexibleSpace: AppbarWidget()),
        body: Column(
          children: [
            Expanded(
              child: Container(
                  width: maxWidth,
                  decoration: const BoxDecoration(
                      color: Colours.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      )),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              // ImageFromAssetPath<Widget>(assetPath: "assets/images/arrowLeft.svg"),
                              ImageFromAssetPath<Widget>(
                                      assetPath:
                                          ImageAssetpathConstant.arrowLeft)
                                  .imageWidget,
                              SizedBox(
                                width: w10p * .3,
                              ),
                              const ConstantText(
                                text: "Nippon Paint",
                                style: TextStyles.textStyle41,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Card(
                          elevation: 1,
                          child: Container(
                            height: h10p * 1,
                            width: w10p * 9.5,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: const [
                                          ConstantText(
                                            text: "₹ 545",
                                            style: TextStyles.textStyle35,
                                          ),
                                          ConstantText(
                                            text: " savings on this payment",
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
                            onTap: () {
                              Navigator.pushNamed(context, applyCoupon);
                            },
                            child: Container(
                              height: h10p * 1,
                              width: w10p * 9.5,
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
                                    const ConstantText(
                                      text: "Apply Coupon",
                                      style: TextStyles.textStyle78,
                                    ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const ConstantText(
                                            text: "#4321 ",
                                            style: TextStyles.textStyle6,
                                          ),
                                          Image.asset(
                                              ImageAssetpathConstant.arrowPng),
                                        ],
                                      ),
                                      const ConstantText(
                                          text: "Nippon Paint",
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
                                          text: "₹ 11,800",
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
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 5.0),
                        child: Card(
                          elevation: 2,
                          child: Container(
                            height: 72,
                            width: 350,
                            color: Colours.white,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4, top: 4),
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
                                        text: "Nippon Paint",
                                        style: TextStyles.textStyle64,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: w10p * 2.2,
                                  ),
                                  ImageFromAssetPath<Widget>(
                                          assetPath:
                                              ImageAssetpathConstant.arrowSvg)
                                      .imageWidget,
                                  SizedBox(
                                    width: w10p * 2,
                                  ),
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
                                        text: "Nippon Paint",
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
                        padding: const EdgeInsets.only(left: 20, top: 10),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
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
                                        //    ConstantText(
                                        // text:"Asian Paints",style: TextStyles.textStyle34,),
                                      ],
                                    ),
                                    SizedBox(
                                      width: w10p * 5.1,
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
                                          text: "₹ 11,800",
                                          style: TextStyles.textStyle66,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h1p * 1,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    ConstantText(
                                      text: "You Save",
                                      style: TextStyles.textStyle62,
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    ConstantText(
                                      text: "₹ 545",
                                      style: TextStyles.textStyle77,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      BillDetailsWidget(
                          maxWidth: maxWidth,
                          maxHeight: maxHeight,
                          heading: "Bill Details"),
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
                    ],
                  )),
            ),
          ],
        ),
      ));
    });
  }
}
