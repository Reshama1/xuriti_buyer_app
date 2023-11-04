import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/util/common/string_constants.dart';
import '../../../logic/view_models/kyc_manager.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class BankPdfDocs extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;
  final bool? flag;
  final Function(List<File?>? files) onFileSelection;
  final bool shouldPickFile;

  //final String type;
  const BankPdfDocs(
      {required this.maxWidth,
      required this.maxHeight,
      this.flag,
      required this.onFileSelection,
      this.shouldPickFile = false});

  @override
  State<BankPdfDocs> createState() => _BankPdfDocsState();
}

class _BankPdfDocsState extends State<BankPdfDocs> {
  File? img;
  String imgpath = '';
  // const uploadfile(

  @override
  Widget build(BuildContext context) {
    double h1p = widget.maxHeight * 0.01;

    double w10p = widget.maxWidth * 0.1;
    double w1p = widget.maxWidth * 0.01;

    // late final img;
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

    return Padding(
      padding: EdgeInsets.only(left: w1p * 6, right: w1p * 6, top: h1p * 1),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () async {
                  File? fileSelection =
                      await getIt<KycManager>().getImage(context: context);
                  if (fileSelection != null) {
                    widget.onFileSelection([fileSelection]);
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
                    child: ImageFromAssetPath<Widget>(
                            assetPath: ImageAssetpathConstant.camera,
                            height: h1p * 4)
                        .imageWidget,
                  ),
                ),
              ),
              SizedBox(
                width: w1p * 4,
              ),
              InkWell(
                onTap: () async {
                  List<File?>? fileSelection =
                      await getIt<KycManager>().selectPdfFile(widget.flag);

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

                  widget.onFileSelection(fileSelection);
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
