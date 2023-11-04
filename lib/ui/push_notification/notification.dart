import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xuriti/companyList/model/companyListModel.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/logic/view_models/trans_history_manager.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/new%20modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/screens/signup_and_login_screens/login_screen.dart';
import '../../logic/view_models/auth_manager.dart';
import '../../main.dart';
import '../../util/common/string_constants.dart';

class FirebaseInitialization {
  FirebaseInitialization._privateConstructor();
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  TransactionManager transactionManager = Get.put(TransactionManager());
  TransHistoryManager transHistoryManager = Get.put(TransHistoryManager());
  Credit_Details_VM credit_details_view_model = Get.put(Credit_Details_VM());
  AuthManager authManager = Get.put(AuthManager());

  String? fcmToken;

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static FirebaseInitialization sharedInstance =
      FirebaseInitialization._privateConstructor();

  Future<void> registerNotification() async {
    // storeLogToAFile({"register": "Register Notification called"});

    try {
      if (Platform.isIOS) {
        if (await Permission.notification.status != PermissionStatus.granted) {
          await Permission.notification.request();
        }
      } else {
        if (await Permission.notification.status != PermissionStatus.granted) {
          await Permission.notification.request();
        }
      }

      await FirebaseMessaging.instance.getAPNSToken();
      fcmToken = await FirebaseMessaging.instance.getToken();

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) async {
          showNotification(message.data, message.notification);

          return;
        },
        onError: (error) {
          print(error);
        },
      );
    } catch (e) {
      return;
    }
    return;
  }

  void configLocalNotification() async {
    // storeLogToAFile({"register": "Config Notification called"});
    //when app open
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // storeLogToAFile({"handled Tap": "App opened 123"});
      handleMessage(message.data);
    });
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (response) {
      // storeLogToAFile({"OnDidReceived": response.payload ?? ""});
      if ((response.payload ?? "").isNotEmpty) {
        handleMessage(jsonDecode(response.payload ?? ""));
      }
    });
  }

  void storeLogToAFile(Map<String, dynamic> data) async {
    Fluttertoast.showToast(msg: data.toString());
    Directory? docDirectory = await getExternalStorageDirectory();
    if (docDirectory == null) {
      Fluttertoast.showToast(msg: unable_to_save_log);
      return;
    }
    String filePath = "/xuriti_logs.txt";
    File logFile = File(docDirectory.path + filePath);
    if (await logFile.exists()) {
      String contentsOfFile = await logFile.readAsString();
      contentsOfFile = contentsOfFile + " \n" + data.toString();
      await logFile.writeAsString(contentsOfFile);
    } else {
      await logFile.writeAsString(data.toString());
    }
  }

  void handleMessage(Map<String, dynamic> messageData) async {
    // storeLogToAFile(messageData);

    if (authManager.userDetails?.value == null) {
      await navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (context) => LoginScreen(isFromPushNotification: true)));
      // await Navigator.of(Get.context!).push(MaterialPageRoute(
      //     builder: (context) => LoginScreen(isFromPushNotification: true)));
      if (authManager.userDetails?.value == null) {
        return;
      }
    }

    companyListViewModel.selectedCompany.value =
        CompanyInformation(companyId: messageData['entityid'] ?? "");

    companyListViewModel.selectedCompany.value =
        await companyListViewModel.getCompanyDetails();

    credit_details_view_model.getCreditDetails();
    // storeLogToAFile({
    //   "company details set":
    //       companyListViewModel.selectedCompany.value?.toJson().toString()
    // });
    if (messageData['module'] == 'Invoices' && messageData['target'] != null) {
      //It will navigate to invoice details
      navigatorKey.currentState
          ?.pushNamed(upcomingDetails, arguments: messageData['target']);
    } else if (messageData['module'] == 'Invoices' &&
        messageData['target'] == null) {
      //It will navigate to landing screen => With Selection invoice tab and selected index will be pending invoices

      /// : Set Indexing values of Invoices tab
      transactionManager.invoiceScreenIndex.value = 0;
      transactionManager.landingScreenIndex.value = 1;

      navigatorKey.currentState?.pushNamed(landing);
    } else if (messageData['module'] == "Entity") {
      transactionManager.invoiceScreenIndex.value = 0;
      transactionManager.landingScreenIndex.value = 0;

      navigatorKey.currentState?.pushNamed(landing);
    } else if (messageData['module'] == 'Payment') {
      //It will navigate to landing screen => With Selection invoice tab and selected index will be payment history

      ///Set Indexing values of Invoices tab

      transactionManager.invoiceScreenIndex.value = 3;
      transactionManager.landingScreenIndex.value = 1;

      transHistoryManager.getPaymentHistory(
          companyListViewModel.selectedCompany.value?.companyId ?? "");
      navigatorKey.currentState?.pushNamed(landing);
    }
  }

  void showNotification(
      Map<String, dynamic> data, RemoteNotification? remoteNotification) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      "com.xuriti.app",
      'Xuriti',
      channelDescription: 'your channel description',
      playSound: true,
      // icon: "@mipmap/ic_launcher",
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    // await flutterLocalNotificationsPlugin.show();

    await flutterLocalNotificationsPlugin.show(
      0,
      remoteNotification?.title ?? "",
      remoteNotification?.body ?? '',
      platformChannelSpecifics,
      payload: jsonEncode(data),
    );
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
//  FirebaseInitialization.sharedInstance.handleMessage(message);
}
