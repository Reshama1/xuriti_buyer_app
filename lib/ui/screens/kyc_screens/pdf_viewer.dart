import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:xuriti/models/services/dio_service.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';

class PDFViewerFromURL extends StatefulWidget {
  final String pdfURL;
  const PDFViewerFromURL({
    Key? key,
    required this.pdfURL,
  }) : super(key: key);

  @override
  State<PDFViewerFromURL> createState() => _PDFViewerFromURLState();
}

class _PDFViewerFromURLState extends State<PDFViewerFromURL> {
  Rx<PDFDocument?> pdfDocument = RxNullable<PDFDocument?>().setNull();
  RxBool loadingPDF = false.obs;

  @override
  void initState() {
    loadingPDF.value = true;
    PDFDocument.fromURL(widget.pdfURL).then((value) {
      pdfDocument.value = value;
      loadingPDF.value = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: InkWell(
              onTap: () async {
                loadingPDF.value = true;
                String filePath =
                    await DioClient.downloadFileFromUrlAndStoreInLocalStorage(
                        fileURL: widget.pdfURL);
                loadingPDF.value = false;
                Share.shareXFiles([XFile(filePath)]);
              },
              child: Icon(
                Icons.share,
                color: Colors.black,
              ),
            ),
          ),
        ],
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.pdfURL.split("?").first.split("/").last,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Obx(
        () {
          return Center(
            child: loadingPDF.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : PDFViewer(
                    document: (pdfDocument.value)!,
                  ),
          );
        },
      ),
    );
  }
}
