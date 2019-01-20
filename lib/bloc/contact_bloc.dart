import 'dart:async';
import 'package:kurikulumsmk/event/contact_event_args.dart';
import 'package:kurikulumsmk/model/contact.dart';
import 'package:kurikulumsmk/repository/contact_repository.dart';
import 'package:kurikulumsmk/utils/constants.dart';
import 'package:rxdart/rxdart.dart';

class ContactBloc {
  final ContactRepository contactRepo;

  LoadMoreStatus loadMoreStatus = LoadMoreStatus.STABLE;

  // Loaded data
  List<Contact> contactsData = List<Contact>();

  // Data Streams
  Stream<Contacts> _contacts = Stream.empty();
  Stream<String> _log = Stream.empty();

  Stream<String> get log => _log;
  Stream<Contacts> get contacts => _contacts;

  // Input sink
  ReplaySubject<ContactEventArgs> _loadContacts = ReplaySubject<ContactEventArgs>();

  Sink<ContactEventArgs> get loadContacts => _loadContacts;

  ContactBloc(this.contactRepo) {
    _contacts = _loadContacts.asyncMap(contactRepo.fetchContacts).asBroadcastStream();

    _log = Observable(contacts)
        .withLatestFrom(_loadContacts.stream, (_, e) => 'Results for $e')
        .asBroadcastStream();
  }

  void dispose() {
    _loadContacts.close();
  }

  void reset() {
    resetContactData();
  }

  void resetContactData() {
    contactsData = List<Contact>();
  }
}