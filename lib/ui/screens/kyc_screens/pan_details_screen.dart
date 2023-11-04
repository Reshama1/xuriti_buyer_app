import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:open_file_safe_plus/open_file_safe_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/selectedImageWidget.dart';
import 'package:xuriti/util/common/string_constants.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../logic/view_models/kyc_manager.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/dialog_constant.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/document_uploading.dart';
import '../../widgets/kyc_widgets/submitt_button.dart';

class PanDetails extends StatefulWidget {
  const PanDetails({Key? key}) : super(key: key);

  @override
  State<PanDetails> createState() => _PanDetailsState();
}

class _PanDetailsState extends State<PanDetails> {
  TextEditingController panController = TextEditingController();
  CompanyListViewModel companyListViewModel = CompanyListViewModel();
  KycManager kycManager = Get.put(KycManager());

  RxList<File?> panDetailsImages = RxList<File>();

  final panNumberRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
  final _formKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      kycManager.getKycStatusDetails();
    });

    kycManager.kycStatusModel?.listen((p0) {
      panController.text = p0?.data?.pan?.number ?? "";
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
                                text: pan_details,
                                style: TextStyles.leadingText,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: w1p * 6, right: w1p * 6, top: h1p * 3),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(
                                  0x26000000,
                                ),
                                offset: Offset(
                                  0,
                                  1,
                                ),
                                blurRadius: 1,
                                spreadRadius: 0,
                              )
                            ],
                            color: Colours.paleGrey,
                          ),
                          child: TextBoxField(
                            maxLength: 10,
                            key: _formKey,
                            textCapitalization: TextCapitalization.characters,
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                              FilteringTextInputFormatter.allow(
                                RegExp(
                                  "[0-9a-zA-Z]",
                                ),
                              ),
                            ],
                            controller: panController,
                            autoValidateMode: AutovalidateMode.always,
                            validator: (panText) {
                              if ((panText?.length ?? 0) > 0 &&
                                  !panNumberRegex.hasMatch(panText ?? "")) {
                                return please_enter_valid_pan_no;
                              }
                              return null;
                            },
                            counterText: '',
                            errorStyle: TextStyle(
                              color: Colors.red,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: w1p * 6, vertical: h1p * .5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fillColor: Colours.paleGrey,
                            hintText: pan_number,
                            hintStyle: TextStyles.textStyle120,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //     left: w1p * 6,
                      //     right: w1p * 6,
                      //   ),
                      //   child: isPanNoCorrect
                      //       ? Container()
                      //       : ConstantText(
                      //           text: 'Please enter valid PAN No',
                      //           style: TextStyle(color: Colors.redAccent)),
                      // ),
                      SizedBox(
                        height: h1p * 3,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: w1p * 6,
                          right: w1p * 6,
                          // top: h1p * 1.5,
                          // bottom: h1p * 3
                        ),
                        child: SizedBox(
                          width: maxWidth,
                          height: 50,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              width: 30,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: kycManager.kycStatusModel?.value?.data
                                    ?.pan?.files?.length ??
                                0,
                            itemBuilder: (context, index) {
                              String doc = kycManager.kycStatusModel?.value
                                      ?.data?.pan?.files?[index].url ??
                                  "";

                              print('the whole filepath  >>>>>>>>$doc');

                              List doc1 = doc.split("?");
                              List doc2 = doc1[0].split(".");
                              List fpath = doc2;
                              print('doc1.>>>>>>>>$doc1');

                              print('fpath.>>>>>>>>$fpath');
                              final fp = doc2.last;
                              String filepath = fp.toString();
                              print('filepath.>>>>>>>>$filepath');

                              Future<File?> downloadFile(
                                  String url, String name) async {
                                final appStorage =
                                    await getApplicationDocumentsDirectory();
                                final file = File('${appStorage.path}/$name');
                                try {
                                  final response = await Dio().get(url,
                                      options: Options(
                                          responseType: ResponseType.bytes,
                                          followRedirects: false,
                                          receiveTimeout: 0));
                                  final raf =
                                      file.openSync(mode: FileMode.write);
                                  raf.writeFromSync(response.data);
                                  await raf.close();
                                  return file;
                                } catch (e) {
                                  return null;
                                }
                              }

                              Future openFile(
                                  {required String url,
                                  String? filename}) async {
                                final file = await downloadFile(url, filename!);
                                if (file == null) return;
                                print(
                                    'path for pdf file++++++++++++ ${file.path}');
                                OpenFilePlus.open(file.path);
                              }

                              if (filepath != 'pdf') {
                                print('object++++====');
                                return GestureDetector(
                                    onTap: () {
                                      showDialogWithImage(imageURL: doc);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: w1p * 6, right: w1p * 6),
                                      child: imageDialog(doc),
                                    ));
                              } else {
                                return GestureDetector(
                                    onTap: () {
                                      openFile(
                                          url: doc, filename: 'pancard.pdf');
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ConstantText(
                                            text: uploaded_documents,
                                            style: TextStyles.leadingText,
                                          ),
                                          SizedBox(
                                            height: w1p,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: w1p * 6,
                                              // right: w1p * 6,
                                            ),
                                            child: imageDialog(doc),
                                          ),
                                        ],
                                      ),
                                    ));
                              }
                            },
                          ),
                        ),
                      ),
                      DocumentUploading(
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                        shouldPickFile: panDetailsImages.isEmpty,
                        onFileSelection: (files) {
                          if ((files?.length ?? 0) != 0) {
                            panDetailsImages.addAll(files!);
                          }
                        },
                      ),
                      SelectedImageWidget(
                        documentImages: panDetailsImages,
                        onTapCrossIcons: (index) {
                          panDetailsImages.removeAt(index);
                        },
                      ),
                      InkWell(
                          onTap: () async {
                            if (panDetailsImages.isEmpty) {
                              Fluttertoast.showToast(msg: please_select_image);
                              return;
                            }
                            if (!_formKey.currentState!.validate()) {
                              Fluttertoast.showToast(
                                  msg: please_enter_valid_PIN);
                              return;
                            }
                            context.showLoader();
                            Map<String, dynamic> panDetails = await kycManager
                                .storePanCardDetails(panController.text,
                                    filePath:
                                        panDetailsImages.first?.path ?? "");

                            context.hideLoader();
                            Fluttertoast.showToast(msg: panDetails['msg']);
                            if (panDetails['error'] == false) {
                              kycManager.getKycStatusDetails();
                              Navigator.pop(context, panDetails['error']);
                            }
                          },
                          child: Submitbutton(
                            maxWidth: maxWidth,
                            maxHeight: maxHeight,
                            isKyc: true,
                            content: save_and_continue,
                          ))
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

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
