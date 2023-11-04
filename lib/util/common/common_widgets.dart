import 'package:flutter/material.dart';
import 'package:xuriti/ui/theme/constants.dart';
import 'package:xuriti/util/common/text_constant_widget.dart';

Widget primaryButton(
    {required String title,
    double? height,
    double? width,
    TextStyle? textStyle,
    Color? color,
    double? borderRadius,
    Function()? onTap,
    EdgeInsets? padding,
    bool? isOutlined}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: padding,
      width: width,
      height: height,
      child: Center(
        child: ConstantText(
          text: title,
          style: textStyle,
        ),
      ),
      decoration: BoxDecoration(
        border: isOutlined == true
            ? Border.all(
                color: color ?? Colours.pumpkin,
              )
            : null,
        color: isOutlined == true ? null : color,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
    ),
  );
}
