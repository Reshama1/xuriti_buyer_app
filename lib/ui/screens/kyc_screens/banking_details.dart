import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/logic/view_models/kyc_manager.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/previouslyUploadedDocuments.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/selectedImageWidget.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/document_uploading.dart';
import '../../widgets/kyc_widgets/submitt_button.dart';

class BankingDetails extends StatefulWidget {
  const BankingDetails({Key? key}) : super(key: key);

  @override
  State<BankingDetails> createState() => _BankingDetailsState();
}

class _BankingDetailsState extends State<BankingDetails> {
  final ScrollController savedDocController = ScrollController();
  TextEditingController passwordController = TextEditingController();

  KycManager kycManager = Get.put(KycManager());
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());

  final passwordRegex = RegExp(r'^[a-zA-Z0-9]+(,[a-zA-Z0-9]+)*$');
  String? passwordError;
  RxList<File> bankDetailsImages = RxList<File>();

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
                                text: banking_details,
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
                          text: last_6_months_bank_statement,
                          style: TextStyles.textStyle123,
                        ),
                      ),
                      PreviouslyUploadedDocuments(
                        constraints: constraints,
                        imgfiles: kycManager
                            .kycStatusModel?.value?.data?.bankStatement?.files
                            ?.map((e) => e.url ?? "")
                            .toList(),
                        maxHeight: maxHeight,
                        maxWidth: maxWidth,
                        docHeadingName: banking,
                        documentName: kycManager.kycStatusModel?.value?.data
                                ?.bankStatement?.files
                                ?.map((e) => e.documentName ?? "")
                                .toList() ??
                            [],
                      ),
                      DocumentUploading(
                        onlyPdfFile: true,
                        hideCamera: true,
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                        shouldPickFile: bankDetailsImages.isEmpty,
                        onFileSelection: (filesObjects) {
                          if ((bankDetailsImages.length) == 0 &&
                              (filesObjects?.length ?? 0) <= 3) {
                            bankDetailsImages.value = filesObjects ?? [];
                          } else if (((bankDetailsImages.length) +
                                  (filesObjects?.length ?? 0)) <=
                              3) {
                            bankDetailsImages.addAll(filesObjects!);
                          } else {
                            Fluttertoast.showToast(
                                msg: selection_limit_for_3_are_accepted);
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 20),
                        child: Container(
                          // width: 300,
                          // height: 40,
                          child: TextBoxField(
                            controller: passwordController,
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return password_required;
                              } else if (!passwordRegex.hasMatch(value)) {
                                return password_must_contain_csv_values;
                              }
                              return null;
                            }),
                            onChanged: ((value) {
                              if (!passwordRegex.hasMatch(value)) {
                                passwordError =
                                    password_must_be_comma_separated;
                              } else {
                                passwordError = null;
                              }
                            }),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: w1p * 6, vertical: h1p * .5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fillColor: Colours.paleGrey,
                            hintText: password,
                            hintStyle: TextStyles.textStyle120,
                          ),
                        ),
                      ),
                      SelectedImageWidget(
                        documentImages: bankDetailsImages,
                        onTapCrossIcons: (index) {
                          bankDetailsImages.removeAt(index);
                        },
                      ),
                      InkWell(
                        onTap: () async {
                          context.showLoader();
                          Map<String, dynamic> bankingDetails =
                              await kycManager.storeBankDetails(
                                  bankStatementImage: bankDetailsImages
                                      .map((e) => e.path)
                                      .toList(),
                                  password: passwordController.text);
                          context.hideLoader();
                          Fluttertoast.showToast(msg: bankingDetails['msg']);
                          if (bankingDetails['error'] == false) {
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
