import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/logic/view_models/kyc_manager.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/previouslyUploadedDocuments.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/selectedImageWidget.dart';

import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/document_uploading.dart';
import '../../widgets/kyc_widgets/submitt_button.dart';

class StoreImages extends StatefulWidget {
  const StoreImages({Key? key}) : super(key: key);

  @override
  State<StoreImages> createState() => _StoreImagesState();
}

class _StoreImagesState extends State<StoreImages> {
  RxList<File> storeImages = RxList<File>();
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
                                text: store_images,
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
                          text: please_upload_three_image_of_the_shop,
                          style: TextStyles.textStyle123,
                        ),
                      ),
                      PreviouslyUploadedDocuments(
                        constraints: constraints,
                        imgfiles: kycManager
                            .kycStatusModel?.value?.data?.storeImages?.files
                            ?.map((e) => e.url ?? "")
                            .toList(),
                        maxHeight: maxHeight,
                        maxWidth: maxWidth,
                        docHeadingName: store,
                        documentName: kycManager
                                .kycStatusModel?.value?.data?.storeImages?.files
                                ?.map((e) => e.documentName ?? "")
                                .toList() ??
                            [],
                      ),
                      DocumentUploading(
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                        flag: true,
                        shouldPickFile: storeImages.isEmpty,
                        onFileSelection: (filesObjects) {
                          if (((storeImages.length) +
                                  (filesObjects?.length ?? 0)) <=
                              3) {
                            storeImages.addAll(filesObjects!);
                          } else {
                            Fluttertoast.showToast(
                                msg: selection_limit_for_3_are_accepted);
                          }
                        },
                      ),
                      SelectedImageWidget(
                        documentImages: storeImages,
                        onTapCrossIcons: (index) {
                          storeImages.removeAt(index);
                        },
                      ),
                      InkWell(
                        onTap: () async {
                          if (storeImages.isNotEmpty) {
                            Map<String, dynamic> storeImagesMap =
                                await kycManager.storeImages(
                              filePath: storeImages.map((e) => e.path).toList(),
                            );

                            Fluttertoast.showToast(msg: storeImagesMap['msg']);
                            if (storeImagesMap['error'] == false) {
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
              })));
    });
  }
}

Widget imageDialog(path) {
  return Icon(
    FontAwesome.doc,
  );
}
