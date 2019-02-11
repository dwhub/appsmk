import 'package:kurikulumsmk/event/course_event_args.dart';
import 'package:kurikulumsmk/model/course_book.dart';
import 'package:kurikulumsmk/model/course_group.dart';
import 'package:kurikulumsmk/repository/course_repository.dart';
import 'package:rxdart/rxdart.dart';

class CourseBookBloc {
  final CourseGroup courseGroup = CourseGroup();
  final CourseRepository courseRepository;

  List<CourseGroup> courseGroupData = List<CourseGroup>();
  List<Course> courseData = List<Course>();
  List<CourseBook> courseBookData = List<CourseBook>();
  List<CourseBook> filterCourseBookData = List<CourseBook>();

  Stream<List<CourseGroup>> _courseGroups = Stream.empty();
  Stream<List<CourseBook>> _courseBooks = Stream.empty();
  Stream<List<Course>> _courses = Stream.empty();
  Stream<CourseGroup> _courseGroupValueChanged = Stream.empty();
  Stream<Course> _courseValueChanged = Stream.empty();
  Stream<Map<String, bool>> _classValueChanged = Stream.empty();
  Stream<bool> _filterSelected = Stream.empty();

  Stream<List<CourseGroup>> get courseGroups => _courseGroups;
  Stream<List<CourseBook>> get courseBooks => _courseBooks;
  Stream<List<Course>> get courses => _courses;
  Stream<CourseGroup> get courseGroupValueChanged => _courseGroupValueChanged;
  Stream<Course> get courseValueChanged => _courseValueChanged;
  Stream<Map<String, bool>> get classValueChanged => _classValueChanged;
  Stream<bool> get filterSelected => _filterSelected;

  CourseGroup selectedCourseGroup;
  Course selectedCourse;
  Map<String, bool> selectedClass = Map<String, bool>();
  int competencyId;
  bool filterVisible = false;
  bool xSelected = false;
  bool xiSelected = false;
  bool xiiSelected = false;
  bool xiiiSelected = false;

  // Input sink
  ReplaySubject _loadCourseGroup = ReplaySubject();
  ReplaySubject<CourseBookEventArgs> _loadCourseBook = ReplaySubject<CourseBookEventArgs>();
  ReplaySubject<CourseEventArgs> _loadCourse = ReplaySubject<CourseEventArgs>();
  ReplaySubject<CourseGroup> _courseGroupChanged = ReplaySubject<CourseGroup>();
  ReplaySubject<Course> _courseChanged = ReplaySubject<Course>();
  ReplaySubject<Map<String, bool>> _classChanged = ReplaySubject<Map<String, bool>>();
  ReplaySubject<bool> _showFilter = ReplaySubject<bool>();

  Sink get loadCourseGroup => _loadCourseGroup;
  Sink<CourseBookEventArgs> get loadCourseBook => _loadCourseBook;
  Sink<CourseEventArgs> get loadCourse => _loadCourse;
  Sink<CourseGroup> get courseGroupChanged => _courseGroupChanged;
  Sink<Course> get courseChanged => _courseChanged;
  Sink<Map<String, bool>> get classChanged => _classChanged;
  Sink<bool> get showFilter => _showFilter;

  CourseBookBloc(this.courseRepository) {
    _courseGroups = _loadCourseGroup.asyncMap(courseGroup.getData).asBroadcastStream();
    _courseBooks = _loadCourseBook.asyncMap(fetchCourseBooks).asBroadcastStream();
    _courses = _loadCourse.asyncMap(courseRepository.fetchCourses).asBroadcastStream();
    _courseGroupValueChanged = _courseGroupChanged.asyncMap(courseGroupIsChanged).asBroadcastStream();
    _courseValueChanged = _courseChanged.asyncMap(courseIsChanged).asBroadcastStream();
    _classValueChanged = _classChanged.asyncMap(classIsChanged).asBroadcastStream();
    _filterSelected = _showFilter.asyncMap(viewFilter).asBroadcastStream();
  }

  void dispose() {
    _loadCourseGroup.close();
    _loadCourseBook.close();
    _loadCourse.close();
    _courseGroupChanged.close();
    _courseChanged.close();
    _classChanged.close();
    _showFilter.close();
  }

  void reset() {
    selectedCourseGroup = null;
    selectedCourse = null;
    filterVisible = false;
    selectedClass = Map<String, bool>();
    courseGroupData = List<CourseGroup>();
    courseBookData = List<CourseBook>();
    courseData = List<Course>();
    filterCourseBookData = List<CourseBook>();

    xSelected = true;
    xiSelected = true;
    xiiSelected = true;
    xiiiSelected = true;
  }

  Future<CourseGroup> courseGroupIsChanged(CourseGroup value) async {
    selectedCourseGroup = value;
    selectedCourse = null;
    courseData = List<Course>();
    loadCourse.add(CourseEventArgs(competencyId, groupId: value.id));
    return value;
  }

  Future<Course> courseIsChanged(Course value) async {
    selectedCourse = value;
    return value;
  }

  Future<Map<String, bool>> classIsChanged(Map<String, bool> value) async {
    selectedClass = value;
    return selectedClass;
  }

  Future<bool> viewFilter(bool value) async {
    filterVisible = value;
    return filterVisible;
  }

  Future<List<CourseBook>> fetchCourseBooks(CourseBookEventArgs e) async {
    List<CourseBook> result = await courseRepository.fetchCourseBooks(e);

    if (selectedCourse != null) {
      for (var item in result) {
        if (item.courseId == selectedCourse.id) {
          filterCourseBookData.add(item);
        }
      }
      return calculateBSandBG(filterCourseBookData);
    } else {
      return calculateBSandBG(result);
    }
  }

  List<CourseBook> calculateBSandBG(List<CourseBook> e) {
    List<CourseBook> result = List<CourseBook>();

    if (e != null) {
      for (var item in e) {
        int x = (xSelected && item.x != "-") ? int.parse(item.x) : 0;
        int xi = (xiSelected && item.xi != "-") ? int.parse(item.xi) : 0;
        int xii = (xiiSelected && item.xii != "-") ? int.parse(item.xii) : 0;
        int xiii = (xiiiSelected && item.xiii != "-") ? int.parse(item.xiii) : 0;

        int bs = x + xi + xii + xiii;
        int bg = x + xi + xii + xiii;
        int total = bs + bg;

        result.add(CourseBook(competencyId: item.competencyId, id: item.id, courseId: item.courseId,
                              name: item.name, studentBook: bs, teacherBook: bg, total: total, x: x.toString(), 
                              xi: xi.toString(), xii: xii.toString(), xiii: xiii.toString()));
      }

      return result;
    } else {
      return result;
    }
  }
}