// Import the test package and Counter class
import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:contacts/bloc/contacts/contacts_bloc.dart';
import 'package:contacts/config.dart';
import 'package:contacts/model/contacts_model.dart';

import 'package:test/test.dart';

class MockCounterBloc extends MockBloc<ContactsEvent, ContactsState>
    implements ContactsBloc {}

void main() {
  mainBloc();
}

void mainBloc() {
  List<ContactsModel> contactResponses;
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

    /*  blocTest<ContactsBloc, ContactsState>(
      'Fetch Api error check',
      build: () => ContactsBloc(),
      act: (bloc) => bloc.add(FetchContacts()),
      wait: const Duration(seconds: 2),
      skip: 1,
      errors: () => ["error"],
    ); */

    final file = File('test/test_resources/contact.json').readAsStringSync();
    contactResponses =
        List.from(json.decode(file).map((e) => ContactsModel.fromJson(e)));
    blocTest<ContactsBloc, ContactsState>(
      'Sort atoz Contact Check',
      build: () => ContactsBloc(),
      act: (bloc) => bloc.add(SortContacts(contactResponses, true)),
      wait: const Duration(seconds: 2),
      skip: 1,
      expect: () => [isA<ContactsDone>()],
    );

    blocTest<ContactsBloc, ContactsState>(
      'Sort ztoa Contact Check',
      build: () => ContactsBloc(),
      act: (bloc) => bloc.add(SortContacts(contactResponses, false)),
      wait: const Duration(seconds: 2),
      skip: 1,
      expect: () => [isA<ContactsDone>()],
    );
  });

  group("Contact model", () {
    test('model test', () {
      final file = File('test/test_resources/contact.json').readAsStringSync();
      contactResponses =
          List.from(json.decode(file).map((e) => ContactsModel.fromJson(e)));

      expect(contactResponses.first.name, "name 1");
      expect(contactResponses.first.id, "1");
      expect(contactResponses.first.contacts, "1-355-184-1639");
    });
  });
}
