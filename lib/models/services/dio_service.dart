import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../logic/view_models/auth_manager.dart';
import '../../util/common/endPoints_constant.dart';
import '../../util/common/string_constants.dart';

class DioClient extends GetxController {
  AuthManager authManager = Get.put(AuthManager());
  static const String baseUrl = baseUATUrl;

  final String launchUrl = launchXUrl;
  final String contactUrl = getContactUsUrl;
  static final dio = Dio.Dio();

  static Future<String> downloadFileFromUrlAndStoreInLocalStorage(
      {required String fileURL}) async {
    Dio.Response value = await dio.get(fileURL);

    Directory directory = await getApplicationDocumentsDirectory();
    String filePathToSave =
        directory.path + "/" + fileURL.split("?").first.split("/").last;

    if (!(await Directory(filePathToSave).exists())) {
      await File(filePathToSave).create();
      await File(filePathToSave).writeAsString(value.data);
      Fluttertoast.showToast(msg: file_downloaded_successfully);
    }
    return filePathToSave;
  }

  Future<Map<String, dynamic>?> get(
    String endUrl, [
    Map<String, dynamic>? body,
  ]) async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    String url = baseUrl + endUrl;
    try {
      String? token = authManager.userDetails?.value?.token ?? null;
      debugPrint(token ?? "");
      if (token == null) {
        Dio.Response response = await dio.request(
          url,
          options: Dio.Options(
            method: 'GET',
          ),
          data: body,
        );

        return response.data;
      } else {
        // Map responseMap = {};
        Dio.Response response = await dio.get(url,
            options: Dio.Options(
                validateStatus: (status) {
                  if (status == 200 || status == 440 || status == 202) {
                    return true;
                  } else {
                    return false;
                  }
                },
                headers: {'Authorization': 'Bearer $token'}));

        if (response.data == null) {
          return response.data;
        }
        if (response.statusCode == 440) {
          Map<String, dynamic> responseMap = response.data;
          responseMap.addEntries([MapEntry("statusCode", 440)]);
        }
        return response.data;
      }
    } on Dio.DioError catch (e) {
      print(e);
      return null;
    }
  }

  postFormData(String endUrl, Map<String, dynamic> data) async {
    Dio.BaseOptions options = new Dio.BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    String url = baseUrl + endUrl;
    var dio = Dio.Dio(options);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {
      String? token = authManager.userDetails?.value?.token ?? null;
      if (token == null) {
        Dio.Response response =
            await dio.post(url, data: Dio.FormData.fromMap(data));

        return response.data;
      }
      Dio.Response response = await dio.post(url,
          data: Dio.FormData.fromMap(data),
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));

      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> post(
      String endUrl, Map<String, dynamic> data) async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    String url = baseUrl + endUrl;
    try {
      String? token = authManager.userDetails?.value?.token ?? null;
      if (token == null) {
        Dio.Response response = await dio.post(url, data: data);
        if (response.statusCode != 200) {
          Fluttertoast.showToast(msg: response.data["message"].toString());
          return null;
        }
        return response.data;
      }
      Dio.Response response = await dio.post(url,
          data: data,
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data;
    } catch (e) {
      Fluttertoast.showToast(
          msg: ((e as DioError).response?.data["message"] ?? "").toString());
      print("catch the expression");
      return null;
    }
  }

  put(endUrl, data) async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    String url = baseUrl + endUrl;
    try {
      String? token = authManager.userDetails?.value?.token ?? null;
      if (token == null) {
        Dio.Response response = await dio.put(url, data: data);
        return response.data;
      }
      Dio.Response response = await dio.put(url,
          data: data,
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data;
    } catch (e) {}
  }

  Future<dynamic> patch(
    endUrl,
    data,
  ) async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    String url = baseUrl + endUrl;

    try {
      String? token = authManager.userDetails?.value?.token ?? null;
      if (token == null) {
        Dio.Response response = await dio.patch(url, data: data);
        return response.data;
      }

      Dio.Response response = await dio.patch(url,
          data: data,
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data;
    } catch (e) {}
  }

  //delete ----
  Future<dynamic> delete(
    endUrl,
    data,
  ) async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    String url = baseUrl + endUrl;

    try {
      String? token = authManager.userDetails?.value?.token ?? null;
      if (token == null) {
        Dio.Response response = await dio.delete(url, data: data);
        return response.data;
      }

      Dio.Response response = await dio.delete(url,
          data: data,
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      return response;
    } catch (e) {}
  }

  aadhaar_captured_data(String endUrl, Map<String, dynamic> data) async {
    Dio.BaseOptions options = new Dio.BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    var dio = Dio.Dio(options);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    String url = baseUrl + endUrl;
    try {
      String? token = authManager.userDetails?.value?.token ?? null;
      if (token == null) {
        Dio.Response response =
            await dio.post(url, data: Dio.FormData.fromMap(data));
        print('URL11111 -----> $url');
        return response.data;
      }
      Dio.Response response = await dio.post(url,
          data: Dio.FormData.fromMap(data),
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: aadhar_api_successful,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Color.fromARGB(255, 253, 153, 33),
            textColor: Colors.white,
            fontSize: 12.0);
      }
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future transactionLedgerNetwork(String? companyid) async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    String? token = authManager.userDetails?.value?.token ?? "";

    String endUrl = transactionLedger(
        companyId:
            companyid); // "/ledger/companies/transaction_ledger?buyer=$companyId";
    String url = baseUrl + endUrl;
    // final uri = Uri.parse(url);

    // try {
    //   print(token.toString());
    // if (token == null) {
    //   Response response = await dio.get(url);
    //   return response.data;
    // }
    // if (token != null) {
    Dio.Response response = await dio.get(url,
        options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
    final data = response.data;
    return data;
    // }

    // catch (e) {
    //   return nul;
    // }
  }

  Future transactionStatementInv(String? companyid) async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    String endUrl = transactionStatment(companyId: companyid);
    // '/ledger/statement/buyer/$companyid';
    String? token = authManager.userDetails?.value?.token ?? "";

    String url = baseUrl + endUrl;
    // final uri = Uri.parse(url);

    //   Response response = await dio.get(url);
    // try {
    //   print(token.toString());
    // if (token == null) {
    //   return response.data;
    // }
    // if (token != null) {
    Dio.Response response = await dio.get(url,
        options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
    final data = response.data;
    return data;
    // }

    // catch (e) {
    //   return nul;
    // }
  }

  pan_captured_data(String url, Map<String, dynamic> data) async {
    Dio.BaseOptions options = new Dio.BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    var dio = Dio.Dio(options);

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {
      String? token = authManager.userDetails?.value?.token ?? null;
      if (token == null) {
        Dio.Response response =
            await dio.post(url, data: Dio.FormData.fromMap(data));

        return response.data;
      }
      print('=== $url $token $data');
      Dio.Response response = await dio.post(url,
          data: Dio.FormData.fromMap(data),
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(
        //     msg: 'Pan api successful....',
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Color.fromARGB(255, 253, 153, 33),
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      }
      print(response);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  // pan verify
  verify_pan(
    String url,
    Map<String, dynamic> data,
  ) async {
    Dio.BaseOptions options = new Dio.BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    var dio = Dio.Dio(options);

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {
      String? token = authManager.userDetails?.value?.token ?? null;
      if (token == null) {
        Dio.Response response =
            await dio.post(url, data: Dio.FormData.fromMap(data));

        return response.data;
      }
      Dio.Response response = await dio.post(url,
          data: Dio.FormData.fromMap(data),
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(
        //     msg: 'Pan api successful....',
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Color.fromARGB(255, 253, 153, 33),
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      }
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  mobile_verfication(
    String url,
    Object data,
  ) async {
    Dio.BaseOptions options = new Dio.BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    var dio = Dio.Dio(options);
    try {
      String? token = authManager.userDetails?.value?.token ?? null;
      if (token == null) {
        Dio.Response response = await dio.post(url, data: data);

        return response.data;
      }
      Dio.Response response = await dio.post(url,
          data: data,
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(
        //     msg: 'generate otp successful....',
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Color.fromARGB(255, 253, 153, 33),
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      }
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  otp_verfication(
    String url,
    Object data,
  ) async {
    Dio.BaseOptions options = new Dio.BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    var dio = Dio.Dio(options);
    try {
      String? token = authManager.userDetails?.value?.token ?? null;
      if (token == null) {
        Dio.Response response = await dio.post(url, data: data);

        return response.data;
      }
      Dio.Response response = await dio.post(url,
          data: data,
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(
        //     msg: 'otp verified successful....',
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Color.fromARGB(255, 253, 153, 33),
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      }
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  getCaptcha(
    String endUrl,
  ) async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    String url = baseUrl + endUrl;
    try {
      String? token = authManager.userDetails?.value?.token ?? null;
      print(token.toString());
      if (token == null) {
        Dio.Response response = await dio.get(url);
        return response.data;
      }
      Dio.Response response = await dio.get(url,
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data;
    } catch (e) {
      // print(e);
    }
  }

  aadhaar_otp(String url, Map<String, dynamic> data) async {
    Dio.BaseOptions options = new Dio.BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    var dio = Dio.Dio(options);
    try {
      String? token = authManager.userDetails?.value?.token ?? null;
      if (token == null) {
        Dio.Response response =
            await dio.post(url, data: Dio.FormData.fromMap(data));

        return response.data;
      }
      Dio.Response response = await dio.post(url,
          data: data,
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(
        //     msg: 'otp verified successful....',
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Color.fromARGB(255, 253, 153, 33),
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      }
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  aadhaar_otp_verify(String url, Object data) async {
    Dio.BaseOptions options = new Dio.BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    var dio = Dio.Dio(options);
    try {
      String? token = authManager.userDetails?.value?.token ?? null;
      if (token == null) {
        Dio.Response response = await dio.post(url, data: data);

        return response.data;
      }
      Dio.Response response = await dio.post(url,
          data: data,
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        print("OTP Verified...");
        Fluttertoast.showToast(
            msg: otp_verified,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Color.fromARGB(255, 253, 153, 33),
            textColor: Colors.white,
            fontSize: 12.0);
      }
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
