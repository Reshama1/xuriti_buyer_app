import 'package:flutter/material.dart';
import 'package:xuriti/ui/screens/starting_screens/splash_screen.dart';

import '../../new modules/common_widget.dart';
import '../../new modules/image_assetpath_constants.dart';
import '../../util/common/string_constants.dart';
import '../../util/common/text_constant_widget.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageFromAssetPath<Widget>(
              assetPath: ImageAssetpathConstant
                  .noInternet, // Replace with your own image path
              width: 120,
              height: 120,
            ).imageWidget,
            SizedBox(height: 24),
            ConstantText(
              text: no_internet_connection,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ConstantText(
              text: pleaseCheckYourConnection,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    Color(0xffff8a00), // Text Color (Foreground color)
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SplashScreen()));
              },
              child: ConstantText(text: try_again),
            ),
          ],
        ),
      ),
    );
  }
}
