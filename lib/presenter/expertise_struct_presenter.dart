import 'package:kurikulumsmk/model/expertise_structure.dart';
import 'package:kurikulumsmk/repository/expertise_structure_repository.dart';

abstract class ExpertiseStructureListViewContract {
  void onExpertiseStructures(List<ExpertiseStructure> expertiseStructure);
  void onLoadExpertiseStructureError();
}

class ExpertiseStructurePresenter {
  final ExpertiseStructureListViewContract expertiseStructureListViewContract;
  ExpertiseStructureRepository expertiseStructureRepository;

  ExpertiseStructurePresenter(this.expertiseStructureListViewContract) {
    expertiseStructureRepository = ExpertiseStructureRepository();
  }

  void loadSchools() {
    expertiseStructureRepository
        .fetchExpertiseStructures()
        .then((ex) => expertiseStructureListViewContract.onExpertiseStructures(ex))
        .catchError((onError) => expertiseStructureListViewContract.onLoadExpertiseStructureError());
  }
}