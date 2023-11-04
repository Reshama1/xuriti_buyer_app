import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/new%20modules/InteractiveSplashScreen/InvoiceInteractiveModel.dart';
import 'package:xuriti/util/Extensions.dart';
import 'package:xuriti/util/common/key_value_sharedpreferences.dart';

import '../../models/services/dio_service.dart';
import '../../util/common/endPoints_constant.dart';
import '../Credit_Details/DataRepo/Credit_Details_VM.dart';

class InteractiveDialogViewModel extends GetxController {
  Rx<InteractiveDialogModel?>? interactiveMessageForGreet =
      RxNullable<InteractiveDialogModel?>().setNull();
  Rx<InteractiveDialogModel?>? interactiveMessageForInvoice =
      RxNullable<InteractiveDialogModel?>().setNull();
  RxBool gettingSplashScreenDataForGreet = false.obs;
  RxBool gettingSplashScreenDataForInvoice = false.obs;

  getInteractiveDialogueData(
      {String? buyerId, required String dialogType}) async {
    if (buyerId == null) {
      gettingSplashScreenDataForGreet.value = true;
    } else {
      gettingSplashScreenDataForInvoice.value = true;
    }
    interactiveMessageForGreet?.value = null;
    interactiveMessageForInvoice?.value = null;
    String? lastTimeStamp = await getIt<SharedPreferences>()
        .getString(SharedPrefKeyValue.greetTimeStampShownAt);

    if (lastTimeStamp == null || lastTimeStamp.isEmpty) {
      lastTimeStamp = DateTime.now()
          .subtract(Duration(days: 1))
          .parseDateIn(requiredFormat: "yyyy-MM-ddTHH:mm:ss.sss+00:00");
    } else {
      lastTimeStamp = DateTime.parse(lastTimeStamp)
          .toUtc()
          .parseDateIn(requiredFormat: "yyyy-MM-ddTHH:mm:ss.sss+00:00");
    }

    Map<String, dynamic>? responseData = await DioClient().get(
      getInteractiveGreetMessageUrl(
          id: buyerId,
          dialogType: dialogType,
          lastGreetTimeStamp: lastTimeStamp),
    );

    if (buyerId == null) {
      gettingSplashScreenDataForGreet.value = false;
    } else {
      gettingSplashScreenDataForInvoice.value = false;
    }
    if (responseData != null && responseData['statusCode'] == 440) {
      return null;
    } else if (responseData != null) {
      if (buyerId == null) {
        interactiveMessageForGreet?.value =
            InteractiveDialogModel.fromJson(responseData);
      } else {
        interactiveMessageForInvoice?.value =
            InteractiveDialogModel.fromJson(responseData);
      }
    }

    if (buyerId == null) {
      return interactiveMessageForGreet?.value;
    } else {
      return interactiveMessageForInvoice?.value;
    }
  }
}
