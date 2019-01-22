import 'package:kurikulumsmk/event/course_duration_event_args.dart';
import 'package:kurikulumsmk/model/course_allocation.dart';
import 'package:kurikulumsmk/model/course_group.dart';
import 'package:kurikulumsmk/repository/course_repository.dart';
import 'package:rxdart/rxdart.dart';

class CourseAllocationBloc {
  final CourseGroup courseGroup = CourseGroup();
  final CourseRepository courseRepository;

  List<CourseGroup> courseGroupData = List<CourseGroup>();
  List<CourseAllocation> courseAllocationData = List<CourseAllocation>();

  Stream<List<CourseGroup>> _courseGroups = Stream.empty();
  Stream<List<CourseAllocation>> _courseAllocations = Stream.empty();
  Stream<CourseGroup> _courseGroupValueChanged = Stream.empty();

  Stream<List<CourseGroup>> get courseGroups => _courseGroups;
  Stream<List<CourseAllocation>> get courseAllocations => _courseAllocations;
  Stream<CourseGroup> get courseGroupValueChanged => _courseGroupValueChanged;

  CourseGroup selectedCourseGroup;
  int competencyId;

  // Input sink
  ReplaySubject _loadCourseGroup = ReplaySubject();
  ReplaySubject<CourseAllocationEventArgs> _loadCourseAllocation = ReplaySubject<CourseAllocationEventArgs>();
  ReplaySubject<CourseGroup> _courseGroupChanged = ReplaySubject<CourseGroup>();

  Sink get loadCourseGroup => _loadCourseGroup;
  Sink<CourseAllocationEventArgs> get loadCourseAllocation => _loadCourseAllocation;
  Sink<CourseGroup> get courseGroupChanged => _courseGroupChanged;

  CourseAllocationBloc(this.courseRepository) {
    _courseGroups = _loadCourseGroup.asyncMap(courseGroup.getData).asBroadcastStream();
    _courseAllocations = _loadCourseAllocation.asyncMap(courseRepository.fetchCourseAllocations).asBroadcastStream();
    _courseGroupValueChanged = _courseGroupChanged.asyncMap(courseGroupIsChanged).asBroadcastStream();
  }

  void dispose() {
    _loadCourseGroup.close();
    _loadCourseAllocation.close();
    _courseGroupChanged.close();
  }

  void reset() {
    selectedCourseGroup = null;
    courseGroupData = List<CourseGroup>();
    courseAllocationData = List<CourseAllocation>();
  }

  Future<CourseGroup> courseGroupIsChanged(CourseGroup value) async {
    selectedCourseGroup = value;
    loadCourseAllocation.add(CourseAllocationEventArgs(competencyId, value.id));
    return value;
  }
}