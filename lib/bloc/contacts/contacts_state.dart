part of 'contacts_bloc.dart';

abstract class ContactsState {}

class ContactsInitial extends ContactsState {}

class ContactsLoad extends ContactsState {}

class ContactsDone extends ContactsState {
  final List<ContactsModel> contacts;

  ContactsDone(this.contacts);
}

class ContactsError extends ContactsState {}
