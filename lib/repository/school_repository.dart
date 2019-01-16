import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/model/school.dart';
import 'package:flutter/foundation.dart';

class SchoolRepository implements ISchoolRepository {
  @override
  Future<Schools> fetchSchools(int pageNumber, int pageSize) async {
    http.Response response = await http.get(API_BASE_URL +
        "schools?page=" +
        pageNumber.toString() + "&pageSize=" + pageSize.toString());
    return compute(parseSchools, response.body);
  }
}

Schools parseSchools(String responseBody) {
  final Map schoolsMap = JsonCodec().decode(responseBody);

  Schools schools = Schools.fromMap(schoolsMap['message']);
  if (schools == null) {
    throw new Exception("An error occurred : [ Status Code = ]");
  }
  return schools;
}
