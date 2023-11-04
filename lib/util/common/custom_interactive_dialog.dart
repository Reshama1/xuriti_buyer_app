import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/util/common/enum_constants.dart';
import 'package:xuriti/util/common/string_constants.dart';
import 'package:xuriti/util/common/text_constant_widget.dart';

showInteractiveDialog({
  required DialogOptions dialogOption,
  required Function() onDismiss,
  Widget? topAnimationWidget,
  Alignment? customWidgetAlignment,
  String? dialogTitle,
  String? dialogSubTitle,
  String? image,
  Widget? actionButtons,
  Duration? dismissIn,
  Color? bgColorForGreetInInvoicesDialog,
  required String? greetTitleMessage,
}) {
  Get.dialog(
    WillPopScope(
      onWillPop: () async {
        onDismiss();
        return false;
      },
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: DialogBody(
          onDismiss: onDismiss,
          topAnimationWidget: topAnimationWidget,
          customWidgetAlignment: customWidgetAlignment,
          dialogSubTitle: dialogSubTitle,
          dialogTitle: dialogTitle,
          actionButtons: actionButtons,
          dialogOption: dialogOption,
          bgColorForGreetInInvoicesDialog: bgColorForGreetInInvoicesDialog,
          greetTitleMessage: greetTitleMessage,
        ),
      ),
    ),
  );
}

class DialogBody extends StatefulWidget {
  final Widget? topAnimationWidget;
  final DialogOptions dialogOption;
  final Alignment? customWidgetAlignment;
  final String? dialogTitle;
  final String? dialogSubTitle;
  final Widget? actionButtons;
  final Duration? dismissIn;

  final Color? bgColorForGreetInInvoicesDialog;
  final Function() onDismiss;
  final String? greetTitleMessage;

  const DialogBody({
    this.topAnimationWidget,
    this.customWidgetAlignment,
    this.dialogTitle,
    this.dialogSubTitle,
    this.actionButtons,
    required this.dialogOption,
    this.dismissIn,
    required this.onDismiss,
    required this.bgColorForGreetInInvoicesDialog,
    required this.greetTitleMessage,
  });

  @override
  State<DialogBody> createState() => _DialogBodyState();
}

class _DialogBodyState extends State<DialogBody> {
  AuthManager authManager = Get.put(AuthManager());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.0),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.dialogOption == DialogOptions.greet
                ? SizedBox()
                : Container(
                    height: 45,
                    color: widget.bgColorForGreetInInvoicesDialog,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: ConstantText(
                          text: (widget.greetTitleMessage ?? ""),
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
            if (widget.topAnimationWidget != null) widget.topAnimationWidget!,
            SizedBox(
              height: 15.0,
            ),
            if (widget.dialogOption == DialogOptions.greet ||
                (widget.dialogTitle ?? "").isNotEmpty)
              DelayedWidget(
                delayDuration: Duration(milliseconds: 160),
                animationDuration: Duration(seconds: 4),
                animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                child: Center(
                  child: ConstantText(
                    text: (widget.dialogTitle ?? ""),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            SizedBox(
              height: 10.0,
            ),
            if (widget.dialogOption == DialogOptions.greet ||
                (widget.dialogSubTitle ?? "").isNotEmpty)
              DelayedWidget(
                delayDuration: Duration(milliseconds: 160),
                animationDuration: Duration(seconds: 4),
                animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                child: Center(
                  child: ConstantText(
                    text: (widget.dialogSubTitle ?? ""),
                    fontSize: 15.0,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            if (widget.actionButtons != null)
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: DelayedWidget(
                    delayDuration: Duration(milliseconds: 160),
                    animationDuration: Duration(seconds: 4),
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    child: widget.actionButtons!),
              ),
            SizedBox(
              height: widget.actionButtons != null ? 0.0 : 10.0,
            ),
            InkWell(
              onTap: widget.onDismiss,
              child: DelayedWidget(
                delayDuration: Duration(milliseconds: 160),
                animationDuration: Duration(seconds: 4),
                animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                child: Center(
                  child: ConstantText(
                    text: close,
                    color: Colors.red,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: widget.actionButtons != null ? 10.0 : 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
