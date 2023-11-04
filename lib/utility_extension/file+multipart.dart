import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart' as httpParser;

extension multipathData on File {
  Future<dio.MultipartFile?> getMultipartDatafromFile() async {
    Uint8List fileData = await readAsBytes();
    try {
      return (dio.MultipartFile.fromBytes(
        fileData,
        filename:
            '${DateTime.now().second}.${this.path.split("/").last.split(".").last}',
        contentType: httpParser.MediaType(
            this.path.split("/").last.split(".").last.toLowerCase() == "pdf"
                ? "application"
                : "image",
            "${this.path.split("/").last.split(".").last}"),
      ));
    } catch (e) {
      log("Error occurred");
      return null;
    }
  }
}
