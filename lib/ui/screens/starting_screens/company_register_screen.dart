import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/util/common/string_constants.dart';
import '../../../logic/view_models/auth_manager.dart';
import '../../../models/core/user_details.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class CompanyRegisterScreen extends StatefulWidget {
  const CompanyRegisterScreen({Key? key}) : super(key: key);

  @override
  State<CompanyRegisterScreen> createState() => _CompanyRegisterScreenState();
}

class _CompanyRegisterScreenState extends State<CompanyRegisterScreen> {
  AuthManager authManager = Get.put(AuthManager());
  @override
  Widget build(BuildContext context) {
    UserDetails? userInfo = authManager.userDetails?.value;

    DateTime _lastExitTime = DateTime.now();
    onWillPop() async {
      if (DateTime.now().difference(_lastExitTime) >= Duration(seconds: 2)) {
        //showing message to user
        final snack = SnackBar(
          content: ConstantText(text: pressBackButtonAgainToExit),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snack);
        _lastExitTime = DateTime.now();
        return false; // disable back press
      } else {
        return true; //  exit the app
      }
    }

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;

      double w1p = maxWidth * 0.01;
      return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
            backgroundColor: Colours.black,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colours.black,
              automaticallyImplyLeading: false,
              toolbarHeight: h1p * 8,
              flexibleSpace: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: w1p * 55, top: h1p * 4),
                    child: Column(
                      children: [
                        ConstantText(
                          text: welcome,
                          style: TextStyles.sName,
                        ),
                        ConstantText(
                          text: (userInfo == null || userInfo.user == null)
                              ? ""
                              : userInfo.user!.name ?? "",
                          style: TextStyles.textStyle21,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: h1p * 3,
                    ),
                    child: ImageFromAssetPath<Widget>(
                      assetPath: ImageAssetpathConstant.xuriti1,
                    ).imageWidget,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colours.primary,
              onPressed: () async {
                await authManager.logOut();

                Navigator.pushNamed(context, getStarted);
              },
              child: Icon(Icons.logout_outlined),
            ),
            body: Container(
                // width: maxWidth,
                decoration: const BoxDecoration(
                  color: Colours.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                  ),
                ),
                child: ListView(children: [
                  Padding(
                    padding: EdgeInsets.only(left: w1p * 35),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: h1p * 5),
                          child: ConstantText(
                            text: companies,
                            style: TextStyles.textStyle56,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, businessRegister);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: h1p * 13),
                              child: Icon(
                                Icons.add,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: h1p * 26),
                    child: Center(
                      child: ConstantText(
                        text: please_add_your_company_to_get_started,
                        style:
                            TextStyle(color: Colours.warmGrey75, fontSize: 21),
                      ),
                    ),
                  )
                ]))),
      );
    });
  }
}
