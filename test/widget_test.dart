import 'dart:convert';
import 'dart:io';

import 'package:contacts/bloc/contacts/contacts_bloc.dart';
import 'package:contacts/config.dart';
import 'package:contacts/main.dart' as mainfile;
import 'package:contacts/model/contacts_model.dart';
import 'package:contacts/repository/contacts_repo.dart';
import 'package:contacts/ui/screens/contact_list.dart';
import 'package:contacts/ui/widgets/row_widget.dart';
import 'package:contacts/ui/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContactList Widget ', () {
    testWidgets('Testing Scaffold Widget', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: AppScaffold(
                  key: const Key("scaffoldkey"),
                  heading: "Contact list",
                  bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(40),
                      child: Container(
                        key: const Key("container"),
                      )),
                  floatingButton: TextButton(
                      onPressed: () async {
                        await currentTheme.getSharedPreferences();
                        //await currentTheme.retrieveBooleanValue();

                        currentTheme.switchTheme();
                        await currentTheme.saveBoolValue();
                      },
                      child: IconButton(
                          key: const Key("iconbutton"),
                          onPressed: () {
                            currentTheme.getSharedPreferences();
                            //currentTheme.retrieveBooleanValue();

                            currentTheme.switchTheme();
                            currentTheme.saveBoolValue();
                          },
                          icon: const Icon(Icons.brightness_1))),
                  date: false,
                  dateWidget: const Text("date"),
                  child: const Text(
                    "contact list view",
                    key: Key("datetext"),
                  )),
            ),
          ),
        ),
      ));

      expect(find.byKey(const Key("scaffoldkey")), findsOneWidget);
      await tester.tap(find.byType(TextButton));
      await tester.pump();
      await tester.tap(find.byKey(const Key("iconbutton")));
      await tester.pump();
      expect(find.text('Contact list'), findsOneWidget);
      expect(find.text('contact list view'), findsOneWidget);
      expect(find.byKey(const Key("container")), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.byKey(const Key("datetext")), findsOneWidget);

      expect(
        currentTheme.currentTheme(),
        ThemeMode.light,
      );
      await tester.tap(find.byKey(const Key("themeicon")));
    });

    /*   testWidgets('Testing ContactList screen', (WidgetTester tester) async {
      await tester.pumpWidget(AppScaffold(
        heading: "test",
        child: Container(),
      ));
      
    }); */

    testWidgets('Testing ContactList Row Widget', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: RowWidget(
                contactdetail: ContactsModel(
                    id: "1",
                    name: "Akshaya",
                    contacts: "8248121331",
                    url: "url"),
              ),
            ),
          ),
        ),
      ));
      expect(find.text('Akshaya'), findsOneWidget);
      expect(find.text('8248121331'), findsOneWidget);
    });

    testWidgets('Testing main screen', (WidgetTester tester) async {
      ContactsRepository.url =
          "http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts";
    await tester.pumpWidget(const mainfile.MyApp(Key("myapp")));

      currentTheme.switchTheme();
      mainfile.main();
      expect(find.byKey(const Key("myapp")), findsOneWidget);
    });

    setUpAll(() {
      // ↓ required to avoid HTTP error 400 mocked returns
      HttpOverrides.global = null;
    });

    Widget createWidgetForTesting({Widget? child}) {
      return MaterialApp(
        home: child,
      );
    }

    final file = File('test/test_resources/contact.json').readAsStringSync();
    List<ContactsModel> contactResponses =
        List.from(json.decode(file).map((e) => ContactsModel.fromJson(e)));
    testWidgets('Testing contact list screen', (WidgetTester tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();

      await tester.pumpWidget(createWidgetForTesting(
          child: BlocProvider(
        create: (context) => ContactsBloc()..add(FetchContacts()),
        child: const ContactList(
          key: Key("contactlist"),
        ),
      )));
      await tester.pump();
      /*  await tester.tap(find.byKey(Key("tabbar")));
      await tester.pump(); */
      await tester.tap(find.byKey(const Key("datepicker")));
      await tester.pump();

      expect(find.byKey(const Key("contactlist")), findsOneWidget);
      await tester.pump();
    });

    testWidgets('Testing contact list done screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Material(
              child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: BodyData(
                    key: const Key("successdata"),
                    state: contactResponses,
                  )))));

      expect(find.byKey(const Key("successdata")), findsOneWidget);
    });

    testWidgets('Testing contact list error screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
          home: Material(
              child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: ErrorsWidget(
                    key: Key("error"),
                  )))));

      expect(find.byKey(const Key("error")), findsOneWidget);
    });
  });
}
