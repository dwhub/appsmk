import 'dart:async';

import 'package:kurikulumsmk/event/course_event_args.dart';
import 'package:kurikulumsmk/model/course_duration.dart';
import 'package:kurikulumsmk/model/course_group.dart';
import 'package:kurikulumsmk/repository/course_repository.dart';
import 'package:rxdart/rxdart.dart';

class CourseDurationBloc {
  final CourseGroup courseGroup = CourseGroup();
  final CourseRepository courseRepository;

  List<CourseGroup> courseGroupData = List<CourseGroup>();
  List<CourseDuration> courseDurationData = List<CourseDuration>();

  Stream<List<CourseGroup>> _courseGroups = Stream.empty();
  Stream<List<CourseDuration>> _courseDurations = Stream.empty();
  Stream<CourseGroup> _courseGroupValueChanged = Stream.empty();

  Stream<List<CourseGroup>> get courseGroups => _courseGroups;
  Stream<List<CourseDuration>> get courseDurations => _courseDurations;
  Stream<CourseGroup> get courseGroupValueChanged => _courseGroupValueChanged;

  CourseGroup selectedCourseGroup;
  int competencyId;

  // Input sink
  ReplaySubject _loadCourseGroup = ReplaySubject();
  ReplaySubject<CourseDurationEventArgs> _loadCourseDuration = ReplaySubject<CourseDurationEventArgs>();
  ReplaySubject<CourseGroup> _courseGroupChanged = ReplaySubject<CourseGroup>();

  Sink get loadCourseGroup => _loadCourseGroup;
  Sink<CourseDurationEventArgs> get loadCourseDuration => _loadCourseDuration;
  Sink<CourseGroup> get courseGroupChanged => _courseGroupChanged;

  CourseDurationBloc(this.courseRepository) {
    _courseGroups = _loadCourseGroup.asyncMap(courseGroup.getData).asBroadcastStream();
    _courseDurations = _loadCourseDuration.asyncMap(fetchCourseDurations).asBroadcastStream();
    _courseGroupValueChanged = _courseGroupChanged.asyncMap(courseGroupIsChanged).asBroadcastStream();
  }

  void dispose() {
    _loadCourseGroup.close();
    _loadCourseDuration.close();
    _courseGroupChanged.close();
  }

  void reset() {
    selectedCourseGroup = null;
    courseGroupData = List<CourseGroup>();
    courseDurationData = List<CourseDuration>();
  }

  Future<CourseGroup> courseGroupIsChanged(CourseGroup value) async {
    selectedCourseGroup = value;
    loadCourseDuration.add(CourseDurationEventArgs(competencyId, value.id));
    return value;
  }

  Future<List<CourseDuration>> fetchCourseDurations(CourseDurationEventArgs e) async {
    List<CourseDuration> response = await courseRepository.fetchCourseDurations(e);
    List<CourseDuration> result = List<CourseDuration>();

    if (response.length > 0) {
      int x1 = 0;
      int x2 = 0;
      int xi1 = 0;
      int xi2 = 0;
      int xii1 = 0;
      int xii2 = 0;
      int xiii1 = 0;
      int xiii2 = 0;

      for (var item in response) {
        x1 = (item.x1.trim() != "-") ? x1 + int.parse(item.x1) : x1;
        x2 = (item.x2.trim() != "-") ? x2 + int.parse(item.x2) : x2;
        xi1 = (item.xi1.trim() != "-") ? xi1 + int.parse(item.xi1) : xi1;
        xi2 = (item.xi2.trim() != "-") ? xi2 + int.parse(item.xi2) : xi2;
        xii1 = (item.xii1.trim() != "-") ? xii1 + int.parse(item.xii1) : xii1;
        xii2 = (item.xii2.trim() != "-") ? xii2 + int.parse(item.xii2) : xii2;
        xiii1 = (item.xiii1.trim() != "-") ? xiii1 + int.parse(item.xiii1) : xiii1;
        xiii2 = (item.xiii2.trim() != "-") ? xiii2 + int.parse(item.xiii2) : xiii2;

        result.add(item);
      }

      CourseDuration temp = CourseDuration(id: 0, name: "Jumlah", x1: x1.toString(), x2: x2.toString(),
                                            xi1: xi1.toString(), xi2: xi2.toString(), xii1: xii1.toString(), xii2: xii2.toString(),
                                            xiii1: xiii1.toString(), xiii2: xiii2.toString());

      result.add(temp);
    }

    return result;
  }
}