import 'package:kurikulumsmk/model/paging.dart';

class Contact {
  Contact({this.id,
        this.districtId,
        this.district,
        this.name,
        this.phone,
        this.address});

  final int id, districtId;
  final String district, name, phone, address;

  List<Contact> getDummyData() {
    List<Contact> result = new List<Contact>();

    /*
    result.add(Contact(id: 1, 1, "", "Arif Hidayat","081360190789","Jalan Geureute 1 No. 260, Kuta Padang, Kec. Johan Pahlawan, Meulaboh, Kab. Aceh Barat, Prov. Aceh"));
    result.add(Contact(id: 1, 1, "", "Agus Setiyadi Zarkasi","081360190789","Jalan Tgk. Lampoh Bungong, No. 3A, 40 M dari kantor Geuchik Gampong Batoh, Desa Batoh, Kec. Leung Bata, Kota Banda Aceh, Prov. Aceh"));
    result.add(Contact(id: 1, 1, "", "Nicko Roni Setiawan","081360190789","Jalan Geureute 1 No. 260, Kuta Padang, Kec. Johan Pahlawan, Meulaboh, Kab. Aceh Barat, Prov. Aceh"));
    result.add(Contact(id: 1, 1, "", "Erdis Kamanjaya","081360190789","Jalan Pahlawan, Gang Semesta, Kel/Desa Batang Beruh, Kecamatan Sidikalang, Kab. Dairi, Prop. Sumatera Utara"));
    result.add(Contact(id: 1, 1, "", "Achlul Chairi","081360190789","Jalan Komplek Mutiara Lorong 02 No. 07, Desa Alue Awe, Kec. Muara Dua, Kota Lhokseumawe, Prov. Aceh"));
    result.add(Contact(id: 1, 1, "", "Nicko Roni Setiawan	","081360190789","Jalan Sengeda, Depan SMA Muhammadiyah Mampak, Kebayakan, Takengon, Kab. Aceh Tengah, Prov. Aceh"));
    result.add(Contact(id: 1, 1, "", "Erdis Kamanjaya","081360190789","Jalan Pahlawan, Gang Semesta, Kel/Desa Batang Beruh, Kecamatan Sidikalang, Kab. Dairi, Prop. Sumatera Utara"));
    result.add(Contact(id: 1, 1, "", "Arif Hidayat","081360190789","Jalan Komplek Mutiara Lorong 02 No. 07, Desa Alue Awe, Kec. Muara Dua, Kota Lhokseumawe, Prov. Aceh"));
    */

    return result;
  }

  factory Contact.fromJson(Map value) {
    return Contact(
        id: value['id'],
        districtId: value['district_id'],
        district: value['district'].toString(),
        name: value['name'].toString(),
        phone: value['phone'].toString(),
        address: value['address'].toString());
  }
}

class Contacts {
  Contacts({
    this.paging,
    this.contacts,
  });

  final Paging paging;
  final List<Contact> contacts;

  call(String a, String b) => '$a $b';

  Contacts.fromMap(Map<String, dynamic> value)
      : paging = Paging.fromJson(value['paging']),
        contacts = new List<Contact>.from(
            value['contacts'].map((contact) => Contact.fromJson(contact)));
}

abstract class IContactRepository {
  Future<Contacts> fetchContacts(int pageNumber, int pageSize);
}

class FetchContactsException implements Exception {
  final _message;

  FetchContactsException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}