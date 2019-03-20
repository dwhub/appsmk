import 'dart:async';
import 'package:kurikulumsmk/model/national_exam.dart';
import 'package:kurikulumsmk/repository/nexam_structure_repository.dart';
import 'package:rxdart/rxdart.dart';

class NationalExamBloc {
  final NationalExamStructureRepository neStructureRepo;
  String searchText;

  // Loaded data
  List<NationalExamStructure> neStructureData = List<NationalExamStructure>();
  List<NationalExamStructure> filteredData = List<NationalExamStructure>();
  List<NationalExamStructure> viewData = List<NationalExamStructure>();

  // Data Streams
  Stream<List<NationalExamStructure>> _neStructures = Stream.empty();
  Stream<List<NationalExamStructure>> _searchValueChanged = Stream.empty();

  Stream<List<NationalExamStructure>> get nationalExamStructures => _neStructures;
  Stream<List<NationalExamStructure>> get searchValueChanged => _searchValueChanged;

  // Input sink
  ReplaySubject _loadNationalExamStructure = ReplaySubject();
  ReplaySubject<String> _searchNationalExam = ReplaySubject<String>();

  Sink get loadNationalExamStructure => _loadNationalExamStructure;
  Sink<String> get searchNationalExam => _searchNationalExam;

  NationalExamBloc(this.neStructureRepo) {
    _neStructures = _loadNationalExamStructure.asyncMap(fetchNationalExamStructures).asBroadcastStream();
    _searchValueChanged = _searchNationalExam.asyncMap(searchExpertiseChanged).asBroadcastStream();
  }

  void dispose() {
    _loadNationalExamStructure.close();
    _searchNationalExam.close();
  }

  void reset() {
    resetExpertiseStructureData();
    filteredData = List<NationalExamStructure>();
    viewData = List<NationalExamStructure>();
    searchText = '';
  }

  void resetExpertiseStructureData() {
    neStructureData = List<NationalExamStructure>();
  }

  Future<List<NationalExamStructure>> searchExpertiseChanged(String value) async {
    filteredData = List<NationalExamStructure>();
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

  Future<List<NationalExamStructure>> fetchNationalExamStructures(dynamic flag) async {
    var data = await neStructureRepo.fetchNationalExamStructures(null);

    viewData = data;
    
    return data;
  }
}