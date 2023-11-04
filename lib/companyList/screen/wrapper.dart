import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/companyList/model/companyListModel.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/screens/starting_screens/company_list.dart';
import 'package:xuriti/ui/screens/starting_screens/company_register_screen.dart';
import '../../logic/view_models/transaction_manager.dart';
import '../../models/helper/service_locator.dart';
import '../../util/common/string_constants.dart';

class OktWrapper extends StatefulWidget {
  const OktWrapper({Key? key}) : super(key: key);

  @override
  State<OktWrapper> createState() => _OktWrapperState();
}

class _OktWrapperState extends State<OktWrapper> {
  bool isLoading = true;
  bool isSuccess = false;
  bool isSessionExpired = false;
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  TransactionManager transactionManager = Get.put(TransactionManager());
  AuthManager authManager = Get.put(AuthManager());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCompanyListAndNavigate();
    });
    super.initState();
  }

  getCompanyListAndNavigate() async {
    String? id = authManager.userDetails?.value?.user?.sId ?? "";

    CompanyListModel? compList = await companyListViewModel.getCompanyList(
      id,
      (bool value) {
        isSessionExpired = value;
      },
    );

    if (isSessionExpired) {
      await authManager.logOut();
      await FirebaseMessaging.instance.deleteToken();

      await getIt<SharedPreferences>().setString('onboardViewed', 'true');

      Navigator.pushNamed(context, getStarted);
      Fluttertoast.showToast(webPosition: "center", msg: "session time out");
    } else {
      if ((compList?.company?.length ?? 0) == 1) {
        isLoading = false;
        isSuccess = false;
        companyListViewModel.selectedCompany.value =
            companyListViewModel.companyList?.value?.company?.first.company;

        if (companyListViewModel.selectedCompany.value?.status == "Approved") {
          transactionManager.landingScreenIndex.value = 0;
          transactionManager.invoiceScreenIndex.value = 0;
          Navigator.pushReplacementNamed(context, landing);
          return;
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, companyList, (Route<dynamic> route) => false);
        }
      } else if ((compList?.company?.length ?? 0) > 0) {
        isLoading = false;
        isSuccess = false;

        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, companyList, (Route<dynamic> route) => false);
        }
      } else {
        isLoading = false;
        isSuccess = true;
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, companyList, (Route<dynamic> route) => false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading == true)
        ? Center()
        : (isSuccess == true)
            ? CompanyList()
            : CompanyRegisterScreen();
  }
}
