import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/selectedImageWidget.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/previouslyUploadedDocuments.dart';
import 'package:xuriti/util/common/string_constants.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../logic/view_models/kyc_manager.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/document_uploading.dart';
import '../../widgets/kyc_widgets/submitt_button.dart';

class VintageProof extends StatefulWidget {
  const VintageProof({Key? key}) : super(key: key);

  @override
  State<VintageProof> createState() => _VintageProofState();
}

class _VintageProofState extends State<VintageProof> {
  RxList<File?> vintageImages = RxList<File?>();
  RxString firm = "Business Vintage Proof".obs;

  RxString docType = "".obs;
  final ScrollController savedDocController = ScrollController();
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  KycManager kycManager = Get.put(KycManager());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      kycManager.getKycStatusDetails();
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
                  ),
                ),
                child: ListView(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: w1p * 3, vertical: h1p * 3),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: ImageFromAssetPath<Widget>(
                                    assetPath: ImageAssetpathConstant.arrowLeft)
                                .imageWidget),
                        SizedBox(
                          width: w10p * .3,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const ConstantText(
                            text: vintage_proof,
                            style: TextStyles.leadingText,
                          ),
                        ),
                        SizedBox(
                          width: w10p * 5.5,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: w1p * 6,
                        right: w1p * 6,
                        top: h1p * 1.5,
                        bottom: h1p * 1),
                    child: ConstantText(
                      text: if_business_and_residence_is_rented_message,
                      style: TextStyles.textStyle123,
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Radio(
                          value: "Business Vintage Proof",
                          groupValue: firm.value,
                          onChanged: (value) {
                            firm.value = value.toString();
                          },
                        ),
                        ConstantText(
                          text: business_vintage_proof,
                          style: TextStyles.textStyle55,
                        ),
                      ],
                    ),
                  ),
                  PreviouslyUploadedDocuments(
                    constraints: constraints,
                    imgfiles: kycManager
                        .kycStatusModel?.value?.data?.vintage?.files
                        ?.map((e) => e.url ?? "")
                        .toList(),
                    maxHeight: maxHeight,
                    maxWidth: maxWidth,
                    docHeadingName: vintage,
                    documentName: kycManager
                            .kycStatusModel?.value?.data?.vintage?.files
                            ?.map((e) => e.documentName ?? "")
                            .toList() ??
                        [],
                  ),
                  DocumentUploading(
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                    shouldPickFile: vintageImages.isEmpty,
                    onFileSelection: (files) {
                      if ((files?.length ?? 0) != 0) {
                        vintageImages.addAll(files!);
                      }
                    },
                  ),
                  SelectedImageWidget(
                    documentImages: vintageImages,
                    onTapCrossIcons: (index) {
                      vintageImages.removeAt(index);
                    },
                  ),
                  InkWell(
                    onTap: () async {
                      context.showLoader();
                      Map<String, dynamic> storeVintageProof =
                          await kycManager.storeVintageProof(
                              filePath: vintageImages.first?.path ?? "");
                      context.hideLoader();
                      Fluttertoast.showToast(msg: storeVintageProof['msg']);
                      if (storeVintageProof['error'] == false) {
                        kycManager.getKycStatusDetails();
                        Navigator.pop(context, false);
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
          }),
        ),
      );
    });
  }
}

Widget imageDialog(path) {
  return Icon(
    FontAwesome.doc,
    size: 45,
  );
}
