import 'package:kurikulumsmk/model/paging.dart';

class School {
  School({this.id,
        this.districtId,
        this.district,
        this.npsn,
        this.name,
        this.status,
        this.subDistrict,
        this.phone,
        this.address,
        this.fax});

  final int id, districtId;
  final String district, npsn, name, status, address, subDistrict, phone, fax;

  List<School> getDummyData() {
    List<School> result = new List<School>();

    /*
    result.add(Sekolah("11222","SMK1N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));
    result.add(Sekolah("10111","SMK2N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));
    result.add(Sekolah("20392","SMK3N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));
    result.add(Sekolah("39281","SMK4N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));
    result.add(Sekolah("28234","SMK5N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));
    result.add(Sekolah("17892","SMK6N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));
    result.add(Sekolah("12384","SMK7N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));
    result.add(Sekolah("19283","SMK8N Yogyakarta","Jl. Pramuka 1 No. 1","Depok","Sleman","D.I.Y"));
    */

    return result;
  }

  factory School.fromJson(Map value) {
    return School(
        id: value['id'],
        districtId: value['district_id'],
        district: value['district'].toString(),
        npsn: value['npsn'].toString(),
        name: value['name'].toString(),
        phone: value['phone'].toString(),
        status: value['status'].toString(),
        address: value['address'].toString(),
        subDistrict: value['sub_district'].toString(),
        fax: value['fax'].toString(),);
  }
}

class Schools {
  Schools({
    this.paging,
    this.schools,
  });

  final Paging paging;
  final List<School> schools;

  call(String a, String b) => '$a $b';

  Schools.fromMap(Map<String, dynamic> value)
      : paging = Paging.fromJson(value['paging']),
        schools = new List<School>.from(
            value['schools'].map((school) => School.fromJson(school)));
}
