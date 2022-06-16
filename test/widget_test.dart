import 'dart:math';

import 'package:contacts/config.dart';
import 'package:contacts/model/contacts_model.dart';
import 'package:contacts/ui/screens/contact_list.dart';
import 'package:contacts/ui/widgets/row_widget.dart';
import 'package:contacts/ui/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
                  heading: "Contact list",
                  bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(40),
                      child: Container(
                        key: const Key("container"),
                      )),
                  floatingButton: TextButton(
                      onPressed: () {
                        currentTheme.getSharedPreferences();
                        currentTheme.retrieveBooleanValue();

                        currentTheme.switchTheme();
                        currentTheme.saveBoolValue();
                      },
                      child: Text("theme")),
                  date: false,
                  dateWidget: Text("date"),
                  child: const Text(
                    "contact list view",
                    key: Key("datetext"),
                  )),
            ),
          ),
        ),
      ));
      await tester.tap(find.byType(TextButton));
      await tester.pump();
      await tester.tap(find.byType(TextButton));
      await tester.pump();
      expect(find.text('Contact list'), findsOneWidget);
      expect(find.text('contact list view'), findsOneWidget);
      expect(find.byKey(const Key("container")), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.byKey(const Key("datetext")), findsOneWidget);
      expect(
        currentTheme.currentTheme(),
        ThemeMode.light,
        reason:
            "Since MaterialApp() was set to dark theme when it was built at tester.pumpWidget(), the MaterialApp should be in dark theme",
      );
    });

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
  });
}
