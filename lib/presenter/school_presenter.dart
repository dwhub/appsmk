import 'package:kurikulumsmk/model/school.dart';
import 'package:kurikulumsmk/repository/school_repository.dart';

abstract class SchoolsListViewContract {
  void onSchools(List<School> schools);
  void onLoadSchoolsError();
}

class SchoolListPresenter {
  final SchoolsListViewContract schoolListViewContract;
  SchoolRepository schoolRepository;

  SchoolListPresenter(this.schoolListViewContract) {
    schoolRepository = SchoolRepository();
  }

  void loadSchools() {
    schoolRepository
        .fetchSchools(1, 5)
        .then((schools) => schoolListViewContract.onSchools(schools.schools))
        .catchError((onError) => schoolListViewContract.onLoadSchoolsError());
  }
}