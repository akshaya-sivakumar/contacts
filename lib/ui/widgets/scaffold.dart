import 'package:flutter/material.dart';

import '../../config.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({
    Key? key,
    required this.child,
    required this.heading,
    this.date = false,
    this.bottom,
    this.floatingButton,
    this.dateWidget,
  }) : super(key: key);
  final Widget? child, floatingButton, dateWidget;
  final PreferredSizeWidget? bottom;
  final bool date;
  final String? heading;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.heading ?? ""),
                Row(
                  children: [
                    if (widget.dateWidget != null) widget.dateWidget!,
                    IconButton(
                        key: const Key("themeicon"),
                        onPressed: () {
                          currentTheme.switchTheme();
                        },
                        icon: const Icon(Icons.brightness_high)),
                  ],
                )
              ],
            ),
            backgroundColor: Theme.of(context).primaryColor,
            bottom: widget.bottom),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: widget.floatingButton,
        body: widget.child);
  }
}
