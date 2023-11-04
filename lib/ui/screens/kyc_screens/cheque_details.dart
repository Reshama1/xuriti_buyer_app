// ignore_for_file: unused_import

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/logic/view_models/kyc_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/previouslyUploadedDocuments.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/selectedImageWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../Model/KycStatusDetails.dart';
import '../../../models/helper/service_locator.dart';
import '../../../models/services/dio_service.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/document_uploading.dart';
import '../../widgets/kyc_widgets/submitt_button.dart';

class ChequeDetails extends StatefulWidget {
  const ChequeDetails({Key? key}) : super(key: key);

  @override
  State<ChequeDetails> createState() => _ChequeDetailsState();
}

class _ChequeDetailsState extends State<ChequeDetails> {
  RxList<File?> chequeImages = RxList<File?>();

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
                                text: customer_cheque_copy_images,
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
                            top: h1p * 1.5,
                            bottom: h1p * 3),
                        child: ConstantText(
                          text:
                              note_please_provide_security_cheque_where_account_number_should_be_clearly_visible,
                          style: TextStyles.textStyle123,
                        ),
                      ),
                      PreviouslyUploadedDocuments(
                        constraints: constraints,
                        imgfiles: kycManager
                            .kycStatusModel?.value?.data?.chequeImages?.files
                            ?.map((e) => e.url ?? "")
                            .toList(),
                        maxHeight: maxHeight,
                        maxWidth: maxWidth,
                        docHeadingName: cheque,
                        documentName: kycManager.kycStatusModel?.value?.data
                                ?.chequeImages?.files
                                ?.map((e) => e.documentName ?? "")
                                .toList() ??
                            [],
                      ),
                      DocumentUploading(
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                        flag: true,
                        shouldPickFile: chequeImages.isEmpty,
                        onFileSelection: (filesObjects) {
                          chequeImages.value = filesObjects ?? [];
                          // if ((chequeImages?.length ?? 0) == 0 &&
                          //     (filesObjects?.length ?? 0) <= 3) {
                          //   chequeImages = filesObjects;
                          // } else if (((chequeImages?.length ?? 0) +
                          //         (filesObjects?.length ?? 0)) <=
                          //     3) {
                          //   chequeImages?.addAll(filesObjects!);
                          // } else {
                          //   Fluttertoast.showToast(
                          //       msg:
                          //           "Selection limit for 3 images are accepted");
                          // }
                        },
                      ),
                      SelectedImageWidget(
                        documentImages: chequeImages,
                        onTapCrossIcons: (index) {
                          chequeImages.removeAt(index);
                        },
                      ),
                      InkWell(
                        onTap: () async {
                          if (chequeImages.isNotEmpty) {
                            Map<String, dynamic> chequeImagesMap =
                                await kycManager.chequeImages(
                              filePath: chequeImages
                                  .map((e) => e?.path ?? "")
                                  .toList(),
                            );

                            Fluttertoast.showToast(msg: chequeImagesMap['msg']);
                            if (chequeImagesMap['error'] == false) {
                              Navigator.pop(context, false);
                              kycManager.getKycStatusDetails();
                            }
                          } else {
                            Fluttertoast.showToast(msg: please_upload_file);
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
  );
}
