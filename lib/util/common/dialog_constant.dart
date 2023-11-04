import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ui/theme/constants.dart';

void showDialogWithImage({required String imageURL}) {
  showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(Get.context!).size.width * 5,
                  height: MediaQuery.of(Get.context!).size.height * 0.5,
                  child: Image.network(
                    // ignore: unnecessary_string_interpolations
                    imageURL,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colours.white,
                          backgroundColor: Colours.almostBlack,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                right: 0.0,
                top: 0.0,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    child: Icon(
                      Icons.close,
                      size: 15.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      });
}
