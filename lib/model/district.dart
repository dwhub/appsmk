class District {
  const District({this.id, this.name});

  final String name;
  final int id;

  factory District.fromJson(Map<String, dynamic> value) {
    return District(
        id: value['id'],
        name: value['name'].toString());
  }
}

abstract class IDistrictRepository {
  Future<List<District>> fetchDistricts(int provinceId);
}

class FetchDistrictException implements Exception {
  final _message;

  FetchDistrictException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}