import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/logic/view_models/company_details_manager.dart';
import 'package:xuriti/logic/view_models/profile_manager.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/seller_id_model.dart';
import 'package:xuriti/models/core/user_details.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/theme/constants.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';

import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';

class SearchGST extends StatefulWidget {
  SearchGST({super.key, this.gstNo, this.userinfo});

  final TextEditingController? gstNo;
  final userinfo;

  @override
  State<SearchGST> createState() => _SearchGSTState();
}

class _SearchGSTState extends State<SearchGST> {
  AuthManager authManager = Get.put(AuthManager());
  TextEditingController companyName = TextEditingController();

  CompanyDetailsManager companyDetailsManager =
      Get.put(CompanyDetailsManager());

  String? companyId = getIt<SharedPreferences>().getString("token");

  double sheetSize = .6;
  double maxSize = 1;
  bool showDetails = false;
  bool showButton = false;
  SellerIdModel? sellerIdModel;

  SellerListDetails? selectedValue;
  UserDetails? userInfo;

  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController gstNumber = TextEditingController();

  @override
  void initState() {
    UserDetails? userInfo = authManager.userDetails?.value;
    emailController.text = userInfo?.user?.email;
    mobileController.text = userInfo?.user?.mobileNumber;
    panController.text = widget.gstNo?.text.substring(2, 12) ?? "";
    gstNumber.text = widget.gstNo?.text ?? "";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;

      double w10p = maxWidth * 0.1;
      return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image.asset(ImageAssetpathConstant.xuritiLogo),
                )
              ]),
          body: ProgressHUD(
            child: Builder(
              builder: (context) {
                return Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ListView(
                      // controller: scrollController,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: ImageFromAssetPath<Widget>(
                                        assetPath:
                                            ImageAssetpathConstant.arrowLeft)
                                    .imageWidget,
                              ),
                              SizedBox(
                                width: w10p * 1.5,
                              ),
                              ConstantText(
                                text: register_your_company,
                                style: TextStyles.textStyle3,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            height: 45,
                            child: TextBoxField(
                              enabled: false,
                              controller: gstNumber,
                              textStyle: TextStyles.textStyle4,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 24),
                              fillColor: Colours.paleGrey,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: gst_number,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            height: 45,
                            child: TextBoxField(
                              controller: companyName,
                              textStyle: TextStyles.textStyle4,
                              inputFormatters: [],
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 24),
                              fillColor: Colours.paleGrey,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: company_name,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            height: 45,
                            child: TextBoxField(
                              enabled: false,
                              controller: panController,
                              textStyle: TextStyles.textStyle4,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 24),
                              fillColor: Colours.paleGrey,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: pan_number,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            height: 45,
                            child: TextBoxField(
                              enabled: false,
                              controller: mobileController,
                              textStyle: TextStyles.textStyle4,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 24),
                              fillColor: Colours.paleGrey,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: mobile_number,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            height: 45,
                            child: TextBoxField(
                              enabled: false,
                              controller: emailController,
                              textStyle: TextStyles.textStyle4,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 24),
                              fillColor: Colours.paleGrey,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: email,
                            ),
                          ),
                        ),
                        Consumer<CompanyDetailsManager>(
                            builder: (context, params, child) {
                          return Column(
                            children: [
                              FutureBuilder(
                                  future:
                                      companyDetailsManager.getSellerDetails(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<SellerListDetails> sellerLists =
                                          snapshot.data
                                              as List<SellerListDetails>;
                                      // selectedValue = sellerLists.first;
                                      return Consumer<CompanyDetailsManager>(
                                        builder: (context, value, child) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            height: 45,
                                            width: 350,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                              ), //border of dropdown button
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              //
                                              color: Colours.paleGrey,
                                            ),
                                            child: CustomDropDown(
                                              selectedValue: selectedValue,
                                              items: sellerLists,
                                              callback: (id) {
                                                selectedValue = id;
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    return Container();
                                  }),
                              checkbox_widget(params: params, h1p: h1p),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    widget.gstNo != null || widget.gstNo == ''
                                        ? InkWell(
                                            onTap: () async {
                                              if (companyDetailsManager
                                                      .isChecked ==
                                                  true) {
                                                // progress!.show();
                                                context.showLoader();
                                                Map<String,
                                                    dynamic> result = await getIt<
                                                        CompanyDetailsManager>()
                                                    .manualAddEntity(
                                                  gstNo: gstNumber.text,
                                                  userId: userInfo?.user?.sId,
                                                  adminEmail:
                                                      emailController.text,
                                                  adminMobile:
                                                      mobileController.text,

                                                  companyName: companyName.text,
                                                  selectedId:
                                                      selectedValue?.id ?? "",

                                                  // pan:
                                                  //     panController.text.isEmpty
                                                  //         ? panNo
                                                  //         : panController.text,
                                                  pan: panController.text,
                                                );
                                                // progress.dismiss();
                                                context.hideLoader();
                                                if (result['status'] == true) {
                                                  Fluttertoast.showToast(
                                                      msg: result['message']
                                                          .toString(),
                                                      textColor: Colors.green);

                                                  Navigator.pushNamed(
                                                      context, oktWrapper);
                                                } else {
                                                  if (result['errors'] ==
                                                      null) {
                                                    Fluttertoast.showToast(
                                                        msg: result['message']
                                                            .toString(),
                                                        textColor: Colors.red);
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg: result['errors']
                                                                ['message']
                                                            .toString(),
                                                        textColor: Colors.red);
                                                  }
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        content: ConstantText(
                                                          text:
                                                              please_accept_terms_and_conditions,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        )));
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                              width: w10p * 8.7,
                                              child: const Center(
                                                  child: ConstantText(
                                                      text: create,
                                                      style: TextStyles
                                                          .textStyle5)),
                                              decoration: BoxDecoration(
                                                  color: Colours.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(7)),
                                            ),
                                          )
                                        : Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            width: w10p * 8.7,
                                            child: const Center(
                                                child: ConstantText(
                                                    text: create,
                                                    style:
                                                        TextStyles.textStyle5)),
                                            decoration: BoxDecoration(
                                                color: Colours.warmGrey,
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ));
    });
  }
}

