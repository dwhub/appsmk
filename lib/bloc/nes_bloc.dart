import 'dart:async';
import 'package:kurikulumsmk/model/national_education.dart';
import 'package:kurikulumsmk/repository/neducation_structure_repository.dart';
import 'package:rxdart/rxdart.dart';

class NationalEducationBloc {
  final NationalEducationStructureRepository neducationRepo;
  String searchText;

  // Loaded data
  List<NationalEducationStructure> neStructureData = List<NationalEducationStructure>();
  List<NationalEducationStructure> filteredData = List<NationalEducationStructure>();
  List<NationalEducationStructure> viewData = List<NationalEducationStructure>();

  // Data Streams
  Stream<List<NationalEducationStructure>> _neStructures = Stream.empty();
  Stream<List<NationalEducationStructure>> _searchValueChanged = Stream.empty();

  Stream<List<NationalEducationStructure>> get nationalExamStructures => _neStructures;
  Stream<List<NationalEducationStructure>> get searchValueChanged => _searchValueChanged;

  // Input sink
  ReplaySubject _loadNationalExamStructure = ReplaySubject();
  ReplaySubject<String> _searchNationalExam = ReplaySubject<String>();

  Sink get loadNationalEducationStructure => _loadNationalExamStructure;
  Sink<String> get searchNationalEducation => _searchNationalExam;

  NationalEducationBloc(this.neducationRepo) {
    _neStructures = _loadNationalExamStructure.asyncMap(fetchNationalEducationStructures).asBroadcastStream();
    _searchValueChanged = _searchNationalExam.asyncMap(searchExpertiseChanged).asBroadcastStream();
  }

  void dispose() {
    _loadNationalExamStructure.close();
    _searchNationalExam.close();
  }

  void reset() {
    resetExpertiseStructureData();
    filteredData = List<NationalEducationStructure>();
    viewData = List<NationalEducationStructure>();
    searchText = '';
  }

  void resetExpertiseStructureData() {
    neStructureData = List<NationalEducationStructure>();
  }

  Future<List<NationalEducationStructure>> searchExpertiseChanged(String value) async {
    filteredData = List<NationalEducationStructure>();
    searchText = value;
    
    if (value.isNotEmpty) {
      for (var item in neStructureData) {
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

  Future<List<NationalEducationStructure>> fetchNationalEducationStructures(dynamic flag) async {
    var data = await neducationRepo.fetchNationalEducationStructures(null);

    viewData = data;
    
    return data;
  }
}