import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/model/expertise_structure.dart';
import 'package:flutter/foundation.dart';

class ExpertiseStructureRepository implements IExpertiseStructureRepository {
  @override
  Future<List<ExpertiseStructure>> fetchExpertiseStructures() async {
    http.Response response = await http.get(API_BASE_URL + "expertiseFields/curriculumStructure");

    return compute(parseExpertiseStructure, response.body);
  }
}

List<ExpertiseStructure> parseExpertiseStructure(String responseBody) {
  final Map exMap = JsonCodec().decode(responseBody);

  List<ExpertiseStructure> ex = (exMap['message'] as List).map((e) => ExpertiseStructure.fromJson(e)).toList();

  if (ex == null) {
    throw new Exception("An error occurred : [ Status Code = ]");
  }
  return ex;
}
