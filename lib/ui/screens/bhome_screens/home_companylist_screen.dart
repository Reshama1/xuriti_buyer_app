// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_progress_hud/flutter_progress_hud.dart';
// import 'package:get/get.dart';
//
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
// import 'package:xuriti/logic/view_models/auth_manager.dart';
// import 'package:xuriti/ui/screens/kyc_screens/kyc_verification_screen.dart';
// import '../../../logic/view_models/trans_history_manager.dart';
// import '../../../logic/view_models/transaction_manager.dart';
// import '../../../models/core/get_company_list_model.dart';
// import '../../../models/helper/service_locator.dart';
// import '../../../new modules/common_widget.dart';
// import '../../../new modules/image_assetpath_constants.dart';
// import '../../../util/common/text_constant_widget.dart';
// import '../../routes/router.dart';
//
// import '../../theme/constants.dart';
//
// class HomeCompanyList extends StatefulWidget {
//   const HomeCompanyList({Key? key}) : super(key: key);
//
//   @override
//   State<HomeCompanyList> createState() => _HomeCompanyListState();
// }
//
// class _HomeCompanyListState extends State<HomeCompanyList> {
//   CompanyDetails? status;
//
//   CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
//
//   @override
//   Widget build(BuildContext context) {
//     DateTime _lastExitTime = DateTime.now();
//     Provider.of<TransHistoryManager>(context).disposeInvoices();
//     onWillPop() async {
//       if (DateTime.now().difference(_lastExitTime) >= Duration(seconds: 2)) {
//         //showing message to user
//         final snack = SnackBar(
//           content:
//               ConstantText(text: "Press the back button again to exit the app"),
//           duration: Duration(seconds: 2),
//         );
//         ScaffoldMessenger.of(context).showSnackBar(snack);
//         _lastExitTime = DateTime.now();
//         // Provider.of<TransHistoryManager>(context).disposeInvoices();
//         return false; // disable back press
//       } else {
//         //  checkid? SystemNavigator.pop():Navigator.pop(context);
//         // if (checkid != null && checkid) {
//         //   SystemNavigator.pop();
//         //   return true;
//         // }
//         // Navigator.pushNamed(context, homeCompanyList);
//         // Provider.of<TransHistoryManager>(context).disposeInvoices();
//         SystemNavigator.pop();
//         // exit(0);
//         return true; //  exit the app
//       }
//     }
//
//     print(token.toString());
//     bool checkid = false;
//     getIt<SharedPreferences>().setBool('checkId', checkid);
//
//     return LayoutBuilder(builder: (context, constraints) {
//       double maxHeight = constraints.maxHeight;
//       double maxWidth = constraints.maxWidth;
//       double h1p = maxHeight * 0.01;
//       double h10p = maxHeight * 0.1;
//       // double w10p = maxWidth * 0.1;
//       double w1p = maxWidth * 0.01;
//
//       return OrientationBuilder(builder: (context, orientation) {
//         bool isPortrait = orientation == Orientation.portrait;
//         return WillPopScope(
//           onWillPop: onWillPop,
//           child: SafeArea(
//               child: FutureBuilder(
//                   future: companyListViewModel.getCompanyList(id, (value) {}),
//                   builder: (context, snapshot) {
//                     // if (snapshot.connectionState == ConnectionState.done) {
//                     if (snapshot.hasError) {
//                       return Center(
//                         child: ConstantText(
//                           text: '${snapshot.error} occurred',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       );
//                     } else if (snapshot.hasData) {
//                       List<GetCompany> data = snapshot.data as List<GetCompany>;
//                       return SafeArea(
//                         child: Scaffold(
//                           floatingActionButton: FloatingActionButton(
//                             backgroundColor: Colours.tangerine,
//                             foregroundColor: Colours.white,
//                             onPressed: () async => showDialog<String>(
//                               context: context,
//                               builder: (BuildContext context) => AlertDialog(
//                                 title: const ConstantText(text: 'Logging out'),
//                                 content:
//                                     const ConstantText(text: 'Are you sure?'),
//                                 actions: <Widget>[
//                                   TextButton(
//                                     onPressed: () =>
//                                         Navigator.pop(context, 'Cancel'),
//                                     child: const ConstantText(
//                                       text: 'Cancel',
//                                       style:
//                                           TextStyle(color: Colours.tangerine),
//                                     ),
//                                   ),
//                                   TextButton(
//                                     onPressed: () async {
//                                       await getIt<AuthManager>().logOut();
//                                       await getIt<SharedPreferences>().clear();
//                                       await getIt<SharedPreferences>()
//                                           .setString('onboardViewed', 'true');
//                                       await FirebaseMessaging.instance
//                                           .deleteToken();
//                                       Navigator.pushNamed(context, getStarted);
//                                     },
//                                     child: const ConstantText(
//                                       text: 'OK',
//                                       style:
//                                           TextStyle(color: Colours.tangerine),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             child: Icon(Icons.logout),
//                           ),
//                           backgroundColor: Colours.black,
//                           appBar: AppBar(
//                             elevation: 0,
//                             backgroundColor: Colours.black,
//                             automaticallyImplyLeading: false,
//                             toolbarHeight: orientation == Orientation.portrait
//                                 ? h1p * 10
//                                 : h1p * 15,
//                             flexibleSpace: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       vertical:
//                                           orientation == Orientation.portrait
//                                               ? h1p * 2
//                                               : h1p * 3,
//                                       horizontal:
//                                           orientation == Orientation.portrait
//                                               ? w1p * 3
//                                               : w1p * 2),
//                                   child: ImageFromAssetPath<Widget>(
//                                     assetPath: ImageAssetpathConstant.xuriti1,
//                                   ).imageWidget,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           body: ProgressHUD(
//                             child: Container(
//                               width: maxWidth,
//                               decoration: const BoxDecoration(
//                                   color: Colours.white,
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(26),
//                                     topRight: Radius.circular(26),
//                                   )),
//                               child: SizedBox(
//                                 // height: isPortrait
//                                 //     ? maxHeight - h1p * 16.2
//                                 //     : maxHeight - h1p * 22,
//                                 height: double.infinity,
//                                 child: CustomScrollView(slivers: [
//                                   SliverList(
//                                       delegate: SliverChildListDelegate(
//                                     [
//                                       Padding(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: w1p * 5),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             InkWell(
//                                               onTap: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               child: ImageFromAssetPath<Widget>(
//                                                       assetPath:
//                                                           ImageAssetpathConstant
//                                                               .arrowLeft)
//                                                   .imageWidget,
//                                             ),
//                                             Padding(
//                                               padding: EdgeInsets.symmetric(
//                                                   vertical: h1p * 5),
//                                               child: ConstantText(
//                                                 text: "Retailer",
//                                                 style: TextStyles.textStyle56,
//                                               ),
//                                             ),
//                                             InkWell(
//                                                 onTap: () {
//                                                   Navigator.pushNamed(
//                                                       context, addCompany);
//                                                 },
//                                                 child: Icon(Icons.add))
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   )),
//                                   SliverList(
//                                       delegate: SliverChildBuilderDelegate(
//                                     (context, index) {
//                                       final gstno =
//                                           data[index].companyDetails!.gstin ??
//                                               '';
//
//                                       return InkWell(
//                                           onTap: () async {
//                                             print("clicked...........");
//                                             String? companyId =
//                                                 data[index].companyDetails!.sId;
//                                             String? companyName = data[index]
//                                                 .companyDetails!
//                                                 .companyName;
//                                             // String getNewLineString() {
//                                             //   StringBuffer sb = new StringBuffer();
//                                             //   for (String line in companyName) {
//                                             //     sb.write(line + "\n");
//                                             //   }
//                                             //   return sb.toString();
//                                             // }
//
//                                             String? companyStatus = data[index]
//                                                 .companyDetails!
//                                                 .status;
//                                             if (companyStatus == "Approved") {
//                                               print("Active");
//                                               ConstantText(text: "Active");
//                                             }
//                                             await getIt<SharedPreferences>()
//                                                 .setString(
//                                                     'companyId', companyId!);
//                                             await getIt<SharedPreferences>()
//                                                 .setString('companyStatus',
//                                                     companyStatus!);
//                                             await getIt<SharedPreferences>()
//                                                 .setString('companyName',
//                                                     companyName!);
//                                             await getIt<SharedPreferences>()
//                                                 .setInt('companyIndex', index);
//
//                                             if (companyStatus == "Approved") {
//                                               await getIt<TransHistoryManager>()
//                                                   .getPaymentHistory(companyId);
//                                               await getIt<SharedPreferences>()
//                                                   .setBool('isFirstTimeFilter',
//                                                       true);
//                                               Navigator.pushReplacementNamed(
//                                                   context, landing);
//                                             } else if (companyStatus ==
//                                                 "Hold") {
//                                               showDialog<String>(
//                                                   context: context,
//                                                   builder: (BuildContext
//                                                           context) =>
//                                                       // Container(
//                                                       //   decoration: const BoxDecoration(
//                                                       //       color: Colours.white,
//                                                       //       borderRadius: BorderRadius.only(
//                                                       //         topLeft: Radius.circular(26),
//                                                       //         topRight: Radius.circular(26),
//                                                       //       )),
//                                                       //   child:
//                                                       // companyStatus == "Hold"?
//                                                       AlertDialog(
//                                                         shape: RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         15.0)),
//                                                         title:
//                                                             const ConstantText(
//                                                           text: 'KYC',
//                                                           style: TextStyles
//                                                               .textStyle56,
//                                                         ),
//                                                         content: ConstantText(
//                                                           text:
//                                                               // 'You are not allowed to perform any operation, $companyName status is $companyStatus. Please proceed to KYC Verification.',
//                                                               '$companyName status is on $companyStatus. Would you like to proceed for KYC verification process?',
//                                                           style: TextStyles
//                                                               .textStyle117,
//                                                         ),
//                                                         actions: <Widget>[
//                                                           Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .end,
//                                                             children: [
//                                                               TextButton(
//                                                                 autofocus: true,
//                                                                 onPressed: () {
//                                                                   getIt<SharedPreferences>()
//                                                                       .setBool(
//                                                                           'keyPending',
//                                                                           true);
//                                                                   Navigator.of(
//                                                                           context)
//                                                                       .push(new MaterialPageRoute(
//                                                                           builder: (context) =>
//                                                                               KycVerification()));
//                                                                 },
//                                                                 child: Icon(
//                                                                   Icons.check,
//                                                                   color: Colors
//                                                                       .green,
//                                                                 ),
//                                                                 // onPressed: () =>
//                                                                 //     Navigator.pop(context, 'Cancel'),
//                                                               ),
//                                                               TextButton(
//                                                                 onPressed: () =>
//                                                                     Navigator.pop(
//                                                                         context,
//                                                                         'Cancel'),
//                                                                 child: Icon(
//                                                                   Icons.close,
//                                                                   color: Colours
//                                                                       .paleRed,
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ],
//                                                       )
//                                                   // : Container()
//
//                                                   // ),
//                                                   );
//
//                                               // ScaffoldMessenger.of(context)
//                                               //     .showSnackBar(SnackBar(
//                                               //         duration:
//                                               //             Duration(seconds: 2),
//                                               //         behavior:
//                                               //             SnackBarBehavior.floating,
//                                               //         content: ConstantText(
//                                               // text:
//                                               //           'You are not allowed to perform any operation, $companyName status is $companyStatus. Please contact to Xuriti team.',
//                                               //           style: TextStyle(
//                                               //               color: Colors.red),
//                                               //         )));
//                                             } else if (companyStatus ==
//                                                 "Inactive") {
//                                               print("&&&&&&&&&&&inactive");
//                                               // companyStatus == "Inactive"
//                                               //     ?
//                                               ScaffoldMessenger.of(context)
//                                                   .showSnackBar(SnackBar(
//                                                       duration:
//                                                           Duration(seconds: 5),
//                                                       behavior: SnackBarBehavior
//                                                           .floating,
//                                                       content: ConstantText(
//                                                         text:
//                                                             'You are not allowed to perform any operation, $companyName status is $companyStatus. Please contact to Xuriti team.',
//                                                         style: TextStyle(
//                                                             color:
//                                                                 Colors.white),
//                                                       )));
//                                             } else if (companyStatus ==
//                                                 "In-Progress") {
//                                               print(
//                                                   "step 1 = STATUS- In-Progress");
//                                               showDialog(
//                                                 context: context,
//                                                 builder: (BuildContext
//                                                         context) =>
//
//                                                     // Container(
//                                                     //   decoration:
//                                                     //       const BoxDecoration(
//                                                     //           color: Colours
//                                                     //               .white,
//                                                     //           borderRadius:
//                                                     //               BorderRadius.only(
//                                                     //             topLeft:
//                                                     //                 Radius.circular(26),
//                                                     //             topRight:
//                                                     //                 Radius.circular(26),
//                                                     //           )),
//                                                     //   child:
//                                                     AlertDialog(
//                                                   shape: RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15.0)),
//                                                   title: const ConstantText(
//                                                     text: 'Update your KYC',
//                                                     style:
//                                                         TextStyles.textStyle56,
//                                                   ),
//                                                   content: ConstantText(
//                                                     text:
//                                                         // 'You are not allowed to perform any operation, $companyName status is $companyStatus. Please proceed to KYC Verification.',
//                                                         '$companyName status is In-Progress. Please proceed for KYC verification process',
//                                                     style:
//                                                         TextStyles.textStyle117,
//                                                   ),
//                                                   actions: <Widget>[
//                                                     Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment.end,
//                                                       children: [
//                                                         TextButton(
//                                                           autofocus: true,
//                                                           onPressed: () {
//                                                             getIt<SharedPreferences>()
//                                                                 .setBool(
//                                                                     'keyPending',
//                                                                     true);
//                                                             Navigator.of(
//                                                                     context)
//                                                                 .push(new MaterialPageRoute(
//                                                                     builder:
//                                                                         (context) =>
//                                                                             KycVerification()));
//                                                           },
//                                                           child: Icon(
//                                                             Icons.check,
//                                                             color: Colors.green,
//                                                           ),
//                                                           // onPressed: () =>
//                                                           //     Navigator.pop(context, 'Cancel'),
//                                                         ),
//                                                         TextButton(
//                                                           onPressed: () =>
//                                                               Navigator.pop(
//                                                                   context,
//                                                                   'Cancel'),
//                                                           child: Icon(
//                                                             Icons.close,
//                                                             color:
//                                                                 Colours.paleRed,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 // ) // ),
//                                               );
//                                             }
//                                           },
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                               left: w1p * 5,
//                                               right: w1p * 5,
//                                               bottom: h1p * 3,
//                                             ),
//                                             child: Container(
//                                                 height: isPortrait
//                                                     ? h10p * 1.1
//                                                     : h10p * 1.8,
//                                                 decoration: BoxDecoration(
//                                                     boxShadow: [
//                                                       BoxShadow(
//                                                           blurRadius: 8.0,
//                                                           color:
//                                                               Colours.primary)
//                                                     ],
//                                                     border: Border.all(
//                                                         color: Colours.primary,
//                                                         width: 2),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                     color: Color.fromARGB(
//                                                         255, 255, 255, 255)),
//                                                 child: Padding(
//                                                   padding: EdgeInsets.only(
//                                                       left: w1p * 2,
//                                                       right: 6,
//                                                       bottom: h1p * 0.5,
//                                                       top: 8),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         isPortrait
//                                                             ? MainAxisAlignment
//                                                                 .center
//                                                             : MainAxisAlignment
//                                                                 .spaceBetween,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       isPortrait
//                                                           ? Expanded(
//                                                               child: SizedBox())
//                                                           : Container(
//                                                               width: 2,
//                                                             ),
//                                                       Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Container(
//                                                             width:
//                                                                 maxWidth * 0.65,
//                                                             child: Column(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .center,
//                                                               crossAxisAlignment:
//                                                                   CrossAxisAlignment
//                                                                       .center,
//                                                               children: [
//                                                                 ConstantText(
//                                                                   text: data[index]
//                                                                               .companyDetails ==
//                                                                           null
//                                                                       ? ""
//                                                                       : data[index]
//                                                                               .companyDetails!
//                                                                               .companyName ??
//                                                                           "",
//                                                                   style: TextStyles
//                                                                       .textStyleC85,
//                                                                 ),
//                                                                 ConstantText(
//                                                                   text:
//                                                                       "GST No :$gstno",
//                                                                   style: TextStyles
//                                                                       .textStyleC71,
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       // Expanded(child: SizedBox()),
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           // ConstantText(
//                                                           // text:''),
//                                                           SizedBox(
//                                                             width: 7.5,
//                                                           ),
//                                                           CompanyDetails
//                                                               .companyStatusToIcon(data[
//                                                                           index]
//                                                                       .companyDetails
//                                                                       ?.status ??
//                                                                   "unknown"),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 )),
//                                           ));
//                                     },
//                                     childCount: data.length,
//                                   )),
//                                 ]),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     } else {
//                       return Center(
//                           //child: CircularProgressIndicator(),
//                           child: ImageFromAssetPath<Widget>(
//                                   assetPath: ImageAssetpathConstant.loader,
//                                   height: 70
//                                   // "assets/images/Spinner-3-unscreen.gif",
//                                   //color: Colors.orange,
//                                   )
//                               .imageWidget);
//                     }
//                     //}
//                     // else {
//                     //   return Center(
//                     //     child: CircularProgressIndicator(),
//                     //   );
//                     // }
//                   })),
//         );
//       });
//     });
//   }
// }
