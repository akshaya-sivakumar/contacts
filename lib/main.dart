import 'dart:developer';

import 'package:contacts/config.dart';
import 'package:contacts/ui/screens/contact_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/contacts/contacts_bloc.dart';

void main() async {
  runApp(const MyApp(Key("myapp")));
  WidgetsFlutterBinding.ensureInitialized();
  //await currentTheme.retrieveBooleanValue();
}

class MyApp extends StatefulWidget {
  const MyApp(Key? key) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        key: const Key("matapp"),
        title: 'Flutter Demo',
        themeMode: currentTheme.currentTheme(),
        darkTheme: ThemeData(
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: Colors.black)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80, vertical: 10))),
          primaryColor: Colors.black,
        ),
        theme: ThemeData(
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: Colors.black)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80, vertical: 10))),
          primaryColor: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => ContactsBloc()..add(FetchContacts()),
          child: const ContactList(),
        ));
  }
}
