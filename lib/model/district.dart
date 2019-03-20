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

class SubDistrict {
  const SubDistrict({this.districtId, this.district, this.name});

  final String name;
  final String district;
  final String districtId;

  factory SubDistrict.fromJson(Map<String, dynamic> value) {
    return SubDistrict(
        districtId: value['district_id'],
        district: value['district'].toString(),
        name: value['name'].toString());
  }
}