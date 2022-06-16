part of 'contacts_bloc.dart';

abstract class ContactsEvent {}

class FetchContacts extends ContactsEvent {
  FetchContacts();
}

class SortContacts extends ContactsEvent {
  List<ContactsModel>? contacts;
  bool atoz = true;
  SortContacts(this.contacts, this.atoz);
}
