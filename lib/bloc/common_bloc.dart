import 'dart:async';

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
  List<SubDistrict> subDistrictsData = List<SubDistrict>();

  Stream<List<Province>> _provinces = Stream.empty();
  Stream<List<District>> _districts = Stream.empty();
  Stream<List<SubDistrict>> _subDistricts = Stream.empty();
  Stream<Province> _provinceValueChanged = Stream.empty();
  Stream<District> _districtValueChanged = Stream.empty();
  Stream<SubDistrict> _subDistrictValueChanged = Stream.empty();

  Stream<List<Province>> get provinces => _provinces;
  Stream<List<District>> get districts => _districts;
  Stream<List<SubDistrict>> get subDistricts => _subDistricts;
  Stream<Province> get provinceValueChanged => _provinceValueChanged;
  Stream<District> get districtValueChanged => _districtValueChanged;
  Stream<SubDistrict> get subDistrictValueChanged => _subDistrictValueChanged;

  Province selectedProvince;
  District selectedDistrict;
  SubDistrict selectedSubDistrict;

  // Input sink
  ReplaySubject _loadProvinces = ReplaySubject();
  ReplaySubject<int> _loadDistricts = ReplaySubject<int>();
  ReplaySubject<int> _loadSubDistricts = ReplaySubject<int>();
  ReplaySubject<Province> _provinceChanged = ReplaySubject<Province>();
  ReplaySubject<District> _districtChanged = ReplaySubject<District>();
  ReplaySubject<SubDistrict> _subDistrictChanged = ReplaySubject<SubDistrict>();

  Sink get loadProvinces => _loadProvinces;
  Sink<Province> get provinceChanged => _provinceChanged;
  Sink<int> get loadDistricts => _loadDistricts;
  Sink<District> get districtChanged => _districtChanged;
  Sink<int> get loadSubDistricts => _loadSubDistricts;
  Sink<SubDistrict> get subDistrictChanged => _subDistrictChanged;

  CommonBloc(this.provinceRepo, this.districtRepo) {
    _provinces = _loadProvinces.asyncMap(fetchProvinces).asBroadcastStream();
    _provinceValueChanged = _provinceChanged.asyncMap(provinceIsChanged).asBroadcastStream();
    _districts = _loadDistricts.asyncMap(fetchDistricts).asBroadcastStream();
    _districtValueChanged = _districtChanged.asyncMap(districtIsChanged).asBroadcastStream();
    _subDistricts = _loadSubDistricts.asyncMap(fetchSubDistricts).asBroadcastStream();
    _subDistrictValueChanged = _subDistrictChanged.asyncMap(subDistrictIsChanged).asBroadcastStream();

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
    selectedSubDistrict = null;
    provincesData = List<Province>();
    districtsData = List<District>();
    subDistrictsData = List<SubDistrict>();
  }

  Future<Province> provinceIsChanged(Province value) async {
    selectedProvince = value;
    selectedDistrict = null;
    selectedSubDistrict = null;
    loadDistricts.add(value.id);
    loadSubDistricts.add(0);
    return value;
  }

  Future<District> districtIsChanged(District value) async {
    selectedDistrict = value;
    selectedSubDistrict = null;
    loadSubDistricts.add(value.id);
    return value;
  }

  Future<SubDistrict> subDistrictIsChanged(SubDistrict value) async {
    selectedSubDistrict = value;
    return value;
  }

  Future<List<Province>> fetchProvinces(dynamic flag) async {
    List<Province> response = await provinceRepo.fetchProvinces(null);
    List<Province> result = List<Province>();

    if (response.length > 0) {
      Province temp = Province(id: 0, name: "Semua Provinsi");

      result.add(temp);

      for (var item in response) {
        result.add(item);
      }
    }

    return result;
  }

  Future<List<District>> fetchDistricts(int provinceId) async {
    List<District> response = await districtRepo.fetchDistricts(provinceId);
    List<District> result = List<District>();

    if (response.length > 0) {
      District temp = District(id: 0, name: "Semua Kabupaten");

      result.add(temp);

      for (var item in response) {
        result.add(item);
      }
    }

    return result;
  }

  Future<List<SubDistrict>> fetchSubDistricts(int districtId) async {
    List<SubDistrict> response = await districtRepo.fetchSubDistricts(districtId);
    List<SubDistrict> result = List<SubDistrict>();

    if (response.length > 0) {
      SubDistrict temp = SubDistrict(districtId: "0", name: "Semua Kecamatan");

      result.add(temp);

      for (var item in response) {
        result.add(item);
      }
    }

    return result;
  }
}