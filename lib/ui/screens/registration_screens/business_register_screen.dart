import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xuriti/logic/view_models/company_details_manager.dart';
import 'package:xuriti/logic/view_models/profile_manager.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/seller_id_model.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/screens/registration_screens/search_gst.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../logic/view_models/auth_manager.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';
import '../kyc_screens/pan_details_screen.dart';

class BusinessRegister extends StatefulWidget {
  const BusinessRegister({Key? key}) : super(key: key);

  @override
  State<BusinessRegister> createState() => _BusinessRegisterState();
}

class _BusinessRegisterState extends State<BusinessRegister> {
  CompanyDetailsManager companyDetailsManager =
      Get.put(CompanyDetailsManager());

  TextEditingController cinController = TextEditingController();
  TextEditingController tanController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController turnoverController = TextEditingController();
  TextEditingController gstNumber = TextEditingController();
//address
  TextEditingController addressController = TextEditingController();
  TextEditingController distController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController stateController1 = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  double sheetSize = .6;
  double maxSize = 1;

  AuthManager authManager = Get.put(AuthManager());

  Rx<SellerListDetails?>? selectedValue =
      RxNullable<SellerListDetails?>().setNull();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    companyDetailsManager.companyInfoV2.value = null;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      companyDetailsManager.getSellerDetails();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
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
                  child: ImageFromAssetPath<Widget>(
                          assetPath: ImageAssetpathConstant.xuritiLogo)
                      .imageWidget,
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                width: w10p * 2.2,
                              ),
                              ConstantText(
                                text: add_your_business,
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
                              onChanged: (value) {
                                companyDetailsManager.companyInfoV2.value =
                                    null;
                                turnoverController.text = "";
                                selectedValue?.value = null;
                              },
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                              controller: gstNumber,
                              textCapitalization: TextCapitalization.characters,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: InkWell(
                                onTap: () async {
                                  context.showLoader();
                                  gstNumber.text.isNotEmpty
                                      ? await companyDetailsManager
                                          .gstSearch2(
                                          gstNo: gstNumber.text,
                                        )
                                          .then((value) {
                                          if (value != null &&
                                              value.code == 450) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return SearchGST(
                                                    gstNo: gstNumber,
                                                    userinfo: authManager
                                                        .userDetails?.value,
                                                  );
                                                },
                                              ),
                                            );
                                            //progress.dismiss();
                                            context.hideLoader();
                                          } else if (value?.code == 412) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    gst_already_registered_with_another_user,
                                                textColor: Colors.white);
                                          } else if (value?.code == 403) {
                                            Fluttertoast.showToast(
                                                msg: invalid_gst_number,
                                                textColor: Colors.white);
                                          }
                                        })
                                      : Fluttertoast.showToast(
                                          msg: please_enter_gst_number,
                                          textColor: Colors.white);
                                  //progress.dismiss();
                                  context.hideLoader();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  width: w10p * 8.7,
                                  child: Center(
                                      child: ConstantText(
                                          text: get_gst_details,
                                          style: TextStyles.textStyle5)),
                                  decoration: BoxDecoration(
                                      color: Colours.primary,
                                      borderRadius: BorderRadius.circular(7)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Obx(() {
                          //panController.text = companyDetailsManager.panNo; // TDOD : Check for Pan number

                          addressController.text = companyDetailsManager
                                  .companyInfoV2.value?.company?.address ??
                              "";
                          distController.text = companyDetailsManager
                                  .companyInfoV2.value?.company?.district ??
                              "";

                          pincodeController.text = companyDetailsManager
                                  .companyInfoV2.value?.company?.pinCode ??
                              "";
                          stateController.text = companyDetailsManager
                                      .companyInfoV2.value?.company?.state !=
                                  null
                              ? companyDetailsManager.companyInfoV2.value
                                          ?.company?.state?.length ==
                                      0
                                  ? ""
                                  : companyDetailsManager.companyInfoV2.value
                                          ?.company?.state?.first ??
                                      ""
                              : "";
                          stateController1.text = companyDetailsManager
                                      .companyInfoV2.value?.company?.state !=
                                  null
                              ? companyDetailsManager.companyInfoV2.value
                                          ?.company?.state?.length ==
                                      0
                                  ? ""
                                  : companyDetailsManager.companyInfoV2.value
                                          ?.company?.state?.last ??
                                      ""
                              : "";
                          return companyDetailsManager
                                          .companyInfoV2.value?.status ==
                                      true &&
                                  companyDetailsManager
                                          .companyInfoV2.value?.company !=
                                      null
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Container(
                                    height: h10p * 3,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 0.5,
                                              blurRadius: 3)
                                        ]),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 24, horizontal: 18),
                                    width: maxWidth,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const ConstantText(
                                              text: company_name,
                                              style: TextStyles.textStyle17,
                                            ),
                                            colonWidget(),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: ConstantText(
                                                    text:
                                                        "${companyDetailsManager.companyInfoV2.value?.company?.companyName ?? ""}",
                                                    style:
                                                        TextStyles.textStyle16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const ConstantText(
                                              text: address,
                                              style: TextStyles.textStyle17,
                                            ),
                                            //  SizedBox(width: w10p * ,)
                                            colonWidget(),
                                            Expanded(
                                              child: ConstantText(
                                                  text:
                                                      "${companyDetailsManager.companyInfoV2.value?.company?.address ?? ""}",
                                                  //maxLines: 2,
                                                  softWrap: true,
                                                  style:
                                                      TextStyles.textStyle16),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const ConstantText(
                                              text: pan_number,
                                              style: TextStyles.textStyle17,
                                            ),
                                            colonWidget(),
                                            ConstantText(
                                                //TODO : Check for Pan number
                                                text: ((companyDetailsManager
                                                                    .companyInfoV2
                                                                    .value
                                                                    ?.company
                                                                    ?.pan ??
                                                                "")
                                                            .length ==
                                                        0
                                                    ? ((gstNumber.text.length ==
                                                            15
                                                        ? gstNumber.text
                                                            .substring(
                                                                2,
                                                                gstNumber.text
                                                                        .length -
                                                                    3)
                                                        : ""))
                                                    : (companyDetailsManager
                                                            .companyInfoV2
                                                            .value
                                                            ?.company
                                                            ?.pan ??
                                                        "")),
                                                style: TextStyles.textStyle16),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const ConstantText(
                                              text: district,
                                              style: TextStyles.textStyle17,
                                            ),
                                            colonWidget(),
                                            ConstantText(
                                                text:
                                                    "${companyDetailsManager.companyInfoV2.value?.company?.district ?? ""}",
                                                style: TextStyles.textStyle16),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const ConstantText(
                                              text: state,
                                              style: TextStyles.textStyle17,
                                            ),
                                            colonWidget(),
                                            Text(stateController.text,
                                                // "${(params.companyinfoV2?.company?.state != null ? params.companyinfoV2?.company?.state?.length == 0 ? "" : params.companyinfoV2?.company?.state?.first ?? "" : "")}",
                                                style: TextStyles.textStyle16),
                                            SizedBox(
                                              width: w10p * .2,
                                            ),
                                            colonWidget(),
                                            ConstantText(
                                                text:
                                                    "${companyDetailsManager.companyInfoV2.value?.company?.state?[1] ?? ""}", //TODO : Length Check
                                                style: TextStyles.textStyle16),
                                            const SizedBox(
                                              width: 18,
                                            ),
                                            const ConstantText(
                                              text: pin_code,
                                              style: TextStyles.textStyle17,
                                            ),
                                            colonWidget(),
                                            ConstantText(
                                                text:
                                                    "${companyDetailsManager.companyInfoV2.value?.company?.pinCode ?? ""}",
                                                style: TextStyles.textStyle16),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : companyDetailsManager
                                              .companyInfoV2.value?.status ==
                                          2 ||
                                      companyDetailsManager
                                              .companyInfoV2.value?.status ==
                                          0
                                  ? Container(
                                      child: Center(
                                        child: ConstantText(
                                            text: ""), // TODO : Error Message
                                      ),
                                    )
                                  : Container();
                        }),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: SizedBox(
                                    height: 45,
                                    child: TextBoxField(
                                      controller: tanController,
                                      textStyle: TextStyles.textStyle4,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 24),
                                      fillColor: Colours.paleGrey,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: tan,
                                    ),
                                  )),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  Expanded(
                                      child: SizedBox(
                                    height: 45,
                                    child: TextBoxField(
                                      controller: cinController,
                                      textStyle: TextStyles.textStyle4,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 24),
                                      fillColor: Colours.paleGrey,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                      hintText: cin,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 8),
                            //   child: SizedBox(
                            //     height: 45,
                            //     child: TextField(
                            //
                            //         controller: panController,
                            //         style: TextStyles.textStyle4,
                            //         decoration: InputDecoration(
                            //           contentPadding:
                            //           const EdgeInsets.symmetric(
                            //               vertical: 10, horizontal: 24),
                            //           fillColor: Colours.paleGrey,
                            //           filled: true,
                            //           border: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(10),
                            //           ),
                            //           hintText: "PAN",
                            //         )),
                            //   ),
                            // ),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: SizedBox(
                                height: 45,
                                child: TextBoxField(
                                  keyboardType: TextInputType.number,
                                  controller: turnoverController,
                                  textStyle: TextStyles.textStyle4,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 24),
                                  fillColor: Colours.paleGrey,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: annual_turn_over,
                                ),
                              ),
                            ),

                            Container(
                              height: 45,
                              width: 350,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.6),
                                ), //border of dropdown button
                                borderRadius: BorderRadius.circular(10),
                                //
                                color: Colours.paleGrey,
                              ),
                              child: Obx(
                                () => CustomDropDown(
                                  selectedValue: selectedValue?.value,
                                  items: companyDetailsManager.sellerIdModel
                                          ?.value?.sellerListDetails ??
                                      [],
                                  callback: (id) {
                                    selectedValue?.value = id;
                                  },
                                ),
                              ),
                            ),

                            BusinessCheckBox(h1p: h1p),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if (((gstNumber.text.isEmpty ||
                                              (selectedValue?.value == null)) ||
                                          turnoverController.text.isEmpty)) {
                                        return;
                                      }
                                      String gstIn = gstNumber.text;

                                      String panNo =
                                          gstIn.substring(2, gstIn.length - 3);

                                      if (companyDetailsManager.isChecked ==
                                          true) {
                                        context.showLoader();
                                        Map<String, dynamic> result =
                                            await companyDetailsManager
                                                .addEntity(
                                          gstNo: gstNumber.text,

                                          userId: authManager
                                              .userDetails?.value?.user?.sId,
                                          adminEmail: authManager
                                              .userDetails?.value?.user?.email,
                                          adminMobile: authManager.userDetails
                                              ?.value?.user?.mobileNumber,
                                          companyName: companyDetailsManager
                                              .companyInfoV2
                                              .value
                                              ?.company
                                              ?.companyName,
                                          tan: tanController.text,
                                          cin: cinController.text,
                                          pan: panController.text.isEmpty
                                              ? panNo
                                              : panController.text,
                                          // address :
                                          selectedId:
                                              (selectedValue?.value?.id ?? "")
                                                  .toString(),
                                          annualTurnover:
                                              turnoverController.text,
                                          address: addressController.text,
                                          state: stateController.text,
                                          state1: stateController1.text,
                                          district: distController.text,
                                          pincode: pincodeController.text,
                                        );

                                        // progress.dismiss();
                                        context.hideLoader();
                                        if (result['status'] == true) {
                                          Fluttertoast.showToast(
                                              msg: result['message'].toString(),
                                              textColor: Colors.green);

                                          Navigator.pushNamed(
                                              context, oktWrapper);
                                        } else {
                                          if (result['errors'] == null) {
                                            Fluttertoast.showToast(
                                                msg: result['message']
                                                    .toString(),
                                                textColor: Colors.red);
                                          } else {
                                            Fluttertoast.showToast(
                                                // msg: result['errors']
                                                //         ['message']
                                                //     .toString(),
                                                msg: please_select_seller,
                                                textColor: Colors.red);
                                          }
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: ConstantText(
                                                  text:
                                                      please_accept_terms_and_conditions,
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )));
                                      }
                                    },
                                    child: Obx(() {
                                      print(selectedValue?.value);
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        width: w10p * 8.7,
                                        child: const Center(
                                            child: ConstantText(
                                                text: create,
                                                style: TextStyles.textStyle5)),
                                        decoration: BoxDecoration(
                                          color: ((gstNumber.text.isEmpty ||
                                                      (selectedValue?.value ==
                                                          null)) ||
                                                  turnoverController
                                                      .text.isEmpty)
                                              ? Colours.warmGrey
                                              : Colours.primary,
                                          borderRadius: BorderRadius.circular(
                                            7,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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

class BusinessCheckBox extends StatefulWidget {
  const BusinessCheckBox({
    Key? key,
    required this.h1p,
  }) : super(key: key);

  final double h1p;

  @override
  State<BusinessCheckBox> createState() => _BusinessCheckBoxState();
}

class _BusinessCheckBoxState extends State<BusinessCheckBox> {
  CompanyDetailsManager companyDetailsManager =
      Get.put(CompanyDetailsManager());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: widget.h1p * .1),
        child: CheckboxListTile(
          title: GestureDetector(
              onTap: () async {
                Map<String, dynamic> data =
                    await getIt<ProfileManager>().getTermsAndConditions();
                if (data['status'] == true) {
                  _launchInBrowser(Uri.parse(
                      "https://docs.google.com/gview?embedded=true&url=${data['url']}"));
                  // Fluttertoast.showToast(msg: "Opening file");
                }
                // Fluttertoast.showToast(msg: "Technical error occurred");
                await getIt<TransactionManager>().openFile(
                    url:
                        "https://s3.ap-south-1.amazonaws.com/xuriti.public.document/xuritiTermsofService.pdf");

                Fluttertoast.showToast(msg: "Opening file");
              },
              child: ConstantText(
                text: accept_terms_and_conditions,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              )),
          value: companyDetailsManager.isChecked.value,
          onChanged: (_) {
            companyDetailsManager.isChecked.value =
                !(companyDetailsManager.isChecked.value);
          },
          controlAffinity:
              ListTileControlAffinity.leading, //  <-- leading Checkbox
        ),
      );
    });
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

class CenterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 1),
      child: ConstantText(
        text: yourShopSuccessfullyRegister,
        style: TextStyles.textStyle15,
      ),
    );
  }
}

class CustomDropDown extends StatefulWidget {
  CustomDropDown({
    super.key,
    this.selectedValue,
    required this.items,
    required this.callback,
  });

  final SellerListDetails? selectedValue;
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

          widget.callback(val);
        },
        hint: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ConstantText(
              text: widget.selectedValue != null
                  ? (widget.selectedValue?.sellerName ?? "")
                  : please_select_seller,
              style: TextStyle(
                color: Colors.black
                    .withOpacity(widget.selectedValue == null ? 0.6 : 1.0),
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
