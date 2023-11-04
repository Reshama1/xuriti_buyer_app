import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../logic/view_models/transaction_manager.dart';
import '../../../models/helper/service_locator.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';

class BillDetailsWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final String heading;

  BillDetailsWidget(
      {required this.maxWidth, required this.maxHeight, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ProgressHUD(child: Builder(builder: (context) {
      return Container(
        width: maxWidth,
        // width: maxWidth,
        height: 200,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: GestureDetector(
              onTap: () async {
                // progress!.show();
                context.showLoader();
                await getIt<TransactionManager>().openFile(
                    url:
                        "https://s29.q4cdn.com/816090369/files/doc_downloads/test.pdf");
                //progress.dismiss();
                context.hideLoader();
                Fluttertoast.showToast(msg: opening_invoice_file);
              },
              child: ImageFromAssetPath<Widget>(
                      assetPath: ImageAssetpathConstant.invoiceButton)
                  .imageWidget),
        ),
      );
    })));
  }
}
//
