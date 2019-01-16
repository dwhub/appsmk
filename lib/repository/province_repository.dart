import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/model/province.dart';
import 'package:flutter/foundation.dart';

class ProvinceRepository implements IProvinceRepository {
  @override
  Future<List<Province>> fetchProvinces() async {
    http.Response response = await http.get(API_BASE_URL + "provinces");

    return compute(parseProvinces, response.body);
  }
}

List<Province> parseProvinces(String responseBody) {
  final Map exMap = JsonCodec().decode(responseBody);

  List<Province> ex = (exMap['message'] as List).map((e) => Province.fromJson(e)).toList();
  if (ex == null) {
    throw new Exception("An error occurred : [ Status Code = ]");
  }
  return ex;
}
