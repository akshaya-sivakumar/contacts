import 'package:contacts/bloc/contacts/contacts_bloc.dart';
import 'package:contacts/ui/widgets/row_widget.dart';
import 'package:flutter/material.dart';

class BinaryTree extends StatefulWidget {
  const BinaryTree({Key? key}) : super(key: key);

  @override
  State<BinaryTree> createState() => _BinaryTreeState();
}

class _BinaryTreeState extends State<BinaryTree>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ContactsBloc contactsBloc;
  DateTime selectedDate = DateTime.now();
  bool atoz = true;
  List numbers = [10, 8, 16, 4, 9, 13, 25, 2, 6, 12, 26, 14, 18];
  List binaryNumbers = [];

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text(""),
    );
  }

/*   _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null) {
      setState(() {
        selectedDate = selected;
      });
    }
  } */

  Center loadData(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: Theme.of(context).primaryColor,
    ));
  }
}

class BodyData extends StatefulWidget {
  const BodyData({
    Key? key,
    this.tabController,
    required this.state,
  }) : super(key: key);

  final TabController? tabController;
  final List state;

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      key: const Key("listview"),
      controller: widget.tabController ?? TabController(length: 5, vsync: this),
      children: List.generate(
          5,
          (i) => ListView.separated(
              key: Key("tabview$i"),
              cacheExtent: 50,
              padding: const EdgeInsets.only(top: 20),
              itemCount: widget.state.length,
              itemBuilder: (context, index) {
                return SizedBox(
                    key: Key("item$index"),
                    child: RowWidget(
                      contactdetail: widget.state[index],
                    ));
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 40,
                );
              })),
    );
  }
}

class ErrorsWidget extends StatelessWidget {
  const ErrorsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          size: 60,
          color: Colors.red[900],
        ),
        const Text("Unknown Error")
      ],
    ));
  }
}
