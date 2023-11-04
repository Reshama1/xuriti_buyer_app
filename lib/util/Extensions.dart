import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:xuriti/util/common/enum_constants.dart';

import 'package:xuriti/util/common/string_constants.dart';

import '../models/helper/service_locator.dart';
import 'GreetMessageModel/greetMessageModel.dart';
import 'common/key_value_sharedpreferences.dart';
import 'package:easy_localization/easy_localization.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regEx = RegExp(r"^\d*\.?\d*");
    String newString = regEx.stringMatch(newValue.text) ?? "";
    return newString == newValue.text ? newValue : oldValue;
  }
}

extension CurrencyFormatter on String {
  String setCurrencyFormatter() {
    NumberFormat formatter =
        NumberFormat.currency(symbol: "₹ ", locale: "en_IN", decimalDigits: 2);

    String returnValue = formatter
        .format((double.tryParse(this) != null ? double.parse(this) : 0.0));

    if (returnValue.contains("-₹")) {
      returnValue = returnValue.replaceAll("-₹", "₹ -");
    }
    return returnValue;
  }

  DateTime? getDateInRequiredFormat({required String requiredFormat}) {
    if (this.isEmpty) {
      return null;
    }
    String? parsingDateString;

    if (this.contains("T") || this.contains("Z")) {
      DateTime parsingDate = DateTime.parse(this);
      parsingDateString = DateFormat(requiredFormat).format(parsingDate);
    }
    try {
      DateTime dateTime =
          DateFormat(requiredFormat).parse(parsingDateString ?? this);
      return dateTime;
    } catch (e) {
      return null;
    }
  }
}

extension DateFormatterAndCalculator on DateTime {
  bool checkDateIsAfter({required DateTime? dateValue}) {
    if (dateValue == null) {
      return false;
    }
    return this.isAfter(dateValue);
  }

  String? parseDateIn({required String requiredFormat}) {
    return DateFormat(requiredFormat).format(this);
  }

  Future<GreetAssetDimensionsAndMessage?> getGreetMessage(
      {required bool checkLastTimeStamp}) async {
    String? lastGreetDateTime = await getIt<SharedPreferences>()
        .getString(SharedPrefKeyValue.greetTimeStampShownAt);
    if (checkLastTimeStamp == true) {
      if (lastGreetDateTime != null && lastGreetDateTime.isNotEmpty) {
        DateTime greetedDateTime = DateTime.parse(lastGreetDateTime);
        if (greetedDateTime.difference(DateTime.now()).inDays == 0) {
          if ((this.hour >= 5 && (this.hour < 12)) &&
              (greetedDateTime.hour >= 5 && (greetedDateTime.hour < 12))) {
            return null;
          } else if ((this.hour >= 12 && this.hour < 16) &&
              (greetedDateTime.hour >= 12 && greetedDateTime.hour <= 17)) {
            return null;
          } else if ((this.hour >= 16 && this.hour <= 24) &&
              (greetedDateTime.hour >= 16 && greetedDateTime.hour <= 24)) {
            return null;
          }
        }
      }
    }

    if (this.hour >= 5 && (this.hour < 12)) {
      return GreetAssetDimensionsAndMessage(
        asset: "assets/lottie/greet/morning.json",
        message: Get.context?.tr(good_morning) ?? "",
        subTitle: i_hope_you_have_a_wonderful_day,
      );
    } else if (this.hour >= 12 && this.hour < 16) {
      return GreetAssetDimensionsAndMessage(
        asset: "assets/lottie/greet/afternoon.json",
        message: Get.context?.tr(good_afternoon) ?? "",
        subTitle: good_better_best_never_let_it_rest,
      );
    } else if (this.hour >= 16 && this.hour <= 24) {
      return GreetAssetDimensionsAndMessage(
        asset: "assets/lottie/greet/Evening.json",
        message: Get.context?.tr(good_evening) ?? "",
        subTitle: i_hope_you_had_a_good_and_productive_day,
      );
    }
    return null;
  }
}

extension DoubleExtension on dynamic {
  double getDoubleValue() {
    return double.tryParse(this.toString()) != null
        ? (double.parse(this.toString()).isNaN
            ? 0.0
            : double.parse(this.toString()))
        : 0.0;
  }
}

// Locale("hi", "IN")
// enum Languages { English, Hindi }

extension LocalLanguageCode on Languages {
  static Locale getLocalCode({required Languages languages}) {
    switch (languages) {
      case Languages.English:
        return Locale("en", "US");
      case Languages.Hindi:
        return Locale("hi", "IN");
      // default:
      //   return Locale();
    }
    // return Locale("hi", "IN")
  }

  static String getLanguageLetter({required String languages}) {
    switch (languages) {
      case 'English':
        return 'assets/images/english-letter-a.svg';
      case 'Hindi':
        return 'assets/images/hindi-letter.svg';
      default:
        return '';
    }
  }
}

// class GetLocalLanguageCode {
//   static Locale getLocalLanguageValue(Languages) {
//     switch (this) {
//       case Languages.English:
//         return Locale("en", "US");
//       case Languages.Hindi:
//         return Locale("hi", "IN");
//       // default:
//       //   return Locale();
//     }
//     return Locale("en", "US");
//   }
// }
