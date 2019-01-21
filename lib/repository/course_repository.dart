import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/event/course_duration_event_args.dart';
import 'package:kurikulumsmk/model/course_duration.dart';

class CourseRepository implements ICourseRepository {
  @override
  Future<List<CourseDuration>> fetchCourseDurations(CourseDurationEventArgs e) async {
    http.Response response = await http.get(API_BASE_URL + "course/duration/with/competency/" + 
                  e.competencyId.toString() + "/group/" + e.groupId.toString());

    final Map exMap = JsonCodec().decode(response.body);

    List<CourseDuration> ex = List<CourseDuration>();

    if (exMap['message'] != null) {
      ex = (exMap['message'] as List).map((e) => CourseDuration.fromJson(e)).toList();
    }
    
    if (ex == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return ex;
  }
}

abstract class ICourseRepository {
  Future<List<CourseDuration>> fetchCourseDurations(CourseDurationEventArgs e);
}

class FetchCourseDurationException implements Exception {
  final _message;

  FetchCourseDurationException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}