class checkbox_widget extends StatefulWidget {
  const checkbox_widget({Key? key, required this.h1p, required this.params})
      : super(key: key);

  final double h1p;
  final params;

  @override
  State<checkbox_widget> createState() => _checkbox_widgetState();
}

class _checkbox_widgetState extends State<checkbox_widget> {
  TransactionManager transactionManager = Get.put(TransactionManager());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.h1p * .1),
      child: CheckboxListTile(
        title: GestureDetector(
            onTap: (() async {
              Map<String, dynamic> data =
                  await getIt<ProfileManager>().getTermsAndConditions();
              if (data['status'] == true) {
                _launchInBrowser(Uri.parse(
                    "https://docs.google.com/gview?embedded=true&url=${data['url']}"));
                Fluttertoast.showToast(msg: "Opening file");
              }
              Fluttertoast.showToast(msg: "Technical error occurred");
              transactionManager.openFile(
                  url:
                      "https://s3.ap-south-1.amazonaws.com/xuriti.public.document/xuritiTermsofService.pdf");

              Fluttertoast.showToast(msg: "Opening file");
            }),
            child: ConstantText(
              text: accept_terms_and_conditions,
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            )),
        value: widget.params.isChecked,
        onChanged: (_) {
          setState(() {});
          widget.params.isChecked = !widget.params.isChecked;
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}

class CustomDropDown extends StatefulWidget {
  CustomDropDown({
    super.key,
    this.selectedValue,
    required this.items,
    required this.callback,
  });

  SellerListDetails? selectedValue;
  final List<SellerListDetails> items;
  final Function(SellerListDetails? value) callback;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButton<SellerListDetails>(
      isExpanded: true,
      value: widget.selectedValue,
      items: widget.items.map((SellerListDetails sellerListDetails) {
        return DropdownMenuItem<SellerListDetails>(
          value: sellerListDetails,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ConstantText(
              text: sellerListDetails.sellerName ?? ' ',
              style: TextStyles.textStyle122,
            ),
          ),
        );
      }).toList(),
      onChanged: (val) async {
        Fluttertoast.showToast(msg: fetching_data_please_wait);
        // setState(() {
        //   _chosenSellerId = sellerId;
        // });
        setState(() {
          widget.selectedValue = val;
          widget.callback(val);
        });
      },
      hint: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ConstantText(
              text: please_select_seller,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0)),
        ),
      ),
    ));
  }
}
