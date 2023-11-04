import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xuriti/ui/push_notification/notification.dart';
import 'package:xuriti/ui/screens/starting_screens/splash_screen.dart';
import 'models/helper/service_locator.dart';
import 'ui/routes/routnames.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

bool splashid = false;

//
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseInitialization.sharedInstance.registerNotification();
  HttpOverrides.global = MyHttpOverrides();
  await setupServiceLocator();
  // await getIt<SharedPreferences>().setString(
  //     SharedPrefKeyValue.recentSelectedCompany,
  //     Get.put(CompanyListViewModel()).selectedCompany.value?.companyId ?? "");
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('hi', 'IN')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('en', 'US'),
        child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, // status bar color
    ));
    // SaveUserDetail().getUserDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 786),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routers.generateRoute,
          navigatorKey: navigatorKey,
          initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),
          },
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
