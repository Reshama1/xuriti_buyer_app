import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file_safe_plus/open_file_safe_plus.dart';

import 'package:path_provider/path_provider.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/util/common/dialog_constant.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../Model/AdhaarCapture.dart';
import '../../../logic/view_models/kyc_manager.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';

class AadhaarCard extends StatefulWidget {
  const AadhaarCard();

  @override
  State<AadhaarCard> createState() => _AadhaarCardState();
}

class _AadhaarCardState extends State<AadhaarCard> {
  TextEditingController aadhaarController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController reCaptchaController = TextEditingController();

  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  KycManager kycManager = Get.put(KycManager());
  Rx<AdhaarCapture?> aadharCapturedData =
      RxNullable<AdhaarCapture?>().setNull();

  Rx<File?> frontImage = RxNullable<File?>().setNull();
  Rx<File?> backImage = RxNullable<File?>().setNull();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      kycManager.getCaptcha();

      kycManager.getKycStatusDetails();
    });
    kycManager.kycStatusModel?.listen((p0) {
      aadhaarController.text = p0?.data?.aadhar?.number ?? "";
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
            body: ProgressHUD(
              child: Builder(
                builder: (context) {
                  return Container(
                    width: maxWidth,
                    height: maxHeight,
                    decoration: const BoxDecoration(
                        color: Colours.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                                    text: aadhaar_details,
                                    style: TextStyles.leadingText,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: h1p * 1,
                          ),

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 8,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                XFile? fileResult =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                String? path = fileResult !=
                                                        null
                                                    ? fileResult.path.isNotEmpty
                                                        ? fileResult.path
                                                        : ""
                                                    : "";

                                                if (path
                                                        .split("/")
                                                        .last
                                                        .split(".")
                                                        .last ==
                                                    "pdf") {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          onlyImgFileFormatAllowed);
                                                  return;
                                                }

                                                final File selectFront =
                                                    File(path);

                                                this.frontImage.value =
                                                    selectFront;
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: h1p * 1,
                                                    top: h1p * 5),
                                                child: Container(
                                                  height: h1p * 5,
                                                  width: w1p * 10,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: Colours.disabledText,
                                                  ),
                                                  child: Center(
                                                    child: ImageFromAssetPath<
                                                        Widget>(
                                                      assetPath:
                                                          ImageAssetpathConstant
                                                              .camera,
                                                      height: 25,
                                                    ).imageWidget,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                FilePickerResult? fileResult =
                                                    (await FilePicker.platform
                                                        .pickFiles(
                                                            allowMultiple:
                                                                false));
                                                //if the front image does not exist and we dont pick any image then we show message
                                                //else if we pick a image the image is saved
                                                if (frontImage.value == null &&
                                                    (fileResult == null ||
                                                        fileResult
                                                            .files.isEmpty)) {
                                                  Fluttertoast.showToast(
                                                      msg: please_select_file);
                                                } else if (fileResult
                                                        ?.files.first.path
                                                        ?.split("/")
                                                        .last
                                                        .split(".")
                                                        .last ==
                                                    "pdf") {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          onlyImgFileFormatAllowed);
                                                  return;
                                                } else if (fileResult != null &&
                                                    fileResult
                                                        .files.isNotEmpty) {
                                                  this.frontImage.value = File(
                                                      fileResult.files.first
                                                              .path ??
                                                          "");
                                                }
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: w1p * 6,
                                                        right: w1p * 6,
                                                        top: h1p * 5),
                                                    child: Container(
                                                        height: h1p * 6,
                                                        width: w10p * 3,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color: Colours
                                                              .disabledText,
                                                        ),
                                                        child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        w1p * 2,
                                                                    vertical:
                                                                        h1p *
                                                                            2),
                                                            child: ConstantText(
                                                              text:
                                                                  upload_front_image,
                                                              style: TextStyles
                                                                  .textStyle121,
                                                            ))),
                                                  ),
                                                  Obx(() {
                                                    return this
                                                                .frontImage
                                                                .value !=
                                                            null
                                                        ? showImage(
                                                            this
                                                                .frontImage
                                                                .value,
                                                            w10p * 4, () {
                                                            frontImage.value =
                                                                null;
                                                          })
                                                        : SizedBox();
                                                  }),
                                                ],
                                              ),
                                            ),
                                          ]),
                                      InkWell(
                                          onTap: () async {},
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    XFile? fileResult =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .camera);
                                                    String? path = fileResult !=
                                                            null
                                                        ? fileResult
                                                                .path.isNotEmpty
                                                            ? fileResult.path
                                                            : ""
                                                        : "";
                                                    if (path
                                                            .split("/")
                                                            .last
                                                            .split(".")
                                                            .last ==
                                                        "pdf") {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              onlyImgFileFormatAllowed);
                                                      return;
                                                    }
                                                    final File selectBack =
                                                        File(path);

                                                    this.backImage.value =
                                                        selectBack;
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: h1p * 1,
                                                        top: h1p * 5),
                                                    child: Container(
                                                      height: h1p * 5,
                                                      width: w1p * 10,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: Colours
                                                            .disabledText,
                                                      ),
                                                      child: Center(
                                                        child:
                                                            ImageFromAssetPath<
                                                                Widget>(
                                                          assetPath:
                                                              ImageAssetpathConstant
                                                                  .camera,
                                                          height: 25,
                                                        ).imageWidget,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: w1p * 6,
                                                          right: w1p * 6,
                                                          top: h1p * 5),
                                                      child: Container(
                                                        height: h1p * 6,
                                                        width: w10p * 3,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color: Colours
                                                              .disabledText,
                                                        ),
                                                        child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        w1p * 2,
                                                                    vertical:
                                                                        h1p *
                                                                            2),
                                                            child: Row(
                                                                children: [
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      FilePickerResult?
                                                                          fileResult =
                                                                          (await FilePicker
                                                                              .platform
                                                                              .pickFiles(allowMultiple: false));

                                                                      if (backImage.value ==
                                                                              null &&
                                                                          (fileResult == null ||
                                                                              fileResult
                                                                                  .files.isEmpty)) {
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                please_select_file);
                                                                      } else if (fileResult
                                                                              ?.files
                                                                              .first
                                                                              .path
                                                                              ?.split(
                                                                                  "/")
                                                                              .last
                                                                              .split(
                                                                                  ".")
                                                                              .last ==
                                                                          "pdf") {
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                onlyImgFileFormatAllowed);
                                                                        return;
                                                                      } else if (fileResult !=
                                                                              null &&
                                                                          fileResult
                                                                              .files
                                                                              .isNotEmpty) {
                                                                        String?
                                                                            path =
                                                                            fileResult.files[0].path ??
                                                                                "";

                                                                        final File
                                                                            selectBack =
                                                                            File(path);

                                                                        this.backImage.value =
                                                                            selectBack;
                                                                      }
                                                                    },
                                                                    child:
                                                                        ConstantText(
                                                                      text:
                                                                          upload_back_image,
                                                                      style: TextStyles
                                                                          .textStyle121,
                                                                    ),
                                                                  ),
                                                                  // ),
                                                                ])),
                                                      ),
                                                    ),
                                                    Obx(() {
                                                      return this
                                                                  .backImage
                                                                  .value !=
                                                              null
                                                          ? showImage(
                                                              this
                                                                  .backImage
                                                                  .value,
                                                              w10p * 4, () {
                                                              backImage.value =
                                                                  null;
                                                            })
                                                          : SizedBox();
                                                    }),
                                                  ],
                                                ),
                                              ])),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: w1p * 3,
                                      right: w1p * 6,
                                    ),
                                    child: SizedBox(
                                      width: maxWidth,
                                      height: 50,
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          width: 120,
                                        ),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: kycManager
                                                .kycStatusModel
                                                ?.value
                                                ?.data
                                                ?.aadhar
                                                ?.files
                                                ?.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          String doc = kycManager
                                                  .kycStatusModel
                                                  ?.value
                                                  ?.data
                                                  ?.aadhar
                                                  ?.files?[index]
                                                  .url ??
                                              "";

                                          List doc1 = doc.split("?");
                                          List doc2 = doc1[0].split(".");

                                          final fp = doc2.last;
                                          String filepath = fp.toString();

                                          Future<File?> downloadFile(
                                              String url, String name) async {
                                            final appStorage =
                                                await getApplicationDocumentsDirectory();
                                            final file = File(
                                                '${appStorage.path}/$name');
                                            try {
                                              final response = await Dio().get(
                                                  url,
                                                  options: Options(
                                                      responseType:
                                                          ResponseType.bytes,
                                                      followRedirects: false,
                                                      receiveTimeout: 0));
                                              final raf = file.openSync(
                                                  mode: FileMode.write);
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
                                            final file = await downloadFile(
                                                url, filename!);
                                            if (file == null) return;
                                            print(
                                                'path for pdf file++++++++++++ ${file.path}');
                                            OpenFilePlus.open(file.path);
                                          }

                                          // filepath != 'pdf'
                                          //     ?
                                          if (filepath != 'pdf') {
                                            print('object++++====');
                                            return GestureDetector(
                                                onTap: () {
                                                  showDialogWithImage(
                                                      imageURL: doc);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: w1p * 6,
                                                      right: w1p * 6),
                                                  child: imageDialog(doc),
                                                ));
                                          } else {
                                            return GestureDetector(
                                                onTap: () {
                                                  openFile(
                                                      url: doc,
                                                      filename:
                                                          'adhaarcard.pdf');
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: w1p * 6,
                                                    // right: w1p * 6,
                                                  ),
                                                  child: imageDialog(doc),
                                                ));
                                          }
                                        },
                                      ),

                                      //_checkController();
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: w1p * 6,
                                            right: w1p * 6,
                                            top: h1p * 2,
                                            bottom: h1p),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: TextButton(
                                            onPressed: () async {
                                              if (frontImage.value == null ||
                                                  backImage.value == null) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        front_and_back_image_mandatory);

                                                return;
                                              }

                                              print(
                                                  "aadharfront--${frontImage} backImg --- ${backImage}");
                                              context.showLoader();
                                              dynamic aadhaar = await kycManager
                                                  .adhaarDetails(
                                                companyListViewModel
                                                        .selectedCompany
                                                        .value
                                                        ?.companyId ??
                                                    "",
                                                frontImage.value!,
                                                backImage.value!,
                                              );
                                              context.hideLoader();

                                              aadharCapturedData.value =
                                                  AdhaarCapture.fromJson(
                                                      aadhaar);
                                            },
                                            child: ConstantText(
                                              text: captured,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                Color.fromARGB(
                                                    255, 253, 153, 33),
                                              ),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  side: BorderSide(
                                                    width: 1,
                                                    color: Color.fromARGB(
                                                      255,
                                                      150,
                                                      146,
                                                      146,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: maxWidth * 0.1,
                                      ),
                                      Obx(() =>
                                          aadharCapturedData.value?.status ==
                                                  true
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                    left: w1p * 0.03,
                                                    right: w1p * 1,
                                                    top: h1p * 1,
                                                  ),
                                                  child: adhaarDetails(
                                                    aadharCapturedData
                                                            .value?.data.name ??
                                                        "",
                                                    aadharCapturedData.value
                                                            ?.data.address ??
                                                        "",
                                                    aadharCapturedData
                                                            .value?.data.dob ??
                                                        "",
                                                    aadharCapturedData.value
                                                            ?.data.gender ??
                                                        "",
                                                  ),
                                                )
                                              : SizedBox()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: maxHeight * 0.03),

                          Padding(
                            padding: EdgeInsets.only(left: 42.0),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: ConstantText(
                                text: enter_UID_number,
                                // textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: w1p * 6, right: w1p * 6, top: h1p * 5),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: maxWidth * 0.8,
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
                                  controller: aadhaarController,
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (aadharNumber) {
                                    if ((aadharNumber?.length ?? 0) != 12) {
                                      return please_enter_valid_aadhar_number;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    value = aadhaarController.text;
                                  },
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: w1p * 6, vertical: h1p * .5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colours.paleGrey,
                                  hintText: enter_aadhar_number,
                                  hintStyle: TextStyles.textStyle120,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: maxHeight * 0.03,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: w1p * 6,
                              right: w1p * 6,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Obx(() {
                                  return (kycManager.captchaDataModel.value
                                              ?.data?.isNotEmpty ??
                                          false)
                                      ? Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 5, color: Colors.grey),
                                          ),
                                          width: maxWidth * 0.3,
                                          height: maxHeight * 0.07,
                                          child: Image(
                                              image: Image.memory(Base64Decoder()
                                                      .convert((kycManager
                                                                  .captchaDataModel
                                                                  .value
                                                                  ?.data ??
                                                              "")
                                                          .split(",")
                                                          .last))
                                                  .image),
                                        )
                                      : SizedBox();
                                }),
                                InkWell(
                                  onTap: () async {
                                    context.showLoader();

                                    await kycManager.getCaptcha();
                                    context.hideLoader();
                                  },
                                  child: Icon(
                                    Icons.refresh,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: maxWidth * 0.4,
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
                                      controller: reCaptchaController,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: w1p * 6,
                                          vertical: h1p * .5),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      fillColor: Colours.paleGrey,
                                      hintText: enter_captcha,
                                      hintStyle: TextStyles.textStyle120,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: h1p * 5),
                            child: Container(
                              height: maxHeight * 0.06,
                              width: maxWidth * w1p * 0.2,
                              child: TextButton(
                                onPressed: () async {
                                  // context.showLoader();
                                  context.showLoader();
                                  Map<String, dynamic> aadharOtp =
                                      await kycManager.generateAdharOtp(
                                          aadhaarController.text,
                                          reCaptchaController.text,
                                          captchaSessionId: kycManager
                                                  .captchaDataModel
                                                  .value
                                                  ?.sessionId ??
                                              "");
                                  context.hideLoader();
                                  // AdhaarController.adhaarDetails(companyId, , back)
                                  Fluttertoast.showToast(msg: aadharOtp['msg']);
                                },
                                child: ConstantText(
                                  text: generate_OTP,
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 253, 153, 33),
                                    ),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      side: BorderSide(
                                        width: 1,
                                        color:
                                            Color.fromARGB(255, 150, 146, 146),
                                      ),
                                    ))),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 7,
                            // height: maxHeight * 0.03,
                          ),
                          //generate otp

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: w1p * 10,
                                    right: w1p * 3,
                                    top: h1p * 5),
                                // padding: EdgeInsets.only(
                                //     left: w1p * 0.03, right: w1p * 2, top: h1p * 1),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: maxWidth * 0.4,
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
                                      controller: otpController,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: w1p * 6,
                                          vertical: h1p * .01),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      fillColor: Colours.paleGrey,
                                      hintText: enter_otp,
                                      hintStyle: TextStyles.textStyle120,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: w1p * 9, top: h1p * 5),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        height: maxHeight * 0.06,
                                        width: maxWidth * 0.35,
                                        child: TextButton(
                                          onPressed: () async {
                                            context.showLoader();
                                            Map<String, dynamic>
                                                verifyAadharOtp =
                                                await kycManager.verifyAdharOtp(
                                                    otpController.text,
                                                    captchaSessionId: kycManager
                                                            .captchaDataModel
                                                            .value
                                                            ?.sessionId ??
                                                        "");
                                            context.hideLoader();

                                            Fluttertoast.showToast(
                                              msg: verifyAadharOtp['msg'],
                                            );
                                            if (verifyAadharOtp['error'] ==
                                                false) {
                                              Navigator.pop(
                                                context,
                                                false,
                                              );
                                            }
                                          },
                                          child: ConstantText(
                                            text: verify_OTP,
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                255,
                                                255,
                                                255,
                                                255,
                                              ),
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                              Color.fromARGB(
                                                255,
                                                253,
                                                153,
                                                33,
                                              ),
                                            ),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                side: BorderSide(
                                                  width: 1,
                                                  color: Color.fromARGB(
                                                    255,
                                                    150,
                                                    146,
                                                    146,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: h1p * 4,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: w1p * 9,
                                  right: w1p * 3,
                                  top: h1p * 2,
                                  bottom: h1p * 3),
                              child: ConstantText(text: verification_status),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget adhaarDetails(
          String name, String address, String dob, String gender) =>
      Padding(
        padding: const EdgeInsets.only(right: 50.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstantText(
                text: '${nameTxt} $name\n',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: 200,
                child: ConstantText(
                  text: '${address}: $address\n',
                  maxLines: 4,
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  style:
                      TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis),
                ),
              ),
              ConstantText(
                text: '${dobTxt}: $dob\n',
                style: TextStyle(fontSize: 14),
              ),
              ConstantText(
                text: '${gender}: $gender',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            ],
          ),
        ),
      );

  Widget showImage(File? file, width, Function()? onTapCrossIcons) => Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 1, right: 1),
      child: Stack(
        children: [
          SizedBox(
            width: width,
            child: Padding(
              padding: EdgeInsets.only(top: 5.0, right: 5.0),
              child: Column(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1),
                      child: file != null
                          ? Image.file(
                              file,
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width * 0.38,
                              height: 200,
                            )
                          : SizedBox(),
                    ),
                  ),
                  ConstantText(
                    text: file?.path.split('/').last ?? '',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            child: InkWell(
              onTap: () {
                if (onTapCrossIcons != null) {
                  onTapCrossIcons();
                }
              },
              child: Container(
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    color: Colours.paleRed, shape: BoxShape.circle),
                child: Icon(
                  Icons.clear,
                  color: Colours.white,
                  size: 15.0,
                ),
              ),
            ),
          ),
        ],
      ));
}

Widget imageDialog(path) {
  return Icon(
    FontAwesome.doc,
  );
}
