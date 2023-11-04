import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/previouslyUploadedDocuments.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/selectedImageWidget.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../logic/view_models/kyc_manager.dart';

import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/document_uploading.dart';
import '../../widgets/kyc_widgets/submitt_button.dart';

class BussinessProof extends StatefulWidget {
  const BussinessProof({Key? key}) : super(key: key);

  @override
  State<BussinessProof> createState() => _BussinessProofState();
}

class _BussinessProofState extends State<BussinessProof> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController documentNoController = TextEditingController();

  final ScrollController savedDocController = ScrollController();

  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  KycManager kycManager = Get.put(KycManager());

  RxList<File?> businessProofImages = RxList<File?>();

  RxString docType = "".obs;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      kycManager.getKycStatusDetails();
    });
    kycManager.kycStatusModel?.listen((p0) {
      documentNoController.text = p0?.data?.business?.documentNumber ?? "";
      docType.value = p0?.data?.business?.documentType ?? "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxHeight = constraints.maxHeight;
        double maxWidth = constraints.maxWidth;
        double h1p = maxHeight * 0.01;
        double h10p = maxHeight * 0.1;
        double w10p = maxWidth * 0.1;
        double w1p = maxWidth * 0.01;
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colours.black,
            appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                toolbarHeight: h10p * .9,
                flexibleSpace: AppbarWidget()),
            body: Obx(
              () {
                return Container(
                    width: maxWidth,
                    decoration: const BoxDecoration(
                        color: Colours.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )),
                    child: ListView(children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: w1p * 3, vertical: h1p * 3),
                          child: Row(
                            children: [
                              ImageFromAssetPath<Widget>(
                                      assetPath:
                                          ImageAssetpathConstant.arrowLeft)
                                  .imageWidget,
                              SizedBox(
                                width: w10p * .3,
                              ),
                              const ConstantText(
                                text: business_proof,
                                style: TextStyles.leadingText,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: w1p * 6,
                          right: w1p * 6,
                          top: h1p * 1,
                        ),
                        child: ConstantText(
                          text: document_type,
                          style: TextStyles.textStyle122,
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  Radio(
                                    value: "GSTN Certificate ",
                                    groupValue: docType.value,
                                    onChanged: (value) {
                                      docType.value = value.toString();
                                    },
                                  ),
                                  ConstantText(
                                    text: gstn_certificate,
                                    style: TextStyles.textStyle55,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  Radio(
                                    value:
                                        "Utility bill for current business address",
                                    groupValue: docType.value,
                                    onChanged: (value) {
                                      docType.value = value.toString();
                                    },
                                  ),
                                  ConstantText(
                                    text:
                                        utility_bill_for_current_business_address,
                                    style: TextStyles.textStyle55,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  Radio(
                                    value: "Shop Act",
                                    groupValue: docType.value,
                                    onChanged: (value) {
                                      docType.value = value.toString();
                                    },
                                  ),
                                  ConstantText(
                                    text: shop_act,
                                    style: TextStyles.textStyle55,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  Radio(
                                    value: "Firm PAN",
                                    groupValue: docType.value,
                                    onChanged: (value) {
                                      docType.value = value.toString();
                                    },
                                  ),
                                  ConstantText(
                                    text: firmPAN,
                                    style: TextStyles.textStyle55,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  Radio(
                                    value:
                                        "Letter of signatory authorization (for partnership)",
                                    groupValue: docType.value,
                                    onChanged: (value) {
                                      docType.value = value.toString();
                                    },
                                  ),
                                  ConstantText(
                                    text:
                                        letter_of_signatory_authorization_for_partnership,
                                    style: TextStyles.textStyle55,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  Radio(
                                    value: "Udyog Adhar",
                                    groupValue: docType.value,
                                    onChanged: (value) {
                                      docType.value = value.toString();
                                    },
                                  ),
                                  ConstantText(
                                    text: udyogAdhar,
                                    style: TextStyles.textStyle55,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  Radio(
                                    value: "Board Resolution (for companies)",
                                    groupValue: docType.value,
                                    onChanged: (value) {
                                      docType.value = value.toString();
                                    },
                                  ),
                                  ConstantText(
                                    text: board_resolution_companies,
                                    style: TextStyles.textStyle55,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: w1p * 6, right: w1p * 6, top: h1p * 3),
                              child: Container(
                                //key: _formKey,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0x26000000),
                                        offset: Offset(0, 1),
                                        blurRadius: 1,
                                        spreadRadius: 0)
                                  ],
                                  color: Colours.paleGrey,
                                ),
                                child: TextBoxField(
                                  controller: documentNoController =
                                      TextEditingController(
                                          text: '${documentNoController.text}'),
                                  onChanged: (value) {
                                    value = documentNoController.text;
                                  },
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: w1p * 6, vertical: h1p * .5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colours.paleGrey,
                                  hintText: document_number,
                                  hintStyle: TextStyles.textStyle120,
                                  validator: (value1) {
                                    if (value1 == null || value1.isEmpty) {
                                      return enter_valid_number;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h1p * 3,
                            ),
                            PreviouslyUploadedDocuments(
                              constraints: constraints,
                              imgfiles: kycManager
                                  .kycStatusModel?.value?.data?.business?.files
                                  ?.map((e) => e.url ?? "")
                                  .toList(),
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                              docHeadingName: business,
                              documentName: kycManager.kycStatusModel?.value
                                      ?.data?.business?.files
                                      ?.map((e) => e.documentName ?? "")
                                      .toList() ??
                                  [],
                            ),
                            DocumentUploading(
                              maxWidth: maxWidth,
                              maxHeight: maxHeight,
                              flag: false,
                              shouldPickFile: businessProofImages.isEmpty,
                              onFileSelection: (files) {
                                if ((files?.length ?? 0) != 0) {
                                  businessProofImages.addAll(files!.toList());
                                }
                              },
                            ),
                            SelectedImageWidget(
                              documentImages: businessProofImages,
                              onTapCrossIcons: (index) {
                                businessProofImages.removeAt(index);
                              },
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          context.showLoader();
                          Map<String, dynamic> kyc =
                              await kycManager.storeBusinessProof(
                                  documentNoController.text, docType.value,
                                  filePath:
                                      businessProofImages.first?.path ?? "");
                          context.hideLoader();
                          Fluttertoast.showToast(msg: kyc['msg'] ?? "");
                          if (kyc['error'] == false) {
                            Navigator.pop(context, false);
                            kycManager.getKycStatusDetails();
                          }
                        },
                        child: Submitbutton(
                          maxWidth: maxWidth,
                          maxHeight: maxHeight,
                          content: save_and_continue,
                          isKyc: true,
                        ),
                      )
                    ]));
              },
            ),
          ),
        );
      },
    );
  }
}

Widget imageDialog(path) {
  return Icon(
    FontAwesome.doc,
    size: 45,
  );
}
