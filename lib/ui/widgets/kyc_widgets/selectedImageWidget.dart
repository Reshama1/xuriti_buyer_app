import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file_safe_plus/open_file_safe_plus.dart';
import '../../theme/constants.dart';

class SelectedImageWidget extends StatefulWidget {
  final List<File?>? documentImages;
  final Function(int index)? onTapCrossIcons;
  final bool? showRemoveButton;

  //final String type;
  const SelectedImageWidget(
      {required this.documentImages,
      this.onTapCrossIcons,
      this.showRemoveButton});

  @override
  State<SelectedImageWidget> createState() => _SelectedImageWidgetState();
}

class _SelectedImageWidgetState extends State<SelectedImageWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.documentImages == null || widget.documentImages!.isEmpty) {
      return SizedBox();
    } else if (widget.documentImages!.length > 1) {
      return SizedBox(
        height: 200,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            primary: false,
            shrinkWrap: true,
            itemCount: widget.documentImages!.length,
            itemBuilder: (contxt, index) {
              if (widget.documentImages![index]?.path.split('.').last !=
                  'pdf') {
                return Stack(children: [
                  SizedBox(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1),
                              child: Image.file(
                                widget.documentImages![index]!,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width * 0.38,
                                height: 80,
                              ),
                            ),
                          ),
                          Text(
                            widget.documentImages![index]?.path
                                    .split('/')
                                    .last ??
                                '',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.showRemoveButton == false
                      ? SizedBox()
                      : Positioned(
                          right: 1.0,
                          top: 30.0,
                          child: InkWell(
                            onTap: () {
                              if (widget.onTapCrossIcons != null) {
                                widget.onTapCrossIcons!(index);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                  color: Colours.paleRed,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.clear,
                                color: Colours.white,
                                size: 15.0,
                              ),
                            ),
                          ),
                        ),
                ]);
              } else {
                return Stack(fit: StackFit.loose, children: [
                  widget.showRemoveButton == false
                      ? SizedBox()
                      : Positioned(
                          right: 10.0,
                          child: InkWell(
                            onTap: () {
                              if (widget.onTapCrossIcons != null) {
                                widget.onTapCrossIcons!(index);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                  color: Colours.paleRed,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.clear,
                                color: Colours.white,
                                size: 15.0,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    width: 160,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1),
                              child: GestureDetector(
                                onTap: () {
                                  OpenFilePlus.open(
                                      widget.documentImages![index]!.path);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 1,
                                  ),
                                  child: Icon(Icons.picture_as_pdf, size: 80),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            widget.documentImages![index]?.path
                                    .split('/')
                                    .last ??
                                '',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]);
              }
            }),
      );
    } else {
      if (widget.documentImages![0]?.path.split('.').last != 'pdf') {
        return Stack(children: [
          SizedBox(
            height: 230,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1),
                      child: Image.file(
                        widget.documentImages![0]!,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width * 0.38,
                        height: 120,
                      ),
                    ),
                  ),
                  Text(
                    widget.documentImages![0]?.path.split('/').last ?? '',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          widget.showRemoveButton == false
              ? SizedBox()
              : Positioned(
                  right: 120.0,
                  top: 7.0,
                  child: InkWell(
                    onTap: () {
                      if (widget.onTapCrossIcons != null) {
                        widget.onTapCrossIcons!(0);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                          color: Colours.paleRed, shape: BoxShape.circle),
                      child: Icon(
                        Icons.clear,
                        color: Colours.white,
                        size: 15.0,
                      ),
                    ),
                  ),
                ),
        ]);
      } else {
        return SizedBox(
          width: 120,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1),
                        child: GestureDetector(
                          onTap: () {
                            OpenFilePlus.open(widget.documentImages![0]!.path);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 1,
                            ),
                            child: Icon(Icons.picture_as_pdf, size: 80),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      widget.documentImages![0]?.path.split('/').last ?? '',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                widget.showRemoveButton == false
                    ? SizedBox()
                    : Positioned(
                        right: 10.0,
                        child: InkWell(
                          onTap: () {
                            if (widget.onTapCrossIcons != null) {
                              widget.onTapCrossIcons!(0);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                color: Colours.paleRed, shape: BoxShape.circle),
                            child: Icon(
                              Icons.clear,
                              color: Colours.white,
                              size: 15.0,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      }
    }
  }
}
