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

  bool filterVisible = false;

  // Data Streams
  Stream<Contacts> _contacts = Stream.empty();
  Stream<String> _log = Stream.empty();
  Stream<bool> _filterSelected = Stream.empty();

  Stream<String> get log => _log;
  Stream<Contacts> get contacts => _contacts;
  Stream<bool> get filterSelected => _filterSelected;

  // Input sink
  ReplaySubject<ContactEventArgs> _loadContacts = ReplaySubject<ContactEventArgs>();
  ReplaySubject<bool> _showFilter = ReplaySubject<bool>();

  Sink<ContactEventArgs> get loadContacts => _loadContacts;
  Sink<bool> get showFilter => _showFilter;

  ContactBloc(this.contactRepo) {
    _contacts = _loadContacts.asyncMap(contactRepo.fetchContacts).asBroadcastStream();
    _filterSelected = _showFilter.asyncMap(viewFilter).asBroadcastStream();

    _log = Observable(contacts)
        .withLatestFrom(_loadContacts.stream, (_, e) => 'Results for $e')
        .asBroadcastStream();
  }

  void dispose() {
    _loadContacts.close();
    _showFilter.close();
  }

  void reset() {
    filterVisible = false;
    resetContactData();
  }

  void resetContactData() {
    contactsData = List<Contact>();
  }

  Future<bool> viewFilter(bool value) async {
    filterVisible = value;
    return filterVisible;
  }

}