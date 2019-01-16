import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/model/district.dart';
import 'package:flutter/foundation.dart';

class DistrictRepository implements IDistrictRepository {
  @override
  Future<List<District>> fetchDistricts(int provinceId) async {
    http.Response response = await http.get(API_BASE_URL + "districts/with/province/" + provinceId.toString());

    return compute(parseDistricts, response.body);
  }
}

List<District> parseDistricts(String responseBody) {
  final Map exMap = JsonCodec().decode(responseBody);

  List<District> ex = (exMap['message'] as List).map((e) => District.fromJson(e)).toList();
  if (ex == null) {
    throw new Exception("An error occurred : [ Status Code = ]");
  }
  return ex;
}
