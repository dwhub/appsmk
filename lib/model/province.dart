class Province {
  const Province({this.id, this.name});

  final String name;
  final int id;

  factory Province.fromJson(Map<String, dynamic> value) {
    return Province(
        id: value['id'],
        name: value['name'].toString());
  }
}

abstract class IProvinceRepository {
  Future<List<Province>> fetchProvinces();
}

class FetchProvinceException implements Exception {
  final _message;

  FetchProvinceException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}