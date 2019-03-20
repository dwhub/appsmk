import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/model/national_education.dart';

class NationalEducationStructureRepository implements INationalEducationStructureRepository {
  @override
  Future<List<NationalEducationStructure>> fetchNationalEducationStructures(dynamic flag) async {
    http.Response response = await http.get(API_BASE_URL + "nes");

    final Map exMap = JsonCodec().decode(response.body);

    List<NationalEducationStructure> ex = (exMap['message'] as List).map((e) => NationalEducationStructure.fromJson(e)).toList();

    if (ex == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return ex;
  }
}

abstract class INationalEducationStructureRepository {
  Future<List<NationalEducationStructure>> fetchNationalEducationStructures(dynamic flag);
}

class FetchNationalEducationStructureException implements Exception {
  final _message;

  FetchNationalEducationStructureException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}