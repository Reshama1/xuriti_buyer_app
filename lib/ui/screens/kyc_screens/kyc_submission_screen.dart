import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xuriti/logic/view_models/kyc_manager.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../../util/common/string_constants.dart';
import '../../../util/common/text_constant_widget.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/submitt_button.dart';

class KycSubmission extends StatelessWidget {
  KycSubmission({Key? key}) : super(key: key);
  final KycManager kycManager = Get.put(KycManager());

  @override
  Widget build(BuildContext context) {
    if (kycManager.isKycStatusVerified()) {
      return LayoutBuilder(
        builder: (context, constraints) {
          double maxHeight = constraints.maxHeight;
          double maxWidth = constraints.maxWidth;
          double h1p = maxHeight * 0.01;
          double h10p = maxHeight * 0.1;
          double w10p = maxWidth * 0.1;

          return SafeArea(
            child: Scaffold(
              backgroundColor: Colours.black,
              appBar: AppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  toolbarHeight: h10p * .9,
                  flexibleSpace: AppbarWidget()),
              body: Container(
                width: maxWidth,
                decoration: const BoxDecoration(
                  color: Colours.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: h10p * 2),
                      child: Center(
                          child: ImageFromAssetPath<Widget>(
                                  assetPath: ImageAssetpathConstant.thumbsUp)
                              .imageWidget),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: h1p * 3,
                        ),
                        child: ConstantText(
                          text: thank_you,
                          style: TextStyles.textStyle125,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w10p * 1),
                      child: ConstantText(
                        text: kyc_verification_completed,
                        style: TextStyles.textStyle126,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.pushNamed(context, landing);
                      },
                      child: Submitbutton(
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                        content: back_to_home,
                        isKyc: true,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        double maxHeight = constraints.maxHeight;
        double maxWidth = constraints.maxWidth;
        double h1p = maxHeight * 0.01;
        double h10p = maxHeight * 0.1;
        double w10p = maxWidth * 0.1;

        return SafeArea(
          child: Scaffold(
            backgroundColor: Colours.black,
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              toolbarHeight: h10p * .9,
              flexibleSpace: AppbarWidget(),
            ),
            body: Container(
              width: maxWidth,
              decoration: const BoxDecoration(
                color: Colours.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: ListView(
                children: [
                  Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: h1p * 3,
                    ),
                    child: ConstantText(
                      text: kyc_in_progress,
                      style: TextStyles.textStyle125,
                    ),
                  )),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w10p * 1),
                        child: ConstantText(
                          text: we_received_your_kyc_details,
                          style: TextStyles.textStyle126,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w10p * 1.5),
                        child: ConstantText(
                            text: verification_of_document_take_2to3_days,
                            textAlign: TextAlign.center,
                            style: TextStyles.textStyle126),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w10p * 1),
                        child: ConstantText(
                            text:
                                please_reupload_document_if_verification_failed,
                            textAlign: TextAlign.center,
                            style: TextStyles.textStyle126),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      !(kycManager.isKycStatusVerified())
                          ? Navigator.pushNamed(context, companyList)
                          : Navigator.pushNamed(context, landing);
                    },
                    child: Submitbutton(
                      maxWidth: maxWidth,
                      maxHeight: maxHeight,
                      content: back_to_home,
                      isKyc: true,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.pushNamed(context, kycnextstep);
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: const [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.keyboard_arrow_left_rounded,
                            size: 30,
                          ),
                        ),
                        ConstantText(
                          text: prev,
                          style: TextStyles.textStyle44,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    }
  }
}
