// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// import 'package:flutter_progress_hud/flutter_progress_hud.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
// import 'package:xuriti/logic/view_models/transaction_manager.dart';
// import 'package:xuriti/models/core/seller_list_model.dart' as Sel;
// import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
// import 'package:xuriti/ui/screens/paynow_screens/PaymentSummaryScreen.dart';
// import 'package:xuriti/ui/screens/paynow_screens/payment_url.dart';
// import 'package:xuriti/util/Extensions.dart';
// import 'package:xuriti/util/loaderWidget.dart';
// import '../../../logic/view_models/company_details_manager.dart';
// import '../../../models/helper/service_locator.dart';
// import '../../../new modules/common_widget.dart';
// import '../../../new modules/image_assetpath_constants.dart';
// import '../../../util/common/text_constant_widget.dart';
// import '../../routes/router.dart';
// import '../../theme/constants.dart';
// import '../../widgets/appbar/app_bar_widget.dart';
//
// class TotalPayment extends StatefulWidget {
//   // const TotalPayment({Key? key}) : super(key: key);
//
//   const TotalPayment();
//   @override
//   State<TotalPayment> createState() => _TotalPaymentState();
// }
//
// class _TotalPaymentState extends State<TotalPayment> {
//   TextEditingController paidAmountController = TextEditingController();
//   CompanyDetailsManager companyManagerVM = Get.put(CompanyDetailsManager());
// CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
//
//
//   bool? checkID;
//   String? companyId;
//   late StreamSubscription<bool> keyboardSubscription;
//
//   Future<List<Sel.Seller?>?>? sellerListFuture;
//
//   @override
//   void dispose() {
//
//
//     super.dispose();
//   }
//
//
//   // void didChangeDependencies() {
//   //
//   //   super.didChangeDependencies();
//   // }
//
//   void initState() {
//     checkID = getIt<SharedPreferences>().getBool('checkId');
//     if (checkID == true) {
//       companyId = getIt<SharedPreferences>().getString('entityid');
//     } else {
//       companyId = companyListViewModel.selectedCompany.value?.companyId ?? "";
//     }
//
//     var keyboardVisibilityController = KeyboardVisibilityController();
//     // Query
//     print(
//         'Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');
//
//     // Subscribe
//     keyboardSubscription =
//         keyboardVisibilityController.onChange.listen((bool visible) {
//       print('Keyboard visibility update. Is visible: $visible');
//       if (visible == false) {
//         if (getIt<TransactionManager>().selectedSeller.value != null &&
//             getIt<TransactionManager>().selectedSeller.value?.anchorName !=
//                 "All Sellers") {
//           if (paidAmountController.text.isEmpty) {
//             companyManagerVM.sellerInfoForPartPay?.value = null;
//             return;
//           }
//           companyManagerVM.getPaymentSummaryDataForPayNowAndPartPay(
//               companyId,
//               getIt<TransactionManager>().selectedSeller.value?.anchor_pan ??
//                   "",
//               paidAmountController.text);
//         }
//       }
//     });
//
//     sellerListFuture = getIt<TransactionManager>().getSellerData(companyId);
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//
//       companyManagerVM.sellerInfoForPartPay?.value = null;
//       paidAmountController.text = "";
//       if (getIt<TransactionManager>().selectedSeller.value != null &&
//           getIt<TransactionManager>().selectedSeller.value?.anchorName !=
//               "All Sellers") {
//         companyManagerVM.getPaymentSummaryDataForPayNowAndPartPay(companyId,
//             getIt<TransactionManager>().selectedSeller.value?.anchor_pan ?? "");
//       } else {
//         companyManagerVM.sellerInfo?.value = null;
//       }
//     });
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       double maxHeight = constraints.maxHeight;
//       double maxWidth = constraints.maxWidth;
//       double h1p = maxHeight * 0.01;
//       double h10p = maxHeight * 0.1;
//       double h30p = maxHeight * 0.5;
//       double w10p = maxWidth * 0.1;
//       double w1p = maxWidth * 0.01;
//       return SafeArea(
//           child: FutureBuilder(
//               future:
//                   // getIt<CompanyDetailsManager>().getSellerList(companyId),
//                   sellerListFuture,
//               builder: (context, AsyncSnapshot<List<Sel.Seller?>?> snapshot) {
//                 // if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.hasError) {
//                   return Center(
//                     child: ConstantText(
//                       text: '${snapshot.error} occurred',
//                       style: TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                   );
//                 } else if (snapshot.hasData) {
//                   // List<MSeller> sellers = snapshot.data as List<MSeller>;
//                   return Obx(() {
//                     print(companyManagerVM.sellerInfo?.value);
//                     return Scaffold(
//                         backgroundColor: Colours.black,
//                         appBar: AppBar(
//                             elevation: 0,
//                             automaticallyImplyLeading: false,
//                             toolbarHeight: h10p * .9,
//                             flexibleSpace: AppbarWidget()),
//                         body: ProgressHUD(child: Builder(builder: (context) {
//                           return Container(
//                             width: maxWidth,
//                             decoration: const BoxDecoration(
//                                 color: Colours.white,
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(10),
//                                   topRight: Radius.circular(10),
//                                 )),
//                             child: ListView(
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     checkID!
//                                         ? Navigator.pushNamed(
//                                             context, oktWrapper)
//                                         : Navigator.pop(context);
//                                   },
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: w1p * 3, vertical: h1p * 3),
//                                     child: Row(
//                                       children: [
//                                         ImageFromAssetPath<Widget>(
//                                                 assetPath:
//                                                     ImageAssetpathConstant
//                                                         .arrowLeft)
//                                             .imageWidget,
//                                         SizedBox(
//                                           width: w10p * .3,
//                                         ),
//                                         const ConstantText(
//                                           text: "Pay Now",
//                                           style: TextStyles.textStyle127,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: w1p * 5, vertical: h1p * 1),
//                                   child: ConstantText(
//                                       text: "Seller",
//                                       style: TextStyles.textStyle122),
//                                 ),
//                                 Obx(
//                                   () {
//                                     print(companyManagerVM.sellerInfo?.value);
//
//                                     return Column(
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: w1p * 1,
//                                               vertical: h1p * 2),
//                                           child: GestureDetector(
//                                             onTapDown: (details) {
//                                               showMenu(
//                                                 context: context,
//                                                 position: RelativeRect.fromLTRB(
//                                                   details.globalPosition.dx,
//                                                   details.globalPosition.dy +
//                                                       20,
//                                                   MediaQuery.of(context)
//                                                           .size
//                                                           .width -
//                                                       details.globalPosition.dx,
//                                                   MediaQuery.of(context)
//                                                           .size
//                                                           .width -
//                                                       details.globalPosition.dy,
//                                                 ),
//                                                 items: snapshot.data
//                                                         ?.map(
//                                                             (e) =>
//                                                                 PopupMenuItem(
//                                                                   child: ConstantText(
//                                                                       text: e?.companyName ??
//                                                                           ""),
//                                                                   onTap:
//                                                                       () async {
//                                                                     context
//                                                                         .showLoader();
//                                                                     Fluttertoast
//                                                                         .showToast(
//                                                                             msg:
//                                                                                 "Fetching data please wait");
//
//                                                                     Map<String,
//                                                                             dynamic>?
//                                                                         data =
//                                                                         await companyManagerVM.getPaymentSummaryDataForPayNowAndPartPay(
//                                                                             companyId,
//                                                                             e?.pan ??
//                                                                                 "");
//
//                                                                     getIt<TransactionManager>()
//                                                                         .selectedSeller
//                                                                         .value = Get.put(Credit_Details_VM())
//                                                                             .creditDetails
//                                                                             ?.value
//                                                                             ?.companyDetails
//                                                                             ?.creditDetails
//                                                                             ?.where((element) =>
//                                                                                 element.Anchor_id ==
//                                                                                 e?.sId)
//                                                                             .first ??
//                                                                         null;
//                                                                     companyManagerVM
//                                                                         .isSwitched
//                                                                         .value = false;
//                                                                     companyManagerVM
//                                                                         .sellerInfoForPartPay
//                                                                         ?.value = null;
//                                                                     paidAmountController
//                                                                         .text = "";
//
//                                                                     // progress.dismiss();
//                                                                     context
//                                                                         .hideLoader();
//                                                                     // print(
//                                                                     //     "inv list ,,,,,,,,,,,,,,,,,${data!["invoiceDetails"][0]['invoice_number']}");
//                                                                     if (data !=
//                                                                             null &&
//                                                                         data['msg'] !=
//                                                                             null) {
//                                                                       Fluttertoast
//                                                                           .showToast(
//                                                                               msg: data['msg']);
//                                                                     }
//                                                                   },
//                                                                 ))
//                                                         .toList() ??
//                                                     [],
//                                               );
//                                             },
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Colours.black015,
//                                                       width: .5),
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                       color: const Color(
//                                                           0x66000000),
//                                                       offset: Offset(0, 1),
//                                                       blurRadius: 1,
//                                                       spreadRadius: 0,
//                                                     )
//                                                   ],
//                                                   color: Colours.paleGrey,
//                                                   borderRadius:
//                                                       BorderRadius.circular(6)),
//                                               child: Container(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width /
//                                                     2,
//                                                 height: 40.0,
//                                                 child: Obx(() {
//                                                   return Row(
//                                                     mainAxisAlignment:
//                                                         (getIt<TransactionManager>()
//                                                                     .selectedSeller
//                                                                     .value ==
//                                                                 null)
//                                                             ? MainAxisAlignment
//                                                                 .end
//                                                             : MainAxisAlignment
//                                                                 .spaceAround,
//                                                     children: [
//                                                       ConstantText(
//                                                         text: (getIt<TransactionManager>()
//                                                                             .selectedSeller
//                                                                             .value
//                                                                             ?.anchorName ??
//                                                                         "")
//                                                                     .toLowerCase() ==
//                                                                 "all sellers"
//                                                             ? "No Seller Selected"
//                                                             : (getIt<TransactionManager>()
//                                                                     .selectedSeller
//                                                                     .value
//                                                                     ?.anchorName ??
//                                                                 ""),
//                                                       ),
//                                                       Icon(Icons
//                                                           .arrow_drop_down_circle)
//                                                     ],
//                                                   );
//                                                 }),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: w1p * 5,
//                                                 vertical: h1p * 1),
//                                             child: Container(
//                                                 height: h10p * 1,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                     color: Colours.offWhite),
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     ConstantText(
//                                                       text:
//                                                           "Outstanding Amount",
//                                                       style: TextStyles
//                                                           .textStyle129,
//                                                     ),
//                                                     ConstantText(
//                                                       text: "${companyManagerVM.sellerInfo?.value?.totalPayable ?? 0.0}"
//                                                           .setCurrencyFormatter(), // "₹${outstandingAmount.toString()}",
//                                                       style: TextStyles
//                                                           .textStyleUp,
//                                                     )
//                                                   ],
//                                                 ))),
//                                         Padding(
//                                             padding: EdgeInsets.symmetric(
//                                               horizontal: w1p * 5,
//                                             ),
//                                             child: Container(
//                                                 height: h10p * 4.5,
//                                                 decoration: BoxDecoration(
//                                                     boxShadow: [
//                                                       BoxShadow(
//                                                           color: const Color(
//                                                               0x66000000),
//                                                           offset: Offset(0, 1),
//                                                           blurRadius: 1,
//                                                           spreadRadius: 0)
//                                                     ],
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                     color: Colours.white),
//                                                 child: Padding(
//                                                     padding:
//                                                         EdgeInsets.symmetric(
//                                                             horizontal:
//                                                                 w1p * 7.5,
//                                                             vertical:
//                                                                 h1p * 0.5),
//                                                     child: Column(children: [
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           ConstantText(
//                                                             text: "Discount",
//                                                             style: TextStyles
//                                                                 .textStyle129,
//                                                           ),
//                                                           ConstantText(
//                                                             text: "Interest",
//                                                             style: TextStyles
//                                                                 .textStyle129,
//                                                           ),
//                                                           // Text(
//                                                           //   "Payable Amount",
//                                                           //   style: TextStyles
//                                                           //       .textStyle129,
//                                                           // )
//                                                         ],
//                                                       ),
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           ConstantText(
//                                                             text: "${companyManagerVM.sellerInfo?.value?.totalDiscount ?? 0}"
//                                                                 .setCurrencyFormatter(),
//                                                             style: TextStyles
//                                                                 .textStyle130,
//                                                           ),
//                                                           ConstantText(
//                                                             text: "${companyManagerVM.sellerInfo?.value?.totalInterest ?? 0}"
//                                                                 .setCurrencyFormatter(), // "₹${interest.toString()}",
//                                                             style: TextStyles
//                                                                 .textStyle131,
//                                                           ),
//                                                           // Text(
//                                                           //   "₹$payable",
//                                                           //   style: TextStyles
//                                                           //       .textStyle132,
//                                                           // ),
//                                                         ],
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           Obx(() {
//                                                             return AbsorbPointer(
//                                                               absorbing: false,
//                                                               child: Switch(
//                                                                 value: companyManagerVM
//                                                                     .isSwitched
//                                                                     .value,
//                                                                 activeColor:
//                                                                     Colours
//                                                                         .pumpkin,
//                                                                 inactiveTrackColor:
//                                                                     Colours
//                                                                         .warmGrey,
//                                                                 onChanged: (_) {
//                                                                   if (companyManagerVM
//                                                                           .isSwitched
//                                                                           .value ==
//                                                                       false) {
//                                                                     companyManagerVM
//                                                                         .isSwitched
//                                                                         .value = true;
//                                                                     paidAmountController
//                                                                         .text = "";
//                                                                   } else {
//                                                                     companyManagerVM
//                                                                         .isSwitched
//                                                                         .value = false;
//                                                                     paidAmountController
//                                                                         .text = "";
//                                                                     companyManagerVM
//                                                                         .sellerInfoForPartPay
//                                                                         ?.value = null;
//                                                                   }
//                                                                   // getIt<CompanyDetailsManager>()
//                                                                   //     .toggleSwitch();
//                                                                 },
//                                                               ),
//                                                             );
//                                                           }),
//                                                           ConstantText(
//                                                             text:
//                                                                 "Settle Your Amount",
//                                                             style: TextStyles
//                                                                 .companyName,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       companyManagerVM
//                                                                   .isSwitched
//                                                                   .value ==
//                                                               true
//                                                           ? Column(children: [
//                                                               Container(
//                                                                 height: h1p * 5,
//                                                                 decoration:
//                                                                     BoxDecoration(
//                                                                   boxShadow: [
//                                                                     BoxShadow(
//                                                                         color: Colours
//                                                                             .white,
//                                                                         offset: Offset(
//                                                                             0,
//                                                                             1),
//                                                                         blurRadius:
//                                                                             1,
//                                                                         spreadRadius:
//                                                                             0)
//                                                                   ],
//                                                                   color: Colours
//                                                                       .white,
//                                                                 ),
//                                                                 child: Focus(
//                                                                   onFocusChange:
//                                                                       (_) async {
//                                                                     String
//                                                                         settleAmt =
//                                                                         paidAmountController
//                                                                             .text;
//                                                                     if (settleAmt
//                                                                             .isNotEmpty &&
//                                                                         companyManagerVM.isValidateSettleAmount(settleAmt) ==
//                                                                             true) {
//                                                                       // context
//                                                                       //     .showLoader();
//                                                                       await getIt<CompanyDetailsManager>().outstandingPayNow(
//                                                                           companyId,
//                                                                           getIt<TransactionManager>()
//                                                                               .selectedSeller
//                                                                               .value
//                                                                               ?.Anchor_id,
//                                                                           paidAmountController
//                                                                               .text,
//                                                                           isToggled:
//                                                                               true);
//                                                                       // context
//                                                                       //     .hideLoader();
//                                                                     } else {
//                                                                       companyManagerVM
//                                                                           .resetRevisedValues();
//                                                                       // Fluttertoast
//                                                                       //     .showToast(
//                                                                       //         msg:
//                                                                       //             "Please enter a valid");
//                                                                     }
//                                                                   },
//                                                                   child:
//                                                                       TextFormField(
//                                                                           keyboardType: TextInputType.numberWithOptions(
//                                                                               decimal:
//                                                                                   true),
//                                                                           inputFormatters: [
//                                                                             DecimalTextInputFormatter()
//                                                                           ],
//                                                                           onTap:
//                                                                               () {
//                                                                             companyManagerVM.validateSettleAmount(paidAmountController.text);
//                                                                             //  getIt<PasswordManager>().validateSettleAmount(paidAmountController.text);
//                                                                           },
//                                                                           controller:
//                                                                               paidAmountController,
//                                                                           decoration:
//                                                                               InputDecoration(
//                                                                             contentPadding:
//                                                                                 EdgeInsets.symmetric(horizontal: w1p * 6, vertical: h1p * .5),
//                                                                             border:
//                                                                                 OutlineInputBorder(
//                                                                               borderRadius: BorderRadius.circular(6),
//                                                                             ),
//                                                                             fillColor:
//                                                                                 Colours.white,
//                                                                             hintText:
//                                                                                 "Enter Amount",
//                                                                             hintStyle:
//                                                                                 TextStyles.textStyle128,
//                                                                           )),
//                                                                 ),
//                                                               ),
//                                                               // payingAmount.value ==
//                                                               //         ""
//                                                               //     ? Container()
//                                                               //     : Row(
//                                                               //         children: [
//                                                               //           Text(
//                                                               //               "Please provide a valid amount",
//                                                               //               style:
//                                                               //                   const TextStyle(color: Colors.red)),
//                                                               //         ],
//                                                               //       ),
//                                                               Padding(
//                                                                 padding: EdgeInsets.symmetric(
//                                                                     horizontal:
//                                                                         w1p * 2,
//                                                                     vertical:
//                                                                         h1p *
//                                                                             2),
//                                                                 child: Column(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     crossAxisAlignment:
//                                                                         CrossAxisAlignment
//                                                                             .start,
//                                                                     children: [
//                                                                       Row(
//                                                                         mainAxisAlignment:
//                                                                             MainAxisAlignment.spaceBetween,
//                                                                         children: [
//                                                                           ConstantText(
//                                                                             text:
//                                                                                 "Discount",
//                                                                             style:
//                                                                                 TextStyles.textStyle129,
//                                                                           ),
//                                                                           ConstantText(
//                                                                             text:
//                                                                                 "Interest",
//                                                                             style:
//                                                                                 TextStyles.textStyle129,
//                                                                           ),
//                                                                           ConstantText(
//                                                                             text:
//                                                                                 "Settled Amount",
//                                                                             style:
//                                                                                 TextStyles.textStyle129,
//                                                                           )
//                                                                         ],
//                                                                       ),
//                                                                       Row(
//                                                                         mainAxisAlignment:
//                                                                             MainAxisAlignment.spaceBetween,
//                                                                         crossAxisAlignment:
//                                                                             CrossAxisAlignment.start,
//                                                                         children: [
//                                                                           ConstantText(
//                                                                             text:
//                                                                                 "${companyManagerVM.sellerInfoForPartPay?.value?.totalDiscount ?? 0.0}".setCurrencyFormatter(), //${params.revisedDiscount.toString()}",
//                                                                             style:
//                                                                                 TextStyles.textStyle130,
//                                                                           ),
//                                                                           ConstantText(
//                                                                             text:
//                                                                                 "${companyManagerVM.sellerInfoForPartPay?.value?.totalInterest ?? 0.0}".setCurrencyFormatter(), //{params.revisedInterest.toString()}",
//                                                                             style:
//                                                                                 TextStyles.textStyle131,
//                                                                           ),
//                                                                           ConstantText(
//                                                                             text:
//                                                                                 "${companyManagerVM.sellerInfoForPartPay?.value?.totalPayable ?? 0.0}".setCurrencyFormatter(),
//                                                                             //"₹$amountpartpay",
//                                                                             //"₹$orderamount",
//                                                                             // "₹${(double.parse(params.payableAmount ?? '0') - double.parse(params.revisedDiscount ?? '0')).toStringAsFixed(2)}",
//                                                                             style:
//                                                                                 TextStyles.textStyle132,
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ]),
//                                                               )
//                                                             ])
//                                                           : Container(),
//                                                       Padding(
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 vertical:
//                                                                     h1p * 2.5),
//                                                         child: InkWell(
//                                                           onTap: () async {
//                                                             if (paidAmountController
//                                                                     .text
//                                                                     .isNotEmpty &&
//                                                                 companyManagerVM
//                                                                         .isSwitched
//                                                                         .value ==
//                                                                     true) {
//                                                               // progress!.show();
//                                                               //
//                                                               // await getIt<CompanyDetailsManager>().outstandingPayNow(
//                                                               //     companyId,
//                                                               //     getIt<TransactionManager>()
//                                                               //         .selectedSeller
//                                                               //         .value
//                                                               //         ?.sId,
//                                                               //     paidAmountController
//                                                               //             .text
//                                                               //             .isEmpty
//                                                               //         ? "outstandingAmount"
//                                                               //             .toString()
//                                                               //         : paidAmountController
//                                                               //             .text);
//                                                               // progress
//                                                               //     .dismiss();
//
//                                                               showDialog(
//                                                                   barrierDismissible:
//                                                                       false,
//                                                                   context:
//                                                                       context,
//                                                                   builder: (
//                                                                     context,
//                                                                   ) {
//                                                                     return Consumer<
//                                                                         CompanyDetailsManager>(
//                                                                       builder: ((context,
//                                                                           value,
//                                                                           child) {
//                                                                         return AlertDialog(
//                                                                           actions: [
//                                                                             Center(
//                                                                               child: Container(
//                                                                                 height: h1p * 5.5,
//                                                                                 width: w10p * 2,
//                                                                                 decoration: BoxDecoration(
//                                                                                   borderRadius: BorderRadius.circular(5),
//                                                                                   color: Colours.successPrimary,
//                                                                                 ),
//                                                                                 child: Center(
//                                                                                   child: InkWell(
//                                                                                     onTap: (() async {
//                                                                                       Map<String, dynamic> temResponse = await companyManagerVM.outstandingPayNow(companyId, getIt<TransactionManager>().selectedSeller.value?.anchor_pan, paidAmountController.text.isEmpty ? (companyManagerVM.sellerInfo?.value?.totalPayable ?? 0.0) : paidAmountController.text);
//
//                                                                                       if (temResponse.isNotEmpty) {
//                                                                                         //show message while redirect payment page
//                                                                                         Fluttertoast.showToast(msg: "please wait while you are redirected to make payment");
//                                                                                         //progress.show();
//                                                                                         context.showLoader();
//                                                                                         Map<String, dynamic>? sendPayment = await getIt<CompanyDetailsManager>().sendPayment(sellerPan: getIt<TransactionManager>().selectedSeller.value?.anchor_pan, buyerId: companyId, sellerId: getIt<TransactionManager>().selectedSeller.value?.Anchor_id, orderAmount: ((companyManagerVM.payableAmount.toString() != '0') || paidAmountController.text.toString().isNotEmpty) ? paidAmountController.text.toString() : (companyManagerVM.sellerInfo?.value?.totalPayable ?? 0.0).toString(), discount: paidAmountController.text.isEmpty ? (companyManagerVM.sellerInfo?.value?.totalDiscount ?? 0.0).toString() : (companyManagerVM.sellerInfoForPartPay?.value?.totalDiscount ?? 0.0).toString(), settle_amount: paidAmountController.text.isEmpty ? (companyManagerVM.sellerInfo?.value?.totalPayable ?? 0.0).toString() : paidAmountController.text, outStandingAmount: paidAmountController.text.isEmpty ? (companyManagerVM.sellerInfo?.value?.totalOutstanding ?? 0.0).toString() : (companyManagerVM.sellerInfoForPartPay?.value?.totalOutstanding ?? 0.0).toString());
//                                                                                         context.hideLoader();
//                                                                                         //  progress.dismiss();
//                                                                                         if (sendPayment != null) {
//                                                                                           if (sendPayment['status'] == true) {
//                                                                                             // ScaffoldMessenger.of(
//                                                                                             //         context)
//                                                                                             //     .showSnackBar(
//                                                                                             //         SnackBar(
//                                                                                             //             behavior:
//                                                                                             //                 SnackBarBehavior.floating,
//                                                                                             //             content:ConstantText(
//                                                                                             // text:
//                                                                                             //               sendPayment['message'],
//                                                                                             //               style: TextStyle(color: Colors.green),
//                                                                                             //             )));
//
//                                                                                             // if (sendPayment['payment_link'] != null) {
//                                                                                             String url = sendPayment['payment_link'];
//                                                                                             Navigator.push(
//                                                                                                 context,
//                                                                                                 MaterialPageRoute(
//                                                                                                     builder: (context) => PaymentUrl(
//                                                                                                           paymentUrl: url,
//                                                                                                         )));
//                                                                                           } else {
//                                                                                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                                                                                 behavior: SnackBarBehavior.floating,
//                                                                                                 content: ConstantText(
//                                                                                                   text: "could not launch the url",
//                                                                                                   style: TextStyle(color: Colors.red),
//                                                                                                 )));
//                                                                                           }
//                                                                                         }
//                                                                                         // } else {
//                                                                                         //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                                                                         //       behavior: SnackBarBehavior.floating,
//                                                                                         //       content: Text(
//                                                                                         //         sendPayment!['message'],
//                                                                                         //         style: TextStyle(color: Colors.green),
//                                                                                         //       )));
//                                                                                         // }
//                                                                                       } else {
//                                                                                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(behavior: SnackBarBehavior.floating, content: ConstantText(text: "Please select the seller", style: TextStyle(color: Colors.red))));
//                                                                                       }
//                                                                                     }),
//                                                                                     child: ConstantText(
//                                                                                       text: "Proceed",
//                                                                                       style: TextStyles.textStyle46,
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             )
//                                                                           ],
//                                                                           content:
//                                                                               Container(
//                                                                             width:
//                                                                                 double.maxFinite,
//                                                                             child:
//                                                                                 ListView(
//                                                                               physics: NeverScrollableScrollPhysics(),
//                                                                               shrinkWrap: true,
//                                                                               children: [
//                                                                                 Row(
//                                                                                   mainAxisAlignment: MainAxisAlignment.end,
//                                                                                   children: [
//                                                                                     IconButton(
//                                                                                       icon: Icon(
//                                                                                         Icons.close,
//                                                                                         color: Colors.grey,
//                                                                                       ),
//                                                                                       onPressed: () {
//                                                                                         Navigator.of(context).pop();
//                                                                                       },
//                                                                                     ),
//                                                                                   ],
//                                                                                 ),
//                                                                                 Padding(
//                                                                                   padding: const EdgeInsets.only(top: 8.0),
//                                                                                   child: ListTile(
//                                                                                     title: Center(child: ConstantText(text: "Payable Amount")),
//                                                                                     subtitle: Center(
//                                                                                       child: ConstantText(
//                                                                                         text: "₹${paidAmountController.text}",
//                                                                                         style: TextStyles.textStyle139,
//                                                                                       ),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                                 // ListTile(
//                                                                                 //     title: Text("Settled Amount"),
//                                                                                 //     subtitle: value.revisedInterest != 0
//                                                                                 //         ? Text(
//                                                                                 //             "₹${(double.parse(value.payableAmount ?? '0') - double.parse(params.revisedInterest ?? '0')).toStringAsFixed(2)}",
//                                                                                 //             style: TextStyles.textStyle132,
//                                                                                 //           )
//                                                                                 //         : Text(
//                                                                                 //             "₹${(double.parse(value.payableAmount ?? '0') + double.parse(params.revisedDiscount ?? '0')).toStringAsFixed(2)}",
//                                                                                 //             style: TextStyles.textStyle132,
//                                                                                 //           )),
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                         );
//                                                                       }),
//                                                                     );
//                                                                   });
//                                                             } else {
//                                                               // context
//                                                               //     .showLoader();
//                                                               // //progress!.show();
//                                                               // Map<String, dynamic> temResponse = await getIt<CompanyDetailsManager>().outstandingPayNow(
//                                                               //     companyId,
//                                                               //     companyManagerVM
//                                                               //         .sellerInfo
//                                                               //         ?.value
//                                                               //         ?.panNo,
//                                                               //     paidAmountController
//                                                               //             .text
//                                                               //             .isEmpty
//                                                               //         ? (companyManagerVM.sellerInfo?.value?.totalPayable ??
//                                                               //                 0.0)
//                                                               //             .toString()
//                                                               //         : paidAmountController
//                                                               //             .text
//                                                               //             .toString());
//                                                               //
//                                                               // context
//                                                               //     .hideLoader();
//                                                               // progress.dismiss();
//                                                               // if (temResponse
//                                                               //     .isNotEmpty) {
//                                                               Fluttertoast
//                                                                   .showToast(
//                                                                       msg:
//                                                                           "please wait while you are redirected to make payment");
//
//                                                               context
//                                                                   .showLoader();
//                                                               // progress.show();
//                                                               Map<String,
//                                                                       dynamic>?
//                                                                   sendPayment =
//                                                                   await getIt<
//                                                                           CompanyDetailsManager>()
//                                                                       .sendPayment(
//                                                                 sellerPan:
//                                                                     companyManagerVM
//                                                                         .sellerInfo
//                                                                         ?.value
//                                                                         ?.panNo,
//                                                                 buyerId:
//                                                                     companyId,
//                                                                 sellerId: getIt<
//                                                                         TransactionManager>()
//                                                                     .selectedSeller
//                                                                     .value
//                                                                     ?.Anchor_id,
//                                                                 orderAmount: ((companyManagerVM.payableAmount.toString() !=
//                                                                                 '0') &&
//                                                                             (companyManagerVM.payableAmount.toString() !=
//                                                                                 "null") ||
//                                                                         paidAmountController
//                                                                             .text
//                                                                             .toString()
//                                                                             .isNotEmpty)
//                                                                     ? paidAmountController
//                                                                         .text
//                                                                         .toString()
//                                                                     : (companyManagerVM.sellerInfo?.value?.totalPayable ??
//                                                                             0)
//                                                                         .toString(),
//                                                                 discount: paidAmountController
//                                                                         .text
//                                                                         .isEmpty
//                                                                     ? (companyManagerVM.sellerInfo?.value?.totalDiscount ??
//                                                                             0.0)
//                                                                         .toString()
//                                                                     : (companyManagerVM.sellerInfoForPartPay?.value?.totalDiscount ??
//                                                                             0.0)
//                                                                         .toString(),
//                                                                 settle_amount: paidAmountController
//                                                                         .text
//                                                                         .isEmpty
//                                                                     ? (companyManagerVM.sellerInfo?.value?.totalPayable ??
//                                                                             0)
//                                                                         .toString()
//                                                                     : paidAmountController
//                                                                         .text,
//                                                                 outStandingAmount: paidAmountController
//                                                                         .text
//                                                                         .isEmpty
//                                                                     ? (companyManagerVM.sellerInfo?.value?.totalOutstanding ??
//                                                                             0.0)
//                                                                         .toString()
//                                                                     : (companyManagerVM.sellerInfoForPartPay?.value?.totalOutstanding ??
//                                                                             0.0)
//                                                                         .toString(),
//                                                               );
//                                                               context
//                                                                   .hideLoader();
//                                                               //  progress.dismiss();
//                                                               if (sendPayment !=
//                                                                   null) {
//                                                                 if (sendPayment[
//                                                                         'status'] ==
//                                                                     true) {
//                                                                   // ScaffoldMessenger.of(
//                                                                   //         context)
//                                                                   //     .showSnackBar(
//                                                                   //         SnackBar(
//                                                                   //             behavior:
//                                                                   //                 SnackBarBehavior.floating,
//                                                                   //             content:ConstantText(
//                                                                   //text:
//                                                                   //               sendPayment['message'],
//                                                                   //               style: TextStyle(color: Colors.green),
//                                                                   //             )));
//
//                                                                   // if (sendPayment[
//                                                                   //         'payment_link'] !=
//                                                                   //     null) {
//                                                                   String url =
//                                                                       sendPayment[
//                                                                           'payment_link'];
//                                                                   Navigator.push(
//                                                                       context,
//                                                                       MaterialPageRoute(
//                                                                           builder: (context) => PaymentUrl(
//                                                                                 paymentUrl: url,
//                                                                               )));
//                                                                   // } else {
//                                                                   //   Fluttertoast
//                                                                   //       .showToast(
//                                                                   //           msg:
//                                                                   //               "something went wrong");
//                                                                   // }
//                                                                 } else {
//                                                                   ScaffoldMessenger.of(
//                                                                           context)
//                                                                       .showSnackBar(SnackBar(
//                                                                           behavior: SnackBarBehavior.floating,
//                                                                           content: ConstantText(
//                                                                             text:
//                                                                                 sendPayment['message'],
//                                                                             style:
//                                                                                 TextStyle(color: Colors.green),
//                                                                           )));
//                                                                 }
//                                                               } else {
//                                                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                                                     behavior:
//                                                                         SnackBarBehavior
//                                                                             .floating,
//                                                                     content: ConstantText(
//                                                                         text:
//                                                                             "Please select the seller",
//                                                                         style: TextStyle(
//                                                                             color:
//                                                                                 Colors.red))));
//                                                               }
//                                                               // }
//                                                             }
//                                                           },
//                                                           child: Column(
//                                                             children: [
//                                                               Container(
//                                                                 alignment: Alignment
//                                                                     .centerLeft,
//                                                                 child: InkWell(
//                                                                   onTap:
//                                                                       () async {
//                                                                     showDialog(
//                                                                       context:
//                                                                           context,
//                                                                       builder:
//                                                                           (_) =>
//                                                                               new AlertDialog(
//                                                                         title: new ConstantText(
//                                                                             text:
//                                                                                 'Payment Summary'),
//                                                                         icon:
//                                                                             GestureDetector(
//                                                                           onTap:
//                                                                               () {
//                                                                             Navigator.of(context).pop(context);
//                                                                           },
//                                                                           child: Align(
//                                                                               alignment: Alignment.topRight,
//                                                                               child: Icon(
//                                                                                 Icons.close_sharp,
//                                                                                 color: Colors.red,
//                                                                               )),
//                                                                         ),
//                                                                         content:
//                                                                             PaymentSummaryScreen(
//                                                                           h1p:
//                                                                               h1p,
//                                                                           maxWidth:
//                                                                               maxWidth,
//                                                                           h30p:
//                                                                               h30p,
//                                                                           w10p:
//                                                                               w10p,
//                                                                           maxheight:
//                                                                               maxHeight,
//                                                                           isPartPaymentChecked:
//                                                                               paidAmountController.text,
//                                                                         ),
//                                                                       ),
//                                                                     );
//                                                                   },
//                                                                   child:
//                                                                       ConstantText(
//                                                                     text:
//                                                                         'Payment Summary',
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .left,
//                                                                     style: TextStyle(
//                                                                         decoration:
//                                                                             TextDecoration
//                                                                                 .underline,
//                                                                         color: Color.fromARGB(
//                                                                             255,
//                                                                             2,
//                                                                             80,
//                                                                             143)),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               SizedBox(
//                                                                   height: 20),
//                                                               Container(
//                                                                 height: h1p * 5,
//                                                                 decoration:
//                                                                     BoxDecoration(
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               6),
//                                                                   color: Colours
//                                                                       .successPrimary,
//                                                                 ),
//                                                                 child: Center(
//                                                                     child:
//                                                                         ConstantText(
//                                                                   text:
//                                                                       "PAY NOW",
//                                                                   style: TextStyles
//                                                                       .subHeading,
//                                                                 )),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       )
//                                                     ])))),
//                                       ],
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           );
//                         })));
//                   });
//                 } else {
//                   return Center(
//                       child: ImageFromAssetPath<Widget>(
//                               assetPath: ImageAssetpathConstant.loader,
//                               height: 70
//                               // "assets/images/Spinner-3-unscreen.gif",
//                               //color: Colors.orange,
//                               )
//                           .imageWidget);
//                 }
//                 // } else {
//                 //   return Center(
//                 //       // child: CircularProgressIndicator(
//                 //       //   color: Colors.white,
//                 //       child: ImageFromAssetPath<Widget>(
//                 //                assetPath:
//                 //           "assets/images/loaderxuriti-unscreen.gif",
//                 //           height: 70
//                 //           // "assets/images/Spinner-3-unscreen.gif",
//                 //           //color: Colors.orange,
//                 //           ));
//                 // }
//               }));
//     });
//   }
// }
