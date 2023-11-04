import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:xuriti/ui/screens/kyc_screens/pdf_viewer.dart';
import '../../../util/common/dialog_constant.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class PreviouslyUploadedDocuments extends StatefulWidget {
  final List<String>? imgfiles;
  final BoxConstraints constraints;
  final double maxWidth;
  final double maxHeight;
  final String docHeadingName;
  final List<String>? documentName;

  //final String type;
  const PreviouslyUploadedDocuments({
    required this.imgfiles,
    required this.constraints,
    required this.maxWidth,
    required this.maxHeight,
    required this.docHeadingName,
    required this.documentName,
  });

  @override
  State<PreviouslyUploadedDocuments> createState() =>
      _PreviouslyUploadedDocumentsState();
}

class _PreviouslyUploadedDocumentsState
    extends State<PreviouslyUploadedDocuments> {
  File? img;
  String imgpath = '';
  // const uploadfile(
  @override
  Widget build(BuildContext context) {
    final ScrollController savedDocController = ScrollController();

    double maxWidth = widget.constraints.maxWidth;

    double w1p = widget.maxWidth * 0.01;

    // late final img;

    return Padding(
      padding: EdgeInsets.only(
          left: w1p * 6, right: w1p * 6, bottom: w1p * 6, top: w1p * 3
          // top: h1p * 1.5,
          // bottom: h1p * 3
          ),
      child: (widget.imgfiles?.isEmpty ?? true)
          ? SizedBox()
          : Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstantText(
                    text: uploaded_documents,
                    style: TextStyles.leadingText,
                  ),
                  SizedBox(
                    height: w1p,
                  ),
                  SizedBox(
                    width: maxWidth,
                    height: 65,
                    child: Scrollbar(
                      controller: savedDocController,
                      thumbVisibility: true,
                      child: ListView.separated(
                        controller: savedDocController,
                        separatorBuilder: (context, index) => SizedBox(
                          width: 8,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.imgfiles?.length ?? 0,
                        itemBuilder: (context, index) {
                          final String doc = widget.imgfiles?[index] ?? "";
                          String filePath = doc
                              .split("?")
                              .first
                              .split("/")
                              .last
                              .split(".")
                              .last;
                          if (filePath != 'pdf') {
                            print('object++++====');
                            return GestureDetector(
                                onTap: () {
                                  showDialogWithImage(imageURL: doc);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: w1p * 1,
                                    // right: w1p * 6
                                  ),
                                  child: SizedBox(
                                    width: 70,
                                    child: Column(
                                      children: [
                                        imageDialog(doc),
                                        ConstantText(
                                          text:
                                              widget.documentName?[index] ?? "",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // ConstantText(
                                        //   text: doc.split("/").last,
                                        //   overflow: TextOverflow.ellipsis,
                                        // )
                                      ],
                                    ),
                                  ),
                                ));
                          } else {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PDFViewerFromURL(
                                        pdfURL: widget.imgfiles?[index] ?? "",
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: w1p * 1,
                                    // right: w1p * 6
                                  ),
                                  child: SizedBox(
                                    width: 70,
                                    child: Column(
                                      children: [
                                        imageDialog(doc),
                                        ConstantText(
                                          text:
                                              widget.documentName?[index] ?? "",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // ConstantText(
                                        //   text: doc.split("/").last,
                                        //   overflow: TextOverflow.ellipsis,
                                        // )
                                      ],
                                    ),
                                  ),
                                ));
                          }
                        },
                      ),
                    ),
                    //_checkController();
                  ),
                ],
              ),
            ),
    );
  }
}

Widget imageDialog(path) {
  return Icon(
    FontAwesome.doc,
    size: 45,
  );
}
