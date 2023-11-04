import 'package:flame_lottie/flame_lottie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/GreetMessageModel/greetMessageModel.dart';

import '../../models/helper/service_locator.dart';
import '../../ui/routes/router.dart';
import '../common/custom_interactive_dialog.dart';
import '../common/enum_constants.dart';
import '../common/key_value_sharedpreferences.dart';

showGreetDialogWRTToCurrentTime() async {
  GreetAssetDimensionsAndMessage? greetDialog =
      await DateTime.now().getGreetMessage(checkLastTimeStamp: true);
  if (greetDialog == null) {
    return;
  }

  await getIt<SharedPreferences>().setString(
      SharedPrefKeyValue.greetTimeStampShownAt,
      DateTime.now().parseDateIn(requiredFormat: "yyyy-MM-dd HH:mm:ss") ?? "");
  showInteractiveDialog(
    greetTitleMessage: null,
    onDismiss: () {
      Get.until((route) {
        if (Get.currentRoute != landing) {
          Get.back();
          return true;
        }
        return false;
      });
    },
    // greetData: greetData,
    // dismissAutomatically: false,
    dismissIn: Duration(seconds: 7),
    dialogOption: DialogOptions.greet,
    dialogTitle: greetDialog.message +
        " " +
        (Get.put(AuthManager()).userDetails?.value?.user?.name ?? ""),
    dialogSubTitle: greetDialog.subTitle ?? "",
    image: greetDialog.asset,

    topAnimationWidget: Center(
      child: Padding(
        padding: EdgeInsets.only(top: 15),
        child: Lottie.asset(greetDialog.asset,
            height: 150,
            fit: BoxFit.fill,
            repeat: true, errorBuilder: (lottieContext, obj, trace) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    ),
  );
}
