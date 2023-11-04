import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/new%20modules/Credit_Details/model/Credit_Details.dart';
import 'package:xuriti/ui/screens/starting_screens/company_list.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class HeaderWidgetForCreditLimitAndSellerSelection extends StatefulWidget {
  final Function(CreditDetails? sellerObj) selectedSeller;
  final bool? showSellerFilter;
  final bool? showCompanyFilter;

  const HeaderWidgetForCreditLimitAndSellerSelection(
      {Key? key,
      required this.selectedSeller,
      this.showSellerFilter,
      this.showCompanyFilter})
      : super(key: key);

  @override
  State<HeaderWidgetForCreditLimitAndSellerSelection> createState() =>
      _HeaderWidgetForCreditLimitAndSellerSelectionState();
}

class _HeaderWidgetForCreditLimitAndSellerSelectionState
    extends State<HeaderWidgetForCreditLimitAndSellerSelection> {
  final Credit_Details_VM credit_details_vm = Get.put(Credit_Details_VM());
  final TransactionManager transactionManager = Get.put(TransactionManager());

  @override
  Widget build(BuildContext context) {
    double h10 = context.height * 0.1;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() {
          return Container(
            padding: EdgeInsets.all(8.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: context.tr(total_credit_limit_credit_available),
                style: TextStyles.textStyle25(Colors.white),
                children: <TextSpan>[
                  TextSpan(
                      text: transactionManager.selectedSeller.value != null &&
                              transactionManager
                                      .selectedSeller.value?.anchorName
                                      ?.toLowerCase() !=
                                  "all sellers" &&
                              (credit_details_vm.creditDetails?.value
                                      ?.companyDetails?.creditDetails
                                      ?.where((element) =>
                                          element.anchor_pan ==
                                          transactionManager
                                              .selectedSeller.value?.anchor_pan)
                                      .length !=
                                  0)
                          ? ("₹ ${((double.tryParse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == transactionManager.selectedSeller.value?.anchor_pan).first.creditLimit ?? "0")) != null ? double.parse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == transactionManager.selectedSeller.value?.anchor_pan).first.creditLimit ?? "0")) : 0) / 100000.0).toStringAsFixed(2)} lacs/₹ ${((double.tryParse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == transactionManager.selectedSeller.value?.anchor_pan).first.creditAvailable ?? "0")) != null ? double.parse((credit_details_vm.creditDetails?.value?.companyDetails?.creditDetails?.where((element) => element.anchor_pan == transactionManager.selectedSeller.value?.anchor_pan).first.creditAvailable ?? "0")) : 0) / 100000).toStringAsFixed(2)} lacs")
                          : "₹ ${((credit_details_vm.creditDetails?.value?.companyDetails?.totalCreditLimit ?? 0) / 100000).toStringAsFixed(2)} lacs/₹ ${((credit_details_vm.creditDetails?.value?.companyDetails?.totalCreditAvailable ?? 0) / 100000).toStringAsFixed(2)} lacs",
                      style: TextStyles.textStyle32
                      //(
                      // color: Colors
                      //     .white), //(19899.00 / 100000).toString().substring (0, '19899.00'.indexOf ('.') - 1)
                      ),
                ],
              ),
            ),
          );
        }),
        SizedBox(
          height: 10.0,
        ),
        widget.showSellerFilter == true
            ? GestureDetector(
                onTapDown: (TapDownDetails? details) {
                  List<CreditDetails?>? sellerListData = (credit_details_vm
                      .creditDetails?.value?.companyDetails?.creditDetails);
                  if (sellerListData?.length == 0) {
                    Fluttertoast.showToast(msg: no_sellers_to_filter);
                    return;
                  }

                  if (sellerListData
                          ?.where((element) =>
                              element?.anchorName?.toLowerCase() ==
                              context.tr(all_sellers).toLowerCase())
                          .length ==
                      0) {
                    sellerListData?.insert(
                        0, CreditDetails(anchorName: context.tr(all_sellers)));
                  }

                  (sellerListData?.isNotEmpty ?? false)
                      ? showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(
                            (details?.globalPosition.dx ?? 0) + 15,
                            (details?.globalPosition.dy ?? 0) + 15,
                            MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height -
                                (details?.globalPosition.dy ?? 0),
                          ),
                          items: sellerListData
                                  ?.map((sellerObject) => PopupMenuItem(
                                        child: ConstantText(
                                            text: context.tr(
                                                sellerObject?.anchorName ??
                                                    "")),
                                        onTap: () {
                                          widget.selectedSeller(sellerObject);
                                        },
                                      ))
                                  .toList() ??
                              [],
                        )
                      : Center(
                          child: ConstantText(
                            text: there_is_no_seller,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        );
                },
                child: Container(
                  height: h10 * 0.5,
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                        child: ConstantText(
                          text: context.tr(transactionManager
                                  .selectedSeller.value?.anchorName ??
                              all_sellers),
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.switch_account_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              )
            : ((widget.showCompanyFilter == true)
                ? GestureDetector(
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
                : SizedBox()),
      ],
    );
  }
}
