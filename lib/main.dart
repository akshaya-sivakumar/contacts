import 'dart:developer';

import 'package:contacts/config.dart';
import 'package:contacts/ui/route_generator.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await currentTheme.retrieveBooleanValue();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      log("changes");
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 10))),
        primaryColor: Colors.black,
      ),
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: Colors.black)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 10))),
        primaryColor: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/file",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
