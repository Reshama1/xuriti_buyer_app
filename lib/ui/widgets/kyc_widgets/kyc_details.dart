import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../theme/constants.dart';

class KycDetails extends StatelessWidget {
  final String title;
  final double maxWidth;
  final double maxHeight;
  final String? subtitle;
  final bool? kycStatus;
  final bool? isMandatory;

  KycDetails(
      {required this.title,
      required this.maxWidth,
      required this.maxHeight,
      this.subtitle,
      this.kycStatus,
      this.isMandatory});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double h1p = maxHeight * 0.01;

      double w1p = maxWidth * 0.01;
      return Padding(
        padding: EdgeInsets.only(left: w1p * 3, top: h1p * 2, right: w1p * 3),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x1f000000),
                    offset: Offset(0, 3),
                    blurRadius: 1,
                    spreadRadius: 0)
              ],
              color: Colours.white),
          margin: EdgeInsets.only(top: 12, bottom: 12),
          child: Container(
            padding:
                EdgeInsets.only(left: 20.0, top: 0.0, bottom: 0.0, right: 20.0),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: kycStatus ?? false
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                    ),
              title: Text.rich(
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textScaleFactor: 1,
                  TextSpan(children: [
                    TextSpan(
                      text: title.tr(),
                      style: TextStyles.textStyle44,
                    ),
                    TextSpan(
                      text: (isMandatory ?? false) ? "* " : "",
                      style: TextStyles.textStyle118,
                    ),
                    TextSpan(
                      text: (subtitle ?? "").tr(),
                      style: TextStyles.textStyle119,
                    )
                  ])),
              trailing: ImageFromAssetPath<Widget>(
                      assetPath: ImageAssetpathConstant.vector)
                  .imageWidget,
            ),
          ),
        ),
      );
    });
  }
}
