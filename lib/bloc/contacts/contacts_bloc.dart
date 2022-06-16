import 'package:contacts/model/contacts_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/contacts_repo.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsInitial()) {
    on<FetchContacts>((event, emit) async {
      emit(ContactsLoad());
      try {
        final contacts = await ContactsRepository().data();
        contacts.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        emit(ContactsDone(contacts));
      } catch (e) {
        emit(ContactsError());
        throw ("error");
      }
    });
    on<SortContacts>((event, emit) async {
      emit(ContactsLoad());
      try {
        event.atoz
            ? event.contacts!.sort(
                (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()))
            : event.contacts!.sort(
                (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
        emit(ContactsDone(event.contacts!));
      } catch (e) {
        emit(ContactsError());
        throw ("error");
      }
    });
  }
}
