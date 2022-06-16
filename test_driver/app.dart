import 'package:contacts/main.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter/widgets.dart';

void main() {
  enableFlutterDriverExtension();
  runApp(const MyApp(Key("myapp")));
}
