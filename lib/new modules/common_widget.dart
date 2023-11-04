import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageFromAssetPath<T> {
  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;
  late ImageProvider provider;
  final BoxFit? fit;

  late T imageWidget;
  ImageFromAssetPath({
    this.fit,
    required this.assetPath,
    this.width,
    this.height,
    this.color,
  }) {
    provider = AssetImage(assetPath);

    imageWidget = Semantics(
      label: assetPath,
      child: assetPath.split("/").last.split(".").last.toLowerCase() != "svg"
          ? Image.asset(
              assetPath,
              height: height,
              width: width,
              color: color,
              fit: fit,
            )
          : SvgPicture.asset(
              assetPath,
              height: height,
              width: width,
              color: color,
            ),
    ) as T;
  }
}
