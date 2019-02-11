import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/event/course_event_args.dart';
import 'package:kurikulumsmk/model/course_allocation.dart';
import 'package:kurikulumsmk/model/course_book.dart';
import 'package:kurikulumsmk/model/course_duration.dart';
import 'package:kurikulumsmk/model/course_kikd.dart';

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

  @override
  Future<List<CourseAllocation>> fetchCourseAllocations(CourseAllocationEventArgs e) async {
    http.Response response = await http.get(API_BASE_URL + "course/allocation/with/competency/" + 
                  e.competencyId.toString() + "/group/" + e.groupId.toString());

    final Map exMap = JsonCodec().decode(response.body);

    List<CourseAllocation> ex = List<CourseAllocation>();

    if (exMap['message'] != null) {
      ex = (exMap['message'] as List).map((e) => CourseAllocation.fromJson(e)).toList();
    }
    
    if (ex == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return ex;
  }

  @override
  Future<List<CourseKIKD>> fetchCourseKIKDs(CourseKIKDEventArgs e) async {
    http.Response response = await http.get(API_BASE_URL + "course/kikd/with/competency/" + 
                  e.competencyId.toString() + "/group/" + e.groupId.toString());

    final Map exMap = JsonCodec().decode(response.body);

    List<CourseKIKD> ex = List<CourseKIKD>();

    if (exMap['message'] != null) {
      ex = (exMap['message'] as List).map((e) => CourseKIKD.fromJson(e)).toList();
    }
    
    if (ex == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return ex;
  }

  @override
  Future<List<KIKD>> fetchKIKDDetails(KIKDDetailEventArgs e) async {
    http.Response response = await http.get(API_BASE_URL + "course/kikd/detail/with/competency/" + 
                  e.competencyId.toString() + "/course/" + e.courseId.toString());

    final Map exMap = JsonCodec().decode(response.body);

    List<KIKD> ex = List<KIKD>();

    if (exMap['message'] != null) {
      ex = (exMap['message'] as List).map((e) => KIKD.fromJson(e)).toList();
    }
    
    if (ex == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return ex;
  }

  @override
  Future<List<CourseBook>> fetchCourseBooks(CourseBookEventArgs e) async {
    http.Response response = await http.get(API_BASE_URL + "course/book/with/competency/" +
                  e.competencyId.toString() + "/group/" + e.groupId.toString());

    final Map exMap = JsonCodec().decode(response.body);

    List<CourseBook> ex = List<CourseBook>();

    if (exMap['message'] != null) {
      ex = (exMap['message'] as List).map((e) => CourseBook.fromJson(e)).toList();
    }
    
    if (ex == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return ex;
  }

  @override
  Future<List<Course>> fetchCourses(CourseEventArgs e) async {
    http.Response response = await http.get(API_BASE_URL + "course/with/competency/" +
                  e.competencyId.toString() + "/group/" + e.groupId.toString());

    final Map exMap = JsonCodec().decode(response.body);

    List<Course> ex = List<Course>();

    if (exMap['message'] != null) {
      ex = (exMap['message'] as List).map((e) => Course.fromJson(e)).toList();
    }
    
    if (ex == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }
    return ex;
  }
}

abstract class ICourseRepository {
  Future<List<CourseDuration>> fetchCourseDurations(CourseDurationEventArgs e);
  Future<List<CourseAllocation>> fetchCourseAllocations(CourseAllocationEventArgs e);
  Future<List<CourseKIKD>> fetchCourseKIKDs(CourseKIKDEventArgs e);
  Future<List<KIKD>> fetchKIKDDetails(KIKDDetailEventArgs e);
  Future<List<Course>> fetchCourses(CourseEventArgs e);
  Future<List<CourseBook>> fetchCourseBooks(CourseBookEventArgs e);
}

class FetchCourseDurationException implements Exception {
  final _message;

  FetchCourseDurationException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}