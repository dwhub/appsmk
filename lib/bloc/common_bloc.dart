import 'package:kurikulumsmk/model/district.dart';
import 'package:kurikulumsmk/model/province.dart';
import 'package:kurikulumsmk/repository/district_repository.dart';
import 'package:kurikulumsmk/repository/province_repository.dart';
import 'package:rxdart/rxdart.dart';

class CommonBloc {
  final ProvinceRepository provinceRepo;
  final DistrictRepository districtRepo;

  List<Province> provincesData = List<Province>();
  List<District> districtsData = List<District>();

  Stream<List<Province>> _provinces = Stream.empty();
  Stream<List<District>> _districts = Stream.empty();
  Stream<Province> _provinceValueChanged = Stream.empty();
  Stream<District> _districtValueChanged = Stream.empty();

  Stream<List<Province>> get provinces => _provinces;
  Stream<List<District>> get districts => _districts;
  Stream<Province> get provinceValueChanged => _provinceValueChanged;
  Stream<District> get districtValueChanged => _districtValueChanged;

  Province selectedProvince;
  District selectedDistrict;

  // Input sink
  ReplaySubject _loadProvinces = ReplaySubject();
  ReplaySubject<int> _loadDistricts = ReplaySubject<int>();
  ReplaySubject<Province> _provinceChanged = ReplaySubject<Province>();
  ReplaySubject<District> _districtChanged = ReplaySubject<District>();

  Sink get loadProvinces => _loadProvinces;
  Sink<Province> get provinceChanged => _provinceChanged;
  Sink<int> get loadDistricts => _loadDistricts;
  Sink<District> get districtChanged => _districtChanged;

  CommonBloc(this.provinceRepo, this.districtRepo) {
    _provinces = _loadProvinces.asyncMap(provinceRepo.fetchProvinces).asBroadcastStream();
    _provinceValueChanged = _provinceChanged.asyncMap(provinceIsChanged).asBroadcastStream();
    _districts = _loadDistricts.asyncMap(districtRepo.fetchDistricts).asBroadcastStream();
    _districtValueChanged = _districtChanged.asyncMap(districtIsChanged).asBroadcastStream();

  }

  void dispose() {
    _loadProvinces.close();
    _loadDistricts.close();
    _provinceChanged.close();
    _districtChanged.close();
  }

  void reset() {
    selectedProvince = null;
    selectedDistrict = null;
    provincesData = List<Province>();
  }

  Future<Province> provinceIsChanged(Province value) async {
    selectedProvince = value;
    selectedDistrict = null;
    loadDistricts.add(value.id);
    return value;
  }

  Future<District> districtIsChanged(District value) async {
    selectedDistrict = value;
    return value;
  }
}