import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/new%20modules/Credit_Details/model/Credit_Details.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/string_constants.dart';
import '../../../../new modules/image_assetpath_constants.dart';
import '../../../../util/common/text_constant_widget.dart';
import '../../../theme/constants.dart';

class AllSellers extends StatefulWidget {
  @override
  State<AllSellers> createState() => _AllSellersState();
}

Credit_Details_VM credit_details_vm = Get.put(Credit_Details_VM());

class _AllSellersState extends State<AllSellers> {
  Credit_Details_VM credit_details_vm = Get.put(Credit_Details_VM());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      credit_details_vm.getCreditDetails();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Material(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double maxHeight = constraints.maxHeight;
            double maxWidth = constraints.maxWidth;
            double w10p = maxWidth * 0.1;

            return Scaffold(
              backgroundColor: Colors.black,
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
                      child: Obx(
                        () {
                          return ListView.builder(
                            itemCount: (credit_details_vm
                                        .creditDetails
                                        ?.value
                                        ?.companyDetails
                                        ?.creditDetails
                                        ?.length ??
                                    0) +
                                1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 13),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: w10p * .3,
                                      ),
                                      const ConstantText(
                                          text: all_sellers,
                                          style: TextStyles.textStyle38),
                                    ],
                                  ),
                                );
                              } else {
                                return AllSellersWidget(
                                  maxHeight: maxHeight,
                                  maxWidth: maxWidth,
                                  image: ImageAssetpathConstant.companyVector,
                                  creditDetails: credit_details_vm
                                      .creditDetails
                                      ?.value
                                      ?.companyDetails
                                      ?.creditDetails?[index - 1],
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class AllSellersWidget extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;

  final String image;
  final CreditDetails? creditDetails;
  const AllSellersWidget({
    required this.maxWidth,
    required this.maxHeight,
    required this.image,
    required this.creditDetails,
  });

  @override
  State<AllSellersWidget> createState() => _AllSellersWidgetState();
}

class _AllSellersWidgetState extends State<AllSellersWidget> {
  List randomColors = [
    Color.fromARGB(255, 255, 191, 0),
    Color.fromARGB(255, 255, 28, 28),
    Color.fromARGB(255, 91, 202, 0),
    Color.fromARGB(255, 19, 220, 255),
    Color.fromARGB(255, 19, 94, 255),
    Color.fromARGB(255, 255, 19, 184),
    Color.fromARGB(255, 89, 156, 0),
    Color.fromARGB(255, 141, 19, 255),
    Color.fromARGB(255, 27, 92, 136),
    Color.fromARGB(255, 255, 141, 141)
  ];

  int getSingleDigitValueFrom({required String firstLetter}) {
    return getCalculatedValueInRange(AsciiEncoder().convert(firstLetter).first);
  }

  int getCalculatedValueInRange(int calculatedValue) {
    if (calculatedValue.toString().split("").length != 1) {
      return getCalculatedValueInRange(calculatedValue
          .toString()
          .split("")
          .map<int>((e) => int.parse(e))
          .toList()
          .fold<int>(0, (previousValue, element) => previousValue + element));
    } else {
      return calculatedValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    double h10p = widget.maxHeight * 0.1;
    double w10p = widget.maxWidth * 0.1;

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: widget.maxWidth - 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: Color.fromARGB(255, 196, 193, 193), width: 1),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: h10p * .1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: w10p * .18,
                  ),
                  CircleAvatar(
                    backgroundColor: randomColors[getSingleDigitValueFrom(
                        firstLetter: widget.creditDetails?.anchorName ==
                                context.tr(all_sellers)
                            ? "a"
                            : widget.creditDetails?.anchorName
                                    ?.substring(0, 1)
                                    .toUpperCase() ??
                                "")],
                    child: ConstantText(
                      text: widget.creditDetails?.anchorName
                          ?.substring(0, 1)
                          .toUpperCase(),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: w10p * .25,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(widget.creditDetails?.anchorName ?? "",
                            style: TextStyle(
                                color: Colours.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0)),
                        AutoSizeText(
                          widget.creditDetails?.address ?? "",
                          style: TextStyles.textStyle69,
                          maxLines: 2,
                        ),
                        AutoSizeText(
                          widget.creditDetails?.anchorGstin ?? "",
                          style: TextStyles.textStyle69,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ConstantText(
                          text: used_credit,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                        ),
                        ConstantText(
                          text:
                              "${(widget.creditDetails?.creditLimit ?? "0.0").toString().getDoubleValue() - (widget.creditDetails?.creditAvailable ?? "0.0").toString().getDoubleValue()}"
                                  .setCurrencyFormatter(),
                          style: TextStyles.textStyle69,
                          color: Colours.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        ConstantText(
                          text: available_credit_limit,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                        ),
                        ConstantText(
                          text: "${widget.creditDetails?.creditAvailable ?? ""}"
                              .setCurrencyFormatter(),
                          style: TextStyles.textStyle69,
                          color: Colours.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
