import 'package:flutter/material.dart';

class ClosedScreen extends StatefulWidget {
  const ClosedScreen({Key? key}) : super(key: key);

  @override
  State<ClosedScreen> createState() => _ClosedScreenState();
}

class _ClosedScreenState extends State<ClosedScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ListView(
        children: [
          // AllPaymentHistory(),
          // AllPaymentHistory(),
          // AllPaymentHistory()
          //   ClosedWidget(maxWidth: maxWidth, maxHeight: maxHeight,amount: "12,345",day: "30.Aug.2022",companyName: "Company Name",),
          //   ClosedSavedWidget(maxWidth: maxWidth, maxHeight: maxHeight, amount:  "12,345", day: "30.Aug.2022",SAmount: "545",companyName: "Company Name"),
          //   ClosedWidget(maxWidth: maxWidth, maxHeight: maxHeight,amount: "12,345",day: "30.Aug.2022",companyName: "Company Name",),
        ],
      );
    });
  }
}
