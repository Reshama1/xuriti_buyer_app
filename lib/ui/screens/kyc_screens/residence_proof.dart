import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xuriti/logic/view_models/kyc_manager.dart';
import 'package:xuriti/ui/widgets/appbar/app_bar_widget.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/submitt_button.dart';
import 'package:xuriti/util/common/string_constants.dart';
import 'package:xuriti/util/common/text_constant_widget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../theme/constants.dart';
import '../../widgets/kyc_widgets/document_uploading.dart';
import '../../widgets/kyc_widgets/previouslyUploadedDocuments.dart';
import '../../widgets/kyc_widgets/selectedImageWidget.dart';

class ResidenceProof extends StatefulWidget {
  const ResidenceProof({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ResidenceProofState();
  }
}

class _ResidenceProofState extends State<ResidenceProof> {
  RxList<File?> residenceProofImages =
      RxList<File?>(); //RxNullable<File?>().setNull();
  KycManager kycManager = Get.put(KycManager());
  RxString docType = "".obs;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      kycManager.getKycStatusDetails();
    });

    kycManager.kycStatusModel?.listen((p0) {
      docType.value = p0?.data?.residence?.documentType ?? "";
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
            backgroundColor: Colors.black,
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              toolbarHeight: h10p * 0.9,
              flexibleSpace: AppbarWidget(),
            ),
            body: Container(
              width: maxWidth,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Obx(
                () {
                  return ListView(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: w1p * 3, vertical: h1p * 3),
                          child: Row(children: [
                            SvgPicture.asset("assets/images/arrowLeft.svg"),
                            SizedBox(
                              width: w10p * .3,
                            ),
                            ConstantText(
                              text: residence_proof,
                              style: TextStyles.leadingText,
                            )
                          ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: w1p * 6, right: w1p * 6, top: h1p * 1),
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
                              title: Row(children: [
                                Radio(
                                    value: "Electricity Bill",
                                    groupValue: docType.value,
                                    onChanged: ((value) {
                                      docType.value = value.toString();
                                    })),
                                ConstantText(
                                  text: electricity_bill,
                                  style: TextStyles.textStyle55,
                                )
                              ]),
                            ),
                            ListTile(
                              title: Row(children: [
                                Radio(
                                    value: "Gas Bill",
                                    groupValue: docType.value,
                                    onChanged: (value) {
                                      docType.value = value.toString();
                                    }),
                                ConstantText(
                                  text: gas_bill,
                                  style: TextStyles.textStyle55,
                                )
                              ]),
                            ),
                            ListTile(
                              title: Row(children: [
                                Radio(
                                    value: "Rental Agreement",
                                    groupValue: docType.value,
                                    onChanged: (value) {
                                      docType.value = value.toString();
                                    }),
                                ConstantText(
                                  text: rental_agreement,
                                  style: TextStyles.textStyle55,
                                )
                              ]),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  Radio(
                                      value: "Property Tax Receipt",
                                      groupValue: docType.value,
                                      onChanged: (value) {
                                        docType.value = value.toString();
                                      }),
                                  ConstantText(
                                    text: property_tax_receipt_if_self_owned,
                                    style: TextStyles.textStyle55,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(children: [
                                Radio(
                                    value: "Other",
                                    groupValue: docType.value,
                                    onChanged: (value) {
                                      docType.value = value.toString();
                                    }),
                                ConstantText(
                                  text: other,
                                  style: TextStyles.textStyle55,
                                )
                              ]),
                            ),
                            SizedBox(
                              height: h1p * 3,
                            ),
                            PreviouslyUploadedDocuments(
                              constraints: constraints,
                              imgfiles: kycManager.kycStatusModel?.value?.data
                                      ?.residence?.files
                                      ?.map((e) => e.url ?? "")
                                      .toList() ??
                                  [],
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                              docHeadingName: residence,
                              documentName: kycManager.kycStatusModel?.value
                                      ?.data?.residence?.files
                                      ?.map((e) => e.documentName ?? "")
                                      .toList() ??
                                  [],
                            ),
                            DocumentUploading(
                              maxWidth: maxWidth,
                              maxHeight: maxHeight,
                              flag: false,
                              shouldPickFile: residenceProofImages.isEmpty,
                              onFileSelection: (files) {
                                if ((files?.length ?? 0) != 0) {
                                  residenceProofImages.addAll(files!);
                                }
                              },
                            ),
                            SelectedImageWidget(
                              documentImages: residenceProofImages,
                              onTapCrossIcons: (index) {
                                residenceProofImages.removeAt(index);
                              },
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (docType.value != "" &&
                              residenceProofImages.first != null) {
                            context.showLoader();
                            Map<String, dynamic> kycOutput =
                                await kycManager.storeResidenceProof(
                              docType.value,
                              filePath: residenceProofImages
                                  .map((e) => e?.path ?? "")
                                  .toList(),
                            );

                            context.hideLoader();
                            Fluttertoast.showToast(msg: kycOutput['msg']);
                            if (!kycOutput['error']) {
                              Navigator.pop(context, false);
                              kycManager.getKycStatusDetails();
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: please_fill_all_mandatory_field);
                          }
                        },
                        child: Submitbutton(
                            maxWidth: maxWidth,
                            isKyc: true,
                            maxHeight: maxHeight,
                            content: save_and_continue),
                      )
                    ],
                  );
                },
              ),
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
  );
}
