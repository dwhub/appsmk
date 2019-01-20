import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/event/contact_event_args.dart';
import 'package:kurikulumsmk/model/contact.dart';

class ContactRepository implements IContactRepository {
  @override
  Future<Contacts> fetchContacts(ContactEventArgs e) async {
    http.Response response = await http.get(API_BASE_URL +
        "contacts?page=" +
        e.page.toString() + "&pageSize=" + e.pageSize.toString() + 
        "&provinceID=" + e.provinceId.toString() + 
        "&districtID=" + e.districtId.toString());

    final Map contactsMap = JsonCodec().decode(response.body);

    Contacts contacts = Contacts.fromMap(contactsMap['message']);
    if (contacts == null) {
      throw new Exception("An error occurred : [ Status Code = ]");
    }

    return contacts;
  }
}

abstract class IContactRepository {
  Future<Contacts> fetchContacts(ContactEventArgs contactEventArgs);
}

class FetchContactsException implements Exception {
  final _message;

  FetchContactsException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception : $_message";
  }
}
