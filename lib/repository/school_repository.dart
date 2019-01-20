import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/event/school_event_args.dart';
import 'package:kurikulumsmk/model/school.dart';

class SchoolRepository implements ISchoolRepository {
  @override
  Future<Schools> fetchSchools(SchoolEventArgs e) async {
    http.Response response = await http.get(API_BASE_URL +
        "schools?page=" +
        e.page.toString() + "&pageSize=" + e.pageSize.toString());

    final Map schoolsMap = JsonCodec().decode(response.body);

    Schools schools = Schools.fromMap(schoolsMap['message']);
    if (schools == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return schools;
  }
}

abstract class ISchoolRepository {
  Future<Schools> fetchSchools(SchoolEventArgs e);
}

class FetchSchoolsException implements Exception {
  final _message;

  FetchSchoolsException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}
