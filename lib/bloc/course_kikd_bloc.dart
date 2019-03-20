import 'dart:async';

import 'package:kurikulumsmk/event/course_event_args.dart';
import 'package:kurikulumsmk/model/course_group.dart';
import 'package:kurikulumsmk/model/course_kikd.dart';
import 'package:kurikulumsmk/repository/course_repository.dart';
import 'package:rxdart/rxdart.dart';

class CourseKIKDBloc {
  final CourseGroup courseGroup = CourseGroup();
  final CourseRepository courseRepository;

  List<CourseGroup> courseGroupData = List<CourseGroup>();
  List<CourseKIKD> courseKIKDData = List<CourseKIKD>();

  Stream<List<CourseGroup>> _courseGroups = Stream.empty();
  Stream<List<CourseKIKD>> _courseKIKDs = Stream.empty();
  Stream<CourseGroup> _courseGroupValueChanged = Stream.empty();

  Stream<List<CourseGroup>> get courseGroups => _courseGroups;
  Stream<List<CourseKIKD>> get courseKIKDs => _courseKIKDs;
  Stream<CourseGroup> get courseGroupValueChanged => _courseGroupValueChanged;

  CourseGroup selectedCourseGroup;
  int competencyId;

  // Input sink
  ReplaySubject _loadCourseGroup = ReplaySubject();
  ReplaySubject<CourseKIKDEventArgs> _loadCourseKIKD = ReplaySubject<CourseKIKDEventArgs>();
  ReplaySubject<CourseGroup> _courseGroupChanged = ReplaySubject<CourseGroup>();

  Sink get loadCourseGroup => _loadCourseGroup;
  Sink<CourseKIKDEventArgs> get loadCourseKIKD => _loadCourseKIKD;
  Sink<CourseGroup> get courseGroupChanged => _courseGroupChanged;

  CourseKIKDBloc(this.courseRepository) {
    _courseGroups = _loadCourseGroup.asyncMap(courseGroup.getData).asBroadcastStream();
    _courseKIKDs = _loadCourseKIKD.asyncMap(courseRepository.fetchCourseKIKDs).asBroadcastStream();
    _courseGroupValueChanged = _courseGroupChanged.asyncMap(courseGroupIsChanged).asBroadcastStream();
  }

  void dispose() {
    _loadCourseGroup.close();
    _loadCourseKIKD.close();
    _courseGroupChanged.close();
  }

  void reset() {
    selectedCourseGroup = null;
    courseGroupData = List<CourseGroup>();
    courseKIKDData = List<CourseKIKD>();
  }

  Future<CourseGroup> courseGroupIsChanged(CourseGroup value) async {
    selectedCourseGroup = value;
    loadCourseKIKD.add(CourseKIKDEventArgs(competencyId, value.id));
    return value;
  }
}