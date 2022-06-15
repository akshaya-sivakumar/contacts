// Import the test package and Counter class
import 'package:bloc_test/bloc_test.dart';
import 'package:contacts/bloc/contacts/contacts_bloc.dart';
import 'package:contacts/model/contacts_model.dart';
import 'package:contacts/resources/contacts_repo.dart';
import 'package:test/test.dart';

class MockCounterBloc extends MockBloc<ContactsEvent, ContactsState>
    implements ContactsBloc {}

void main() {
  mainBloc();
}

void mainBloc() {
  group('Contacts Bloc', () {
    blocTest<ContactsBloc, ContactsState>(
      'Initial Check',
      build: () => ContactsBloc(),
      expect: () => const <ContactsState>[],
    );

    blocTest<ContactsBloc, ContactsState>(
      'Fetch Api Check',
      build: () => ContactsBloc(),
      act: (bloc) => bloc.add(FetchContacts()),
      wait: const Duration(seconds: 2),
      skip: 1,
      expect: () => [isA<ContactsDone>()],
    );
    blocTest<ContactsBloc, ContactsState>(
      'Sort Contact Check',
      build: () => ContactsBloc(),
      act: (bloc) => bloc.add(SortContacts([], true)),
      wait: const Duration(seconds: 2),
      skip: 1,
      expect: () => [isA<ContactsDone>()],
    );
  });
}
