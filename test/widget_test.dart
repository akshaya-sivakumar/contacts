import 'package:contacts/main.dart';
import 'package:contacts/ui/screens/contact_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Material app testing", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(TextField), findsNothing);
  });
}
