import 'package:kurikulumsmk/model/contact.dart';
import 'package:kurikulumsmk/repository/contact_repository.dart';

abstract class ContactListViewContract {
  void onContacts(List<Contact> contacts);
  void onLoadContactsError();
}

class ContactListPresenter {
  final ContactListViewContract contactListViewContract;
  ContactRepository contactRepository;

  ContactListPresenter(this.contactListViewContract) {
    contactRepository = ContactRepository();
  }

  void loadContacts() {
    contactRepository
        .fetchContacts(1, 5)
        .then((contacts) => contactListViewContract.onContacts(contacts.contacts))
        .catchError((onError) => contactListViewContract.onLoadContactsError());
  }
}