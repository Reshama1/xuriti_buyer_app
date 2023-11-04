import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xuriti/new%20modules/Credit_Details/model/Credit_Details.dart';
import 'package:xuriti/ui/screens/bhome_screens/header_widget_for_cred_limit_seller_selection.dart';
import 'package:xuriti/ui/widgets/drawer_widget.dart';
import '../../../logic/view_models/transaction_manager.dart';
import '../../../new modules/Credit_Details/DataRepo/Credit_Details_VM.dart';
import '../../../new modules/common_widget.dart';
import '../../../new modules/image_assetpath_constants.dart';
import '../../theme/constants.dart';

class ProfileWidget extends StatefulWidget {
  ProfileWidget({Key? key, pskey}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  GlobalKey<ScaffoldState> sk = GlobalKey();
  final Credit_Details_VM credit_details_vm = Get.put(Credit_Details_VM());
  final TransactionManager transactionManager = Get.put(TransactionManager());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;

      return Scaffold(
        key: sk,
        endDrawer: DrawerWidget(
          maxHeight: maxHeight,
          maxWidth: maxWidth,
        ),
        body: Container(
          height: maxHeight,
          width: maxWidth,
          color: Colours.black,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 39, left: 25, right: 25),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageFromAssetPath<Widget>(
                            assetPath: ImageAssetpathConstant.xuriti1)
                        .imageWidget,
                  ],
                ),
              ),
              SizedBox(
                height: h1p * 4,
              ),
              HeaderWidgetForCreditLimitAndSellerSelection(
                selectedSeller: (CreditDetails? sellerObj) {},
                showCompanyFilter: true,
              ),
            ],
          ),
        ),
      );
    });
  }
}
