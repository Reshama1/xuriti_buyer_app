import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/util/common/string_constants.dart';
import '../../../logic/view_models/kyc_manager.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class DocumentUploading extends StatefulWidget {
  final bool? onlyPdfFile;
  final double maxWidth;
  final double maxHeight;
  final bool? flag;
  final bool? hideCamera;
  final Function(List<File>? files) onFileSelection;
  final bool shouldPickFile;
  //final String type;
  const DocumentUploading({
    required this.maxWidth,
    required this.maxHeight,
    this.flag,
    required this.onFileSelection,
    this.shouldPickFile = false,
    this.hideCamera,
    this.onlyPdfFile,
  });

  @override
  State<DocumentUploading> createState() => _DocumentUploadingState();
}

class _DocumentUploadingState extends State<DocumentUploading> {
  File? img;
  String imgpath = '';
  // const uploadfile(
  bool isFilesTypeCorrect(List<File?>? fileSelection) {
    List<String> allowedTypes = ['pdf', 'png', 'jpeg', 'xlsx', 'jpg'];
    for (dynamic file in fileSelection!) {
      String str1 = file?.path?.split('?').first;
      String str2 = str1.split('.').last;
      if (!allowedTypes.contains(str2)) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double h1p = widget.maxHeight * 0.01;
    double w10p = widget.maxWidth * 0.1;
    double w1p = widget.maxWidth * 0.01;

    // late final img;

    return Padding(
      padding: EdgeInsets.only(left: w1p * 6, right: w1p * 6, top: h1p * 1),
      child: Column(
        children: [
          Row(
            children: [
              widget.hideCamera == true
                  ? SizedBox()
                  : InkWell(
                      onTap: () async {
                        // PermissionStatus cameraPermission =
                        //     await Permission.camera.request();
                        // if (!(cameraPermission == PermissionStatus.granted ||
                        //     cameraPermission == PermissionStatus.limited)) {
                        //   Fluttertoast.showToast(
                        //       msg: "Please provide permssion for library");
                        //   return;
                        // }

                        File? fileSelection = await getIt<KycManager>()
                            .getImage(context: context);
                        if (fileSelection != null) {
                          widget.onFileSelection([fileSelection].toList());
                        }
                      },
                      child: Container(
                        height: h1p * 6,
                        width: w1p * 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colours.disabledText,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                              "assets/images/kycImages/camera.svg",
                              height: h1p * 4),
                        ),
                      ),
                    ),
              widget.hideCamera == true
                  ? SizedBox()
                  : SizedBox(
                      width: w1p * 4,
                    ),
              InkWell(
                onTap: () async {
                  List<File>? fileSelection = await getIt<KycManager>()
                      .selectFile(widget.flag,
                          widget.onlyPdfFile == true ? ["pdf"] : null);

                  print('=====>File uploaded====>${fileSelection}');

                  if (fileSelection?.isEmpty == true || fileSelection == null) {
                    if (widget.shouldPickFile) {
                      Fluttertoast.showToast(msg: please_select_file);
                    }
                    return;
                  } else if (!isFilesTypeCorrect(fileSelection)) {
                    Fluttertoast.showToast(msg: please_select_file_type_PDF);
                    return;
                  }

                  setState(() {
                    img = fileSelection[0];
                    imgpath = '${img?.path}'; //error
                  });
                  if (img?.path.split("/").last.split(".").last != "pdf" &&
                      widget.onlyPdfFile == true) {
                    Fluttertoast.showToast(msg: only_pdf_file_allowed);
                    widget.onFileSelection([]);
                    return;
                  }
                  widget.onFileSelection(fileSelection.toList());
                },
                child: Container(
                  height: h1p * 6,
                  width: w10p * 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colours.disabledText,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: w1p * 5, vertical: h1p * 2),
                    child: const ConstantText(
                      text: uploaded_documents,
                      style: TextStyles.textStyle121,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // imgpath.isNotEmpty ? showImage() : const SizedBox()
        ],
      ),
    );
  }
}
