import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/logic/view_models/kyc_manager.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/previouslyUploadedDocuments.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/selectedImageWidget.dart';
import 'package:xuriti/util/common/string_constants.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/document_uploading.dart';
import '../../widgets/kyc_widgets/submitt_button.dart';

class FinancialGstDetails extends StatefulWidget {
  const FinancialGstDetails({Key? key}) : super(key: key);

  @override
  State<FinancialGstDetails> createState() => _FinancialGstDetailsState();
}

class _FinancialGstDetailsState extends State<FinancialGstDetails> {
  RxList<File?> financialImages = RxList<File>();
  RxList<File?> gstImages = RxList<File>();
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
          body: Container(
            decoration: const BoxDecoration(
                color: Colours.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            child: Obx(() => ListView(children: [
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
                                  assetPath: ImageAssetpathConstant.arrowLeft)
                              .imageWidget,
                          SizedBox(
                            width: w10p * .3,
                          ),
                          const ConstantText(
                            text: financial_gst_details,
                            style: TextStyles.leadingText,
                          ),
                          const ConstantText(
                            text: upto_twenty_four_months,
                            style: TextStyles.textStyle119,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: w1p * 6, right: w1p * 6, top: h1p * 1.5),
                    child: ConstantText(
                      text: financial_details,
                      style: TextStyles.textStyle54,
                    ),
                  ),
                  PreviouslyUploadedDocuments(
                    constraints: constraints,
                    imgfiles: kycManager
                        .kycStatusModel?.value?.data?.financial?.files
                        ?.map((e) => e.url ?? "")
                        .toList(),
                    maxHeight: maxHeight,
                    maxWidth: maxWidth,
                    docHeadingName: financial,
                    documentName: kycManager
                            .kycStatusModel?.value?.data?.financial?.files
                            ?.map((e) => e.documentName ?? "")
                            .toList() ??
                        [],
                  ),
                  DocumentUploading(
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                    flag: true,
                    shouldPickFile: financialImages.isEmpty,
                    onFileSelection: (filesObjects) {
                      if (((financialImages.length) +
                              (filesObjects?.length ?? 0)) <=
                          3) {
                        financialImages.addAll(filesObjects!);
                      } else {
                        Fluttertoast.showToast(
                            msg: selection_limit_for_3_are_accepted);
                      }
                    },
                  ),
                  SelectedImageWidget(
                    documentImages: financialImages,
                    onTapCrossIcons: (index) {
                      financialImages.removeAt(index);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: w1p * 6, vertical: h1p * 3),
                    child: ConstantText(
                      text: gst_details,
                      style: TextStyles.textStyle54,
                    ),
                  ),
                  PreviouslyUploadedDocuments(
                    constraints: constraints,
                    imgfiles: kycManager.kycStatusModel?.value?.data?.gst?.files
                        ?.map((e) => e.url ?? "")
                        .toList(),
                    maxHeight: maxHeight,
                    maxWidth: maxWidth,
                    docHeadingName: gst,
                    documentName: kycManager
                            .kycStatusModel?.value?.data?.gst?.files
                            ?.map((e) => e.documentName ?? "")
                            .toList() ??
                        [],
                  ),
                  DocumentUploading(
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                    flag: true,
                    shouldPickFile: gstImages.isEmpty,
                    onFileSelection: (files) {
                      gstImages.value = files ?? [];
                    },
                  ),
                  SelectedImageWidget(
                    documentImages: gstImages,
                    onTapCrossIcons: (index) {
                      gstImages.removeAt(index);
                    },
                  ),
                  InkWell(
                    onTap: () async {
                      context.showLoader();
                      Map<String, dynamic> storeGstDetails =
                          await kycManager.storeGstDetails(
                        filePath:
                            financialImages.map((e) => e?.path ?? "").toList(),
                        filePath1: gstImages.map((e) => e?.path ?? "").toList(),
                      );
                      context.hideLoader();
                      Fluttertoast.showToast(msg: storeGstDetails['msg']);
                      if (storeGstDetails['error'] == false) {
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
                  ),
                ])),
          ),
        ),
      );
    });
  }
}

Widget imageDialog(path) {
  return Icon(
    FontAwesome.doc,
  );
}
