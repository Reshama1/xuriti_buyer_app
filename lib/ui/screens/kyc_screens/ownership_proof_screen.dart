import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/document_uploading.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/previouslyUploadedDocuments.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/selectedImageWidget.dart';
import 'package:xuriti/util/common/string_constants.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../logic/view_models/kyc_manager.dart';
import '../../../models/helper/service_locator.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/submitt_button.dart';

class OwnershipProof extends StatefulWidget {
  const OwnershipProof({Key? key}) : super(key: key);

  @override
  State<OwnershipProof> createState() => _OwnershipProofState();
}

class _OwnershipProofState extends State<OwnershipProof> {
  int currentIndex = 0;
  RxString docType = "".obs;
  RxList<File?> ownershipImages = RxList<File?>();

  final ScrollController savedDocController = ScrollController();
  TextEditingController documentController = TextEditingController();
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  KycManager kycManager = Get.put(KycManager());

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      kycManager.getKycStatusDetails();
    });

    kycManager.kycStatusModel?.listen((p0) {
      documentController.text = p0?.data?.ownership?.documentNumber ?? "";
      docType.value = p0?.data?.ownership?.documentType ?? "";
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
      double w1p = maxWidth * 0.01;
      return SafeArea(
          child: Scaffold(
              backgroundColor: Colours.black,
              appBar: AppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  toolbarHeight: h10p * .9,
                  flexibleSpace: AppbarWidget()),
              body: Obx(() {
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
                                text: ownership_proof,
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
                            // bottom: h1p * 3,
                            top: h1p * 1),
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
                                    value: "Property Ownership Document",
                                    groupValue: docType.value,
                                    onChanged: (value) {
                                      docType.value = value.toString();
                                    },
                                  ),
                                  ConstantText(
                                    text: property_ownership_document,
                                    style: TextStyles.textStyle55,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  Radio(
                                    value: "Electricity Bill",
                                    groupValue: docType.value,
                                    onChanged: (value) {
                                      docType.value = value.toString();
                                    },
                                  ),
                                  ConstantText(
                                    text: electricity_bill,
                                    style: TextStyles.textStyle55,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: w1p * 6, right: w1p * 6, top: h1p * 3),
                              child: Container(
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
                                  controller: documentController =
                                      TextEditingController(
                                          text: '${documentController.text}'),
                                  onChanged: (value) {
                                    // documentNoController.clear();
                                    value = documentController.text;
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
                                  .kycStatusModel?.value?.data?.ownership?.files
                                  ?.map((e) => e.url ?? "")
                                  .toList(),
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                              docHeadingName: ownership,
                              documentName: kycManager.kycStatusModel?.value
                                      ?.data?.ownership?.files
                                      ?.map((e) => e.documentName ?? "")
                                      .toList() ??
                                  [],
                            ),
                            DocumentUploading(
                              maxWidth: maxWidth,
                              maxHeight: maxHeight,
                              shouldPickFile: ownershipImages.isEmpty,
                              onFileSelection: (files) {
                                if ((files?.length ?? 0) != 0) {
                                  ownershipImages.addAll(files!);
                                }
                              },
                            ),
                            SelectedImageWidget(
                              documentImages: ownershipImages,
                              onTapCrossIcons: (index) {
                                ownershipImages.removeAt(index);
                              },
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: h1p * 2,
                      // ),
                      InkWell(
                        onTap: () async {
                          if (docType != "" &&
                              documentController.text != "" &&
                              ownershipImages.isNotEmpty) {
                            context.showLoader();
                            Map<String, dynamic> kyc = await getIt<KycManager>()
                                .storeOwnershipProof(
                                    documentController.text, docType.value,
                                    filePath:
                                        ownershipImages.first?.path ?? "");
                            context.hideLoader();

                            if (_formKey.currentState!.validate() &&
                                kyc['error'] == false) {
                              Fluttertoast.showToast(
                                  msg: successfully_uploaded);
                              kycManager.getKycStatusDetails();
                              Navigator.pop(context, false);
                            }

                            Fluttertoast.showToast(msg: kyc['msg']);
                          } else {
                            Fluttertoast.showToast(
                                msg: please_fill_all_mandatory_field);
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
              })));
    });
  }
}

Widget imageDialog(path) {
  return Icon(
    FontAwesome.doc,
    size: 45,
  );
}
