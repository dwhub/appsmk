import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/model/expertise_competency.dart';

class ExpertiseCompetencyRepository implements IExpertiseCompetencyRepository {
  @override
  Future<List<ExpertiseCompetency>> fetchExpertiseCompetencies(int programId) async {
    http.Response response = await http.get(API_BASE_URL + "expertiseCompetencies/with/expertiseProgram/" + programId.toString());

    final Map exMap = JsonCodec().decode(response.body);

    List<ExpertiseCompetency> ex = (exMap['message'] as List).map((e) => ExpertiseCompetency.fromJson(e)).toList();
    if (ex == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return ex;
  }
}

abstract class IExpertiseCompetencyRepository {
  Future<List<ExpertiseCompetency>> fetchExpertiseCompetencies(int programId);
}

class FetchExpertiseCompetencyException implements Exception {
  final _message;

  FetchExpertiseCompetencyException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}