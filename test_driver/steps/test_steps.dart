import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckGivenWidgets extends Given2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1, String input2) async {
    final listview = find.byValueKey(input1);
    final button = find.byValueKey(input2);
    bool input1Exists =
        await FlutterDriverUtils.isPresent(world.driver, listview);
    bool input2Exists =
        await FlutterDriverUtils.isPresent(world.driver, button);
    expect(input1Exists, true);
    expect(input2Exists, true);
  }

  @override
  RegExp get pattern => RegExp(r"I have {string} and {string}");
}

class CheckTabWidgets extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final button = find.byValueKey(input1);

    bool input1Exists =
        await FlutterDriverUtils.isPresent(world.driver, button);
    expect(input1Exists, true);
  }

  @override
  RegExp get pattern => RegExp(r"I have {string}");
}

class ScrollTillItemVisible
    extends Then2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String listKey, String itemKey) async {
    final listFinder = find.byValueKey(listKey);
    final itemfinder = find.byValueKey(itemKey);
    bool isPresent = false;
    while (!isPresent) {
      await world.driver!.scroll(
          listFinder, 0.0, -1000.0, const Duration(milliseconds: 300),
          timeout: const Duration(seconds: 20));
      isPresent = await FlutterDriverUtils.isPresent(world.driver, itemfinder);
    }
  }

  @override
  RegExp get pattern => RegExp(r"I scroll {string} till {string} is visible");
}

class CheckTabsWidgets extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final button = find.byValueKey(input1);

    bool input1Exists =
        await FlutterDriverUtils.isPresent(world.driver, button);
    expect(input1Exists, true);
  }

  @override
  RegExp get pattern => RegExp(r"I have {string}");
}

class ClickTabButton extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final button = find.byValueKey(input1);

    await FlutterDriverUtils.tap(world.driver, button);
  }

  @override
  RegExp get pattern => RegExp(r"I tap {string}");
}

class SwitchTheme extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1) async {
    final button = find.byValueKey(input1);

    await FlutterDriverUtils.tap(world.driver, button);
  }

  @override
  RegExp get pattern => RegExp(r"I switch theme {string}");
}
