import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/model/expertise_field.dart';

class ExpertiseFieldRepository implements IExpertiseFieldRepository {
  @override
  Future<List<ExpertiseField>> fetchExpertiseFields(dynamic flag) async {
    http.Response response = await http.get(API_BASE_URL + "expertiseFields");

    final Map exMap = JsonCodec().decode(response.body);

    List<ExpertiseField> ex = (exMap['message'] as List).map((e) => ExpertiseField.fromJson(e)).toList();
    if (ex == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return ex;
  }
}

abstract class IExpertiseFieldRepository {
  Future<List<ExpertiseField>> fetchExpertiseFields(dynamic flag);
}

class FetchExpertiseFieldException implements Exception {
  final _message;

  FetchExpertiseFieldException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}