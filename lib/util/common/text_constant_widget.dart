import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../ui/theme/constants.dart';

class ConstantText extends StatelessWidget {
  final TextStyle? style;
  final String? text;
  final double? fontSize;
  final double? height;
  final Color? color;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final String? fontFamily;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool? softWrap;

  const ConstantText(
      {required this.text,
      this.fontSize,
      this.height,
      this.color,
      this.fontFamily,
      this.overflow,
      this.fontWeight,
      this.maxLines,
      this.textAlign,
      this.style,
      this.softWrap});

  @override
  Widget build(BuildContext context) {
    return Text(
      (text ?? "").tr(),
      style: TextStyle(
        fontSize: fontSize ?? style?.fontSize,
        height: height,
        color: color ?? style?.color,
        fontFamily: fontFamily ?? style?.fontFamily,
        fontWeight: fontWeight ?? style?.fontWeight,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}

Widget colonWidget() {
  return const ConstantText(
    text: " : ",
    style: TextStyles.textStyle17,
  );
}
