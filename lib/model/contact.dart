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
