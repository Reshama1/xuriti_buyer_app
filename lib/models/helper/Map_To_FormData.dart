import 'package:dio/dio.dart';

class MapToFormData {
  mapToFormData(Map<String, dynamic> map) {
    FormData data = FormData.fromMap(map);
    return data;
  }
}
