import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';
import 'package:xuriti/logic/view_models/profile_manager.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/user_details.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/widgets/profile/profile_widget.dart';
import 'package:xuriti/util/common/string_constants.dart';
import 'package:xuriti/util/common/textBoxWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../logic/view_models/auth_manager.dart';
import '../../../models/helper/service_locator.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../theme/constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<ScaffoldState> ssk = GlobalKey();

  TransactionManager transactionManager = Get.put(TransactionManager());
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());
  AuthManager authManager = Get.put(AuthManager());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  bool isDelete = false;
  @override
  Widget build(BuildContext context) {
    UserDetails? userInfo = authManager.userDetails?.value;

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      double w1p = maxWidth * 0.01;

      return Scaffold(
          key: ssk,
          backgroundColor: Colours.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: h10p * 1.7,
            flexibleSpace: ProfileWidget(pskey: ssk),
          ),
          body: ProgressHUD(child: Builder(builder: (context) {
            return Column(children: [
              SizedBox(
                height: h10p * .3,
              ),
              Expanded(
                  child: Container(
                      width: maxWidth,
                      decoration: const BoxDecoration(
                          color: Colours.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26),
                            topRight: Radius.circular(26),
                          )),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: h1p * 2.5, right: h1p * 2.5, top: 18),
                        child: ListView(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, profile);
                            },
                            child: Row(
                              children: [
                                ImageFromAssetPath<Widget>(
                                        assetPath:
                                            ImageAssetpathConstant.arrowLeft)
                                    .imageWidget,
                                SizedBox(
                                  width: w10p * .3,
                                ),
                                const ConstantText(
                                  text: back,
                                  style: TextStyles.textStyle41,
                                ),
                              ],
                            ),
                          ),
                          // CircleAvatar(
                          //   radius: 70,
                          //   child: ImageFromAssetPath<Widget>(
                          //     assetPath:"assets/images/editProfile.png",
                          //       fit: BoxFit.cover),
                          // ),
                          SizedBox(
                            height: h1p * 2,
                          ),
                          const ConstantText(
                            text: view_details,
                            style: TextStyles.textStyle87,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: h1p * 4,
                          ),
                          Row(
                            children: [
                              //  SizedBox(width:w10p*.5 ,),
                              const ConstantText(
                                text: first_name,
                                style: TextStyles.textStyle38,
                              ),
                              SizedBox(width: w10p * 2.8),
                              const ConstantText(
                                text: last_name,
                                style: TextStyles.textStyle38,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: SizedBox(
                                  height: 45,
                                  child: TextBoxField(
                                      enabled: false,
                                      onChanged: (_) {
                                        // getIt<PasswordManager>()
                                        //     .validateFirstName(
                                        //         firstNameController.text);
                                      },
                                      controller: firstNameController,
                                      textStyle: TextStyles.textStyle4,
                                      focusedBorder: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 24),
                                      fillColor: Colours.paleGrey,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: (userInfo?.user == null ||
                                              userInfo?.user!.firstName == null)
                                          ? first_name
                                          : userInfo?.user!.firstName ?? '',
                                      hintStyle: TextStyles.textStyle70),
                                )),
                                const SizedBox(
                                  width: 18,
                                ),
                                Expanded(
                                    child: SizedBox(
                                  height: 45,
                                  child: TextBoxField(
                                      enabled: false,
                                      onChanged: (_) {
                                        // getIt<PasswordManager>()
                                        //     .validateSecondName(
                                        //         lastNameController.text);
                                      },
                                      controller: lastNameController,
                                      textStyle: TextStyles.textStyle4,
                                      focusedBorder: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 24),
                                      fillColor: Colours.paleGrey,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: (userInfo?.user == null ||
                                              userInfo?.user!.lastName == null)
                                          ? last_name
                                          : userInfo?.user!.lastName ?? '',
                                      hintStyle: TextStyles.textStyle70),
                                )),
                              ],
                            ),
                          ),

                          ConstantText(
                              text: user_name, style: TextStyles.textStyle38),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 45,
                              child: TextBoxField(
                                  enabled: false,
                                  onChanged: (_) {
                                    // getIt<PasswordManager>().validateUserName(
                                    //     userNameController.text);
                                  },
                                  controller: userNameController,
                                  textStyle: TextStyles.textStyle4,
                                  focusedBorder: outlineInputBorder,
                                  enabledBorder: outlineInputBorder,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 24),
                                  fillColor: Colours.paleGrey,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: (userInfo?.user == null)
                                      ? user_name
                                      : userInfo?.user!.name ?? '',
                                  hintStyle: TextStyles.textStyle70),
                            ),
                          ),

                          const ConstantText(
                              text: email_id, style: TextStyles.textStyle38),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 45,
                              child: TextBoxField(
                                  enabled: false,
                                  onSubmitted: (_) {
                                    // getIt<PasswordManager>()
                                    //     .validateEmail(emailController.text);
                                  },
                                  controller: emailController,
                                  textStyle: TextStyles.textStyle4,
                                  focusedBorder: outlineInputBorder,
                                  enabledBorder: outlineInputBorder,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 24),
                                  fillColor: Colours.paleGrey,
                                  filled: true,
                                  hintText: (userInfo?.user == null)
                                      ? email_id
                                      : userInfo?.user!.email ?? '',
                                  hintStyle: TextStyles.textStyle70),
                            ),
                          ),

                          const ConstantText(
                              text: mobile_number,
                              style: TextStyles.textStyle38),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 45,
                              child: TextBoxField(
                                  enabled: false,
                                  onSubmitted: (val) {
                                    // getIt<PasswordManager>()
                                    //     .validateMobile(val);
                                  },
                                  controller: numberController,
                                  textStyle: TextStyles.textStyle4,
                                  focusedBorder: outlineInputBorder,
                                  enabledBorder: outlineInputBorder,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 24),
                                  fillColor: Colours.paleGrey,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: (userInfo?.user == null)
                                      ? mobile_number
                                      : userInfo?.user!.mobileNumber.toString(),
                                  hintStyle: TextStyles.textStyle70),
                            ),
                          ),

                          Card(
                            elevation: 2,
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w1p * 5, vertical: h1p * 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        AutoSizeText(
                                          company_name,
                                          style: TextStyles.textStyle54,
                                        ),
                                        AutoSizeText(
                                          companyListViewModel.selectedCompany
                                                  .value?.companyName ??
                                              "",
                                          style: TextStyles.textStyle55,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h1p * .5,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          address,
                                          style: TextStyles.textStyle54,
                                        ),
                                        Expanded(
                                          child: AutoSizeText(
                                            companyListViewModel.selectedCompany
                                                    .value?.address ??
                                                "",
                                            style: TextStyles.textStyle55,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h1p * .5,
                                    ),
                                    Row(
                                      children: [
                                        AutoSizeText(
                                          pan_number,
                                          style: TextStyles.textStyle54,
                                        ),
                                        AutoSizeText(
                                          companyListViewModel
                                                  .selectedCompany.value?.pan ??
                                              "",
                                          style: TextStyles.textStyle55,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h1p * .5,
                                    ),
                                    Row(
                                      children: [
                                        AutoSizeText(
                                          district,
                                          style: TextStyles.textStyle54,
                                        ),
                                        AutoSizeText(
                                          companyListViewModel.selectedCompany
                                                  .value?.district ??
                                              "",
                                          style: TextStyles.textStyle55,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h1p * .5,
                                    ),
                                    Row(
                                      children: [
                                        AutoSizeText(
                                          state,
                                          style: TextStyles.textStyle54,
                                        ),
                                        AutoSizeText(
                                          companyListViewModel.selectedCompany
                                                  .value?.state ??
                                              "",
                                          style: TextStyles.textStyle55,
                                        ),
                                        SizedBox(
                                          width: w10p * 1.2,
                                        ),
                                        const AutoSizeText(
                                          pin_code,
                                          style: TextStyles.textStyle54,
                                        ),
                                        AutoSizeText(
                                          companyListViewModel.selectedCompany
                                                  .value?.pincode ??
                                              "",
                                          style: TextStyles.textStyle55,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h1p * .5,
                                    ),
                                    Row(
                                      children: [
                                        AutoSizeText(
                                          type_of_business,
                                          style: TextStyles.textStyle54,
                                        ),
                                        AutoSizeText(
                                          companyListViewModel.selectedCompany
                                                  .value?.status ??
                                              "",
                                          style: TextStyles.textStyle55,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h1p * 3,
                          ),

                          GestureDetector(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red, // Background color
                              ),
                              onPressed: () async {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const ConstantText(
                                        text: delete_profile),
                                    content:
                                        const ConstantText(text: are_you_sure),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const ConstantText(
                                          text: cancel,
                                          style: TextStyle(
                                              color: Colours.tangerine),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          context.showLoader();
                                          isDelete =
                                              await getIt<ProfileManager>()
                                                  .deleteProfile();
                                          context.hideLoader();
                                          isDelete == true
                                              ? showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const ConstantText(
                                                        text: consent_msg),
                                                    content: const ConstantText(
                                                        text:
                                                            consent_message_while_deleting_account),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () async {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  user_account_deleted,
                                                              textColor:
                                                                  Colors.white);
                                                          await FirebaseMessaging
                                                              .instance
                                                              .deleteToken();

                                                          Navigator.pushNamed(
                                                              context,
                                                              getStarted);
                                                          // Navigator.pushNamed(context, login);

                                                          // context.showLoader();
                                                          // Navigator.pushNamed(
                                                          //     context,
                                                          //     getStarted);
                                                          // // isDelete = await getIt<
                                                          // //         ProfileManager>()
                                                          // //     .deleteProfile(
                                                          // //         uId);
                                                          // context.hideLoader();
                                                          // if (isDelete) {
                                                          //   Fluttertoast.showToast(
                                                          //       msg:
                                                          //           "User Account Deleted!",
                                                          //       textColor:
                                                          //           Colors
                                                          //               .white);
                                                          //   await FirebaseMessaging
                                                          //       .instance
                                                          //       .deleteToken();

                                                          // Navigator.pushNamed(context, login);
                                                          // }
                                                        },
                                                        child:
                                                            const ConstantText(
                                                          text: ok,
                                                          style: TextStyle(
                                                              color: Colours
                                                                  .tangerine),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const ConstantText(
                                                        text: consent_msg),
                                                    content: const ConstantText(
                                                        text:
                                                            //   'Please clear the payments before deleting the profile.'),
                                                            consent_message_cannot_delete_due_to_outstanding_amount),
                                                    actions: <Widget>[
                                                      // TextButton(
                                                      //   onPressed: () =>
                                                      //       Navigator.pop(
                                                      //           context,
                                                      //           'Cancel'),
                                                      //   child: const ConstantText(
                                                      // text:
                                                      //     'Cancel',
                                                      //     style: TextStyle(
                                                      //         color: Colours
                                                      //             .tangerine),
                                                      //   ),
                                                      // ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          //context.showLoader();
                                                          Navigator.pushNamed(
                                                              context, landing);
                                                          // isDelete = await getIt<
                                                          //         ProfileManager>()
                                                          //     .deleteProfile(uId);
                                                          // context.hideLoader();
                                                          // if (isDelete) {
                                                          //   Fluttertoast.showToast(
                                                          //       msg:
                                                          //           "User Account Deleted!",
                                                          //       textColor: Colors.white);
                                                          //   await FirebaseMessaging
                                                          //       .instance
                                                          //       .deleteToken();
                                                          //   Navigator.pushNamed(
                                                          //       context, getStarted);
                                                          // Navigator.pushNamed(context, login);
                                                          //}
                                                        },
                                                        child:
                                                            const ConstantText(
                                                          text: ok,
                                                          style: TextStyle(
                                                              color: Colours
                                                                  .tangerine),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                        },
                                        child: const ConstantText(
                                          text: ok,
                                          style: TextStyle(
                                              color: Colours.tangerine),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const ConstantText(
                                text: delete,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          )
                        ]),
                      ))),
            ]);
          })));
    });
  }
}

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox();
  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          //    width: 350,
          height: 110,
          decoration: const BoxDecoration(
              color: Colours.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 33),
                child: Row(
                  children: [
                    ImageFromAssetPath<Widget>(
                            assetPath: ImageAssetpathConstant.tickMark)
                        .imageWidget,
                    const SizedBox(
                      width: 19,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ConstantText(
                          text: your_changes_have_been_aved,
                          style: TextStyles.textStyle70,
                        ),
                        // ConstantText(
                        //   text: saved,
                        //   style: TextStyles.textStyle70,
                        // ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 60,
                  color: Colours.charcoalGrey,
                  child: const Center(
                    child: ConstantText(
                      text: close,
                      style: TextStyles.textStyle2,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
