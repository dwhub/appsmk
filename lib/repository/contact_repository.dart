import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kurikulumsmk/config.dart';
import 'package:kurikulumsmk/model/contact.dart';
import 'package:flutter/foundation.dart';

class ContactRepository implements IContactRepository {
  @override
  Future<Contacts> fetchContacts(int pageNumber, int pageSize) async {
    http.Response response = await http.get(API_BASE_URL +
        "contacts?page=" +
        pageNumber.toString() + "&pageSize=" + pageSize.toString());
    return compute(parseContacts, response.body);
  }
}

Contacts parseContacts(String responseBody) {
  final Map contactsMap = JsonCodec().decode(responseBody);

  Contacts contacts = Contacts.fromMap(contactsMap['message']);
  if (contacts == null) {
    throw new Exception("An error occurred : [ Status Code = ]");
  }
  return contacts;
}
