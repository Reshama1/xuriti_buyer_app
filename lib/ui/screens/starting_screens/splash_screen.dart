import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:new_version_plus/new_version_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/theme/constants.dart';
import 'package:xuriti/util/common/text_constant_widget.dart';
import '../../../companyList/viewmodel/companyListVM.dart';
import '../../../logic/view_models/trans_history_manager.dart';
import '../../../logic/view_models/transaction_manager.dart';
import '../../../new modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import '../../../util/common/string_constants.dart';
import '../../push_notification/notification.dart';
import '../internet_connectivity.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  // RxString versionNumber = "".obs;
  // RxString buildNumber = "".obs;

  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  TransactionManager transactionManager = Get.put(TransactionManager());
  TransHistoryManager transHistoryManager = Get.put(TransHistoryManager());
  Credit_Details_VM credit_details_view_model = Get.put(Credit_Details_VM());
  AuthManager authManager = Get.put(AuthManager());

  @override
  void initState() {
    checkForUpdateAndNavigate();

    super.initState();
  }

  void initializePushNotification() async {
    FirebaseInitialization.sharedInstance.configLocalNotification();

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void checkForUpdateAndNavigate() async {
    WidgetsBinding.instance.addObserver(this);

    print("Checking network connection");
    bool mobileInternetOn = await isMobileInternetOn();
    print("Checked network connection");

    final newVersion =
        NewVersionPlus(androidId: "com.xuriti.app", iOSId: "com.xuriti.app");
    if (mobileInternetOn) {
      advancedStatusCheck(newVersion);
    } else {
      Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoInternetScreen()))
          .then((value) => checkForUpdateAndNavigate());
    }
  }

  advancedStatusCheck(NewVersionPlus newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      if (status.canUpdate == true) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return WillPopScope(
                onWillPop: () => Future.value(false),
                child: AlertDialog(
                  title: Text(update_available),
                  content: ConstantText(
                    text: updateAvailableMsg(
                        storeVersion: status.storeVersion,
                        localVersion: status.localVersion),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        _launchUrl(status.appStoreLink);
                      },
                      child: Text(
                        update_now,
                      ),
                    ),
                  ],
                ),
              );
            });
      } else {
        _navigateLogin();
      }
    } else {
      _navigateLogin();
    }
  }

  Future<void> _launchUrl(String storelink) async {
    if (!await launchUrl(Uri.parse(storelink))) {
      throw Exception(exceptionURL(storelink));
    }
    Navigator.pop(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          checkForUpdateAndNavigate();
          if (mounted) {
            setState(() {});
          }
        });
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<bool> isMobileInternetOn() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.bluetooth) {
      return true;
    } else {
      return false;
    }
  }

  _navigateLogin() async {
    if (getIt<SharedPreferences>().getString('onboardViewed') == 'true') {
      FirebaseMessaging.instance.getInitialMessage().then((value) {
        if (value != null) {
          FirebaseInitialization.sharedInstance.handleMessage(value.data);
        } else {
          if (mounted) {
            if (authManager.userDetails?.value == null) {
              Navigator.pushReplacementNamed(context, login);
            } else {
              Navigator.pushNamed(context, oktWrapper);
            }
          }
        }
      });
    } else {
      Navigator.pushNamed(context, onBoard);
      // Navigator.pop(context);
    }
    initializePushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 180),
            Container(
              width: 158.016,
              height: 55,
              decoration: const BoxDecoration(
                color: Colours.black,
                image: DecorationImage(
                  image: AssetImage("assets/images/xuriti-white.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 70),
            SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset("assets/images/logo1.svg"),
            ),
            const SizedBox(
              height: 70,
            ),
            SizedBox(
              width: 130,
              child: ConstantText(
                text: splash_screen_slogan,
                style: TextStyles.textStyle2,
                textAlign: TextAlign.center,
              ),
            )
            // const Text(
            //   "“The question is not",
            //   style: TextStyles.textStyle2,
            // ),
            // const Text(
            //   "what you look at,but",
            //   style: TextStyles.textStyle2,
            // ),
            // const Text(
            //   "what you see.“",
            //   style: TextStyles.textStyle2,
            // ),
          ],
        ),
      ),
    );
  }
}
