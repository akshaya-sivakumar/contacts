import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTheme with ChangeNotifier {
  static bool isdark = false;
  late SharedPreferences prefs;
  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  ThemeMode currentTheme() {
    return isdark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    isdark = !isdark;
    saveBoolValue();
    notifyListeners();
  }

  saveBoolValue() async {
    prefs = await SharedPreferences.getInstance();
    //prefs.setBool("isDark", isdark);
  }

  /* retrieveBooleanValue() async {
    //prefs = await SharedPreferences.getInstance();
    notifyListeners();
    isdark = prefs.getBool("isDark") ?? false;
  } */
}
