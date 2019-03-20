import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/model/district.dart';

class DistrictRepository implements IDistrictRepository {
  @override
  Future<List<District>> fetchDistricts(int provinceId) async {
    http.Response response = await http.get(API_BASE_URL + "districts/with/province/" + provinceId.toString());

    final Map exMap = JsonCodec().decode(response.body);

    List<District> ex = (exMap['message'] as List).map((e) => District.fromJson(e)).toList();
    if (ex == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return ex;
  }

  @override
  Future<List<SubDistrict>> fetchSubDistricts(int districtId) async {
    http.Response response = await http.get(API_BASE_URL + "subDistricts/with/district/" + districtId.toString());

    final Map exMap = JsonCodec().decode(response.body);

    List<SubDistrict> ex = (exMap['message'] as List).map((e) => SubDistrict.fromJson(e)).toList();
    if (ex == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return ex;
  }
}

abstract class IDistrictRepository {
  Future<List<District>> fetchDistricts(int provinceId);
  Future<List<SubDistrict>> fetchSubDistricts(int districtId);
}

class FetchDistrictException implements Exception {
  final _message;

  FetchDistrictException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}