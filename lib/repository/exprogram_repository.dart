import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/model/expertise_program.dart';

class ExpertiseProgramRepository implements IExpertiseProgramRepository {
  @override
  Future<List<ExpertiseProgram>> fetchExpertiseProgram(int fieldId) async {
    http.Response response = await http.get(API_BASE_URL + "expertisePrograms/with/expertiseField/" + fieldId.toString());

    final Map exMap = JsonCodec().decode(response.body);

    List<ExpertiseProgram> ex = (exMap['message'] as List).map((e) => ExpertiseProgram.fromJson(e)).toList();
    if (ex == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return ex;
  }
}

abstract class IExpertiseProgramRepository {
  Future<List<ExpertiseProgram>> fetchExpertiseProgram(int fieldId);
}

class FetchExpertiseProgramException implements Exception {
  final _message;

  FetchExpertiseProgramException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}