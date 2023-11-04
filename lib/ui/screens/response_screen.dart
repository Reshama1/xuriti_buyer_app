import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';

class ResponseScreen extends StatelessWidget {
  const ResponseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController pas = TextEditingController();
    TextEditingController tempd = TextEditingController();
    AuthManager authManager = Get.put(AuthManager());

    String? id = authManager.userDetails?.value?.user?.sId ?? "";
    String? token = authManager.userDetails?.value?.token ?? "";
    String? temp = getIt<SharedPreferences>().getString("temp");

    emailController.text = id;
    pas.text = token;
    tempd.text = temp!;

// Map<String, dynamic> response = getIt<CompanyDetailsManager>().response;
    // String res = response.toString();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              TextBoxField(
                controller: emailController,
              ),
              TextBoxField(
                controller: pas,
              ),
              SizedBox(
                height: 50,
              ),
              TextBoxField(
                controller: tempd,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
