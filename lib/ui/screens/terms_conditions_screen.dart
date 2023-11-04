import 'package:flutter/material.dart';

import '../../new modules/common_widget.dart';
import '../../new modules/image_assetpath_constants.dart';
import '../theme/constants.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;

      double w1p = maxWidth * 0.01;
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colours.black,
          automaticallyImplyLeading: false,
          toolbarHeight: h1p * 8,
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: h1p * 3, right: w1p * 3),
                child: ImageFromAssetPath<Widget>(
                  assetPath: ImageAssetpathConstant.xuriti1,
                ).imageWidget,
              ),
            ],
          ),
        ),
        body: Container(
          // width: maxWidth,
          decoration: const BoxDecoration(
              color: Colours.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26),
                topRight: Radius.circular(26),
              )),
          child: ListView(children: []),
        ),
      );
    });
  }
}
