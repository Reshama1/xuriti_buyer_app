import 'package:flutter/material.dart';

import '../new modules/common_widget.dart';
import '../new modules/image_assetpath_constants.dart';

extension LoaderContext on BuildContext {
  static OverlayEntry? _loaderOverlayEntry;

  showLoader_2() {
    _loaderOverlayEntry = OverlayEntry(builder: (context) {
      return getLoaderWidget_2();
    });

    Overlay.of(this).insert(_loaderOverlayEntry!);
  }

  Widget getLoaderWidget_2() {
    return Center(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ImageFromAssetPath<Widget>(
            assetPath: ImageAssetpathConstant.loader,
            height: 70,
            // "assets/images/Spinner-3-unscreen.gif",
            //color: Colors.orange,
          ).imageWidget,
        ),
        // your loader widget code goes here
      ),
    );
  }

  void hideLoader_2() {
    if (_loaderOverlayEntry != null) {
      _loaderOverlayEntry!.remove();
      _loaderOverlayEntry = null;
    }
  }
}
