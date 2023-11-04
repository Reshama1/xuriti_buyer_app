import 'package:flutter/material.dart';

import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../theme/constants.dart';

class AppbarWidget extends StatefulWidget {
  AppbarWidget({Key? key, askey}) : super(key: key);

  @override
  State<AppbarWidget> createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  GlobalKey<ScaffoldState>? askey;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;

      double w10p = maxWidth * 0.1;
      return Container(
        color: Colours.black,
        height: maxHeight,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ImageFromAssetPath<Widget>(
                assetPath: ImageAssetpathConstant.xuritiLogo,
                width: w10p * 1.9,
              ).imageWidget,
              // InkWell
              //   (
              //   onTap: (){
              //  widget.askey!.currentState!.openEndDrawer();
              //   },
              //     child: ImageFromAssetPath<Widget>(assetPath: "assets/images/menubutton.svg"))
            ],
          ),
        ),
      );
    });
  }
}
