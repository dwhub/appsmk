import 'package:kurikulumsmk/model/expertise_competency.dart';
import 'package:kurikulumsmk/model/expertise_field.dart';
import 'package:kurikulumsmk/model/expertise_program.dart';
import 'package:kurikulumsmk/repository/excompetency_repository.dart';
import 'package:kurikulumsmk/repository/exfield_repository.dart';
import 'package:kurikulumsmk/repository/exprogram_repository.dart';
import 'package:rxdart/rxdart.dart';

class ExpertiseBloc {
  final ExpertiseFieldRepository exFieldRepo;
  final ExpertiseProgramRepository exProgramRepo;
  final ExpertiseCompetencyRepository exCompetencyRepo;

  List<ExpertiseField> exFieldsData = List<ExpertiseField>();
  List<ExpertiseProgram> exProgramsData = List<ExpertiseProgram>();
  List<ExpertiseCompetency> exCompetenciesData = List<ExpertiseCompetency>();

  Stream<List<ExpertiseField>> _exFields = Stream.empty();
  Stream<List<ExpertiseProgram>> _exPrograms = Stream.empty();
  Stream<List<ExpertiseCompetency>> _exCompetencies = Stream.empty();

  Stream<ExpertiseField> _exFieldValueChanged = Stream.empty();
  Stream<ExpertiseProgram> _exProgramValueChanged = Stream.empty();
  Stream<ExpertiseCompetency> _exCompetencyValueChanged = Stream.empty();

  Stream<List<ExpertiseField>> get exFields => _exFields;
  Stream<List<ExpertiseProgram>> get exPrograms => _exPrograms;
  Stream<List<ExpertiseCompetency>> get exCompetencies => _exCompetencies;

  Stream<ExpertiseField> get exFieldValueChanged => _exFieldValueChanged;
  Stream<ExpertiseProgram> get exProgramValueChanged => _exProgramValueChanged;
  Stream<ExpertiseCompetency> get exCompetencyValueChanged => _exCompetencyValueChanged;

  ExpertiseField selectedExField;
  ExpertiseProgram selectedExProgram;
  ExpertiseCompetency selectedExCompetency;

  // Input sink
  ReplaySubject _loadExFields = ReplaySubject();
  ReplaySubject<int> _loadExPrograms = ReplaySubject<int>();
  ReplaySubject<int> _loadExCompetencies = ReplaySubject<int>();

  ReplaySubject<ExpertiseField> _exFieldChanged = ReplaySubject<ExpertiseField>();
  ReplaySubject<ExpertiseProgram> _exProgramChanged = ReplaySubject<ExpertiseProgram>();
  ReplaySubject<ExpertiseCompetency> _exCompetencyChanged = ReplaySubject<ExpertiseCompetency>();

  Sink get loadExFields => _loadExFields;
  Sink<ExpertiseField> get exFieldChanged => _exFieldChanged;

  Sink<int> get loadExPrograms => _loadExPrograms;
  Sink<ExpertiseProgram> get exProgramChanged => _exProgramChanged;
  
  Sink<int> get loadExCompetencies => _loadExCompetencies;
  Sink<ExpertiseCompetency> get exCompetencyChanged => _exCompetencyChanged;
  
  ExpertiseBloc(this.exFieldRepo, this.exProgramRepo, this.exCompetencyRepo) {
    _exFields = _loadExFields.asyncMap(exFieldRepo.fetchExpertiseFields).asBroadcastStream();
    _exFieldValueChanged = _exFieldChanged.asyncMap(exFieldIsChanged).asBroadcastStream();

    _exPrograms = _loadExPrograms.asyncMap(exProgramRepo.fetchExpertiseProgram).asBroadcastStream();
    _exProgramValueChanged = _exProgramChanged.asyncMap(exProgramIsChanged).asBroadcastStream();

    _exCompetencies = _loadExCompetencies.asyncMap(exCompetencyRepo.fetchExpertiseCompetencies).asBroadcastStream();
    _exCompetencyValueChanged = _exCompetencyChanged.asyncMap(exCompetencyIsChanged).asBroadcastStream();
  }

  void dispose() {
    _loadExFields.close();
    _loadExPrograms.close();
    _loadExCompetencies.close();
    _exFieldChanged.close();
    _exProgramChanged.close();
    _exCompetencyChanged.close();
  }

  void reset() {
    selectedExField = null;
    selectedExProgram = null;
    selectedExCompetency = null;
    exFieldsData = List<ExpertiseField>();
    exProgramsData = List<ExpertiseProgram>();
    exCompetenciesData = List<ExpertiseCompetency>();
  }

  Future<ExpertiseField> exFieldIsChanged(ExpertiseField value) async {
    selectedExField = value;
    selectedExProgram = null;
    selectedExCompetency = null;
    loadExPrograms.add(value.id);
    return value;
  }

  Future<ExpertiseProgram> exProgramIsChanged(ExpertiseProgram value) async {
    selectedExProgram = value;
    selectedExCompetency = null;
    loadExCompetencies.add(value.id);
    return value;
  }

  Future<ExpertiseCompetency> exCompetencyIsChanged(ExpertiseCompetency value) async {
    selectedExCompetency = value;
    return value;
  }
}