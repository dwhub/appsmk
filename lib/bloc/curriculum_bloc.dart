import 'dart:async';
import 'package:kurikulumsmk/model/expertise_structure.dart';
import 'package:kurikulumsmk/repository/expertise_structure_repository.dart';
import 'package:rxdart/rxdart.dart';

class CurriculumBloc {
  final ExpertiseStructureRepository expertiseStructureRepo;
  String searchText;

  // Loaded data
  List<ExpertiseStructure> expertiseStructureData = List<ExpertiseStructure>();
  List<ExpertiseStructure> filteredData = List<ExpertiseStructure>();
  List<ExpertiseStructure> viewData = List<ExpertiseStructure>();

  // Data Streams
  Stream<List<ExpertiseStructure>> _expStructures = Stream.empty();
  Stream<List<ExpertiseStructure>> _searchValueChanged = Stream.empty();

  Stream<List<ExpertiseStructure>> get expertiseStructures => _expStructures;
  Stream<List<ExpertiseStructure>> get searchValueChanged => _searchValueChanged;

  // Input sink
  ReplaySubject _loadExpertiseStructure = ReplaySubject();
  ReplaySubject<String> _searchExpertise = ReplaySubject<String>();

  Sink get loadExpertiseStructure => _loadExpertiseStructure;
  Sink<String> get searchExpertise => _searchExpertise;

  CurriculumBloc(this.expertiseStructureRepo) {
    _expStructures = _loadExpertiseStructure.asyncMap(fetchFixedExpertiseStructures).asBroadcastStream();
    _searchValueChanged = _searchExpertise.asyncMap(searchExpertiseChanged).asBroadcastStream();
  }

  void dispose() {
    _loadExpertiseStructure.close();
    _searchExpertise.close();
  }

  void reset() {
    resetExpertiseStructureData();
    filteredData = List<ExpertiseStructure>();
    viewData = List<ExpertiseStructure>();
    searchText = '';
  }

  void resetExpertiseStructureData() {
    expertiseStructureData = List<ExpertiseStructure>();
  }

  Future<List<ExpertiseStructure>> searchExpertiseChanged(String value) async {
    filteredData = List<ExpertiseStructure>();
    searchText = value;
    
    if (value.isNotEmpty) {
      for (var item in expertiseStructureData) {
        for (var program in item.children) {
          for (var competency in program.children) {
            if (competency.name.toLowerCase().contains(value.toLowerCase())) {
              filteredData.add(competency);
            }
          }
        }
      }
    }

    return filteredData;
  }

  Future<List<ExpertiseStructure>> fetchFixedExpertiseStructures(dynamic flag) async {
    var data = await expertiseStructureRepo.fetchExpertiseStructures(null);
    
    for (var field in data) {
      ExpertiseStructure tmp = ExpertiseStructure(id: field.id, parentId: field.parentId, name: field.name, children: List<ExpertiseStructure>());

      for (var program in field.children) {
        var programTitle = program.name.split(' ');

        ExpertiseStructure progTmp = ExpertiseStructure(id: program.id, 
                                                        parentId: program.parentId, 
                                                        name: program.name, 
                                                        children: List<ExpertiseStructure>(), 
                                                        isProgram: true, 
                                                        isCompetency: false,
                                                        order: programTitle[0],
                                                        title: program.name.replaceFirst(new RegExp(programTitle[0]), '').trim());

        for (var competency in program.children) {
          var compTitle = competency.name.split(' ');

          ExpertiseStructure compTmp = ExpertiseStructure(id: competency.id, 
                                                          parentId: competency.parentId, 
                                                          name: competency.name, 
                                                          children: List<ExpertiseStructure>(), 
                                                          isProgram: true, 
                                                          isCompetency: true,
                                                          order: compTitle[0],
                                                          title: competency.name.replaceFirst(new RegExp(compTitle[0]), '').trim());
        
          progTmp.children.add(compTmp);
        }
        tmp.children.add(progTmp);
      }
      viewData.add(tmp);
    }

    return data;
  }
}