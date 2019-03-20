import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/model/national_exam.dart';

class NationalExamStructureRepository implements INationalExamStructureRepository {
  @override
  Future<List<NationalExamStructure>> fetchNationalExamStructures(dynamic flag) async {
    http.Response response = await http.get(API_BASE_URL + "nationalExams");

    final Map exMap = JsonCodec().decode(response.body);

    List<NationalExamStructure> ex = (exMap['message'] as List).map((e) => NationalExamStructure.fromJson(e)).toList();

    if (ex == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return ex;
  }
}

abstract class INationalExamStructureRepository {
  Future<List<NationalExamStructure>> fetchNationalExamStructures(dynamic flag);
}

class FetchNationalExamStructureException implements Exception {
  final _message;

  FetchNationalExamStructureException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}