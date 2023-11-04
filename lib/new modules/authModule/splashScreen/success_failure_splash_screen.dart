import 'package:flame_lottie/flame_lottie.dart';
import 'package:flutter/material.dart';
import 'package:xuriti/new%20modules/authModule/forgotPassword/set_pin_new_signup.dart';
import 'package:xuriti/ui/routes/router.dart';
import '../../../ui/theme/constants.dart';

class SuccessFailureSplashScreen extends StatefulWidget {
  final String emailId;
  final Function()? delayedWidgetAction;
  final int? seconds;
  final Widget? customWidget;
  final bool? showCustomeWidget;
  final bool? isLoginFlow;

  const SuccessFailureSplashScreen(
      {Key? key,
      required this.emailId,
      this.delayedWidgetAction,
      this.showCustomeWidget,
      this.isLoginFlow,
      this.seconds,
      this.customWidget})
      : super(key: key);

  @override
  State<SuccessFailureSplashScreen> createState() =>
      _SuccessFailureSplashScreenState();
}

class _SuccessFailureSplashScreenState
    extends State<SuccessFailureSplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        if (widget.showCustomeWidget == true &&
            widget.delayedWidgetAction != null) {
          widget.delayedWidgetAction!();
          return;
        }
        await Future.delayed(Duration(seconds: widget.seconds ?? 5));
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return WillPopScope(
              onWillPop: () async {
                Navigator.pushReplacementNamed(
                  context,
                  oktWrapper,
                );
                return false;
              },
              child: Dialog(
                backgroundColor: Colors.transparent,
                elevation: 5.0,
                insetPadding: EdgeInsets.all(20.0),
                child: SetNewPINPostSignUp(
                  emailId: widget.emailId,
                  isLoginFlow: widget.isLoginFlow,
                ),
              ),
            );
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colours.white,
        body: Center(
          child: widget.customWidget ??
              Lottie.asset(
                "assets/lottie/signup_done.json",
                repeat: false,
              ),
        ),
      ),
    );
  }
}
