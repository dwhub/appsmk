import 'dart:async';
import 'package:kurikulumsmk/event/school_event_args.dart';
import 'package:kurikulumsmk/model/school.dart';
import 'package:kurikulumsmk/repository/school_repository.dart';
import 'package:kurikulumsmk/utils/constants.dart';
import 'package:rxdart/rxdart.dart';

class SchoolBloc {
  final SchoolRepository schoolRepo;

  LoadMoreStatus loadMoreStatus = LoadMoreStatus.STABLE;
  int selectedSchoolType = 0;

  bool filterVisible = false;

  // Loaded data
  List<School> schoolsData = List<School>();

  // Data Streams
  Stream<Schools> _schools = Stream.empty();
  Stream<String> _log = Stream.empty();
  Stream<bool> _filterSelected = Stream.empty();
  Stream<int> _schoolTypeSelected = Stream.empty();

  Stream<String> get log => _log;
  Stream<Schools> get schools => _schools;
  Stream<bool> get filterSelected => _filterSelected;
  Stream<int> get schoolTypeSelected => _schoolTypeSelected;

  // Input sink
  ReplaySubject<SchoolEventArgs> _loadSchools = ReplaySubject<SchoolEventArgs>();
  ReplaySubject<bool> _showFilter = ReplaySubject<bool>();
  ReplaySubject<int> _schoolTypeChanged = ReplaySubject<int>();

  Sink<SchoolEventArgs> get loadSchools => _loadSchools;
  Sink<bool> get showFilter => _showFilter;
  Sink<int> get schoolTypeChanged => _schoolTypeChanged;

  SchoolBloc(this.schoolRepo) {
    _schools = _loadSchools.asyncMap(schoolRepo.fetchSchools).asBroadcastStream();
    _filterSelected = _showFilter.asyncMap(viewFilter).asBroadcastStream();
    _schoolTypeSelected = _schoolTypeChanged.asyncMap(schoolTypeIsChanged).asBroadcastStream();

    _log = Observable(schools)
        .withLatestFrom(_loadSchools.stream, (_, e) => 'Results for $e')
        .asBroadcastStream();
  }

  void dispose() {
    _loadSchools.close();
    _showFilter.close();
    _schoolTypeChanged.close();
  }

  void reset() {
    resetSchoolsData();
    filterVisible = false;
    selectedSchoolType = 0;
  }

  void resetSchoolsData() {
    schoolsData = List<School>();
  }

  Future<bool> viewFilter(bool value) async {
    filterVisible = value;
    return filterVisible;
  }

  Future<int> schoolTypeIsChanged(int value) async {
    selectedSchoolType = value;
    return selectedSchoolType;
  }
}