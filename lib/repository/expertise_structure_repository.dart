import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/model/expertise_structure.dart';

class ExpertiseStructureRepository implements IExpertiseStructureRepository {
  @override
  Future<List<ExpertiseStructure>> fetchExpertiseStructures(dynamic flag) async {
    http.Response response = await http.get(API_BASE_URL + "expertiseFields/curriculumStructure");

    final Map exMap = JsonCodec().decode(response.body);

    List<ExpertiseStructure> ex = (exMap['message'] as List).map((e) => ExpertiseStructure.fromJson(e)).toList();

    if (ex == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return ex;
  }
}

abstract class IExpertiseStructureRepository {
  Future<List<ExpertiseStructure>> fetchExpertiseStructures(dynamic flag);
}

class FetchExpertiseStructureException implements Exception {
  final _message;

  FetchExpertiseStructureException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}