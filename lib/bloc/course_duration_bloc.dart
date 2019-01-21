import 'package:kurikulumsmk/event/course_duration_event_args.dart';
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
    _courseDurations = _loadCourseDuration.asyncMap(courseRepository.fetchCourseDurations).asBroadcastStream();
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
}