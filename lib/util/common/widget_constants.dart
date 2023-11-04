import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../ui/theme/constants.dart';

Widget companyStatusToIcon(String? status) {
  switch (status) {
    case 'In-Progress':
      {
        return const Icon(
          Icons.rounded_corner_outlined,
          color: Colors.yellow,
        );
      }
    case 'Approved':
      {
        return const Icon(
          Icons.check_circle_rounded,
          color: Colors.green,
        );
      }
    case 'Rejected':
      {
        return const Icon(
          Icons.cancel_rounded,
          color: Colors.red,
        );
      }
    case 'Inactive':
      {
        return const Icon(
          Icons.remove_circle,
          color: Colors.red,
        );
      }
    case 'Hold':
      {
        return const Icon(
          Icons.access_time_filled,
          color: Colors.orange,
        );
      }
    default:
      {
        print('unknown status of kyc');
        return const Icon(
          Icons.circle_outlined,
          color: Colors.black,
        );
      }
  }
}

PinTheme defaultPinTheme({Color? textColor}) => PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 22, color: textColor ?? Colours.black),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          // border: Border(
          //   bottom: BorderSide(
          //     color: Colors.white,
          //   ),
          // ),
          ),
    );
