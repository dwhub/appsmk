import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/model/province.dart';

class ProvinceRepository implements IProvinceRepository {
  @override
  Future<List<Province>> fetchProvinces(dynamic flag) async {
    http.Response response = await http.get(API_BASE_URL + "provinces");

    final Map exMap = JsonCodec().decode(response.body);

    List<Province> ex = (exMap['message'] as List).map((e) => Province.fromJson(e)).toList();
    if (ex == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return ex;
  }
}

abstract class IProvinceRepository {
  Future<List<Province>> fetchProvinces(dynamic flag);
}

class FetchProvinceException implements Exception {
  final _message;

  FetchProvinceException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}