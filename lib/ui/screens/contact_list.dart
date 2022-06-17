import 'dart:developer';

import 'package:contacts/bloc/contacts/contacts_bloc.dart';

import 'package:contacts/model/contacts_model.dart';
import 'package:contacts/ui/widgets/row_widget.dart';
import 'package:contacts/ui/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ContactsBloc contactsBloc;
  DateTime selectedDate = DateTime.now();
  bool atoz = true;
  List<ContactsModel> contactlist = [];
  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    super.initState();
    contactsBloc = BlocProvider.of<ContactsBloc>(context)
      ..stream.listen((event) {});
    contactsBloc.add(FetchContacts());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabController.length,
      child: AppScaffold(
        dateWidget: Text(
          key: Key(DateFormat("d/M/y").format(selectedDate).toString()),
          DateFormat("d/M/y").format(selectedDate).toString().toString(),
          style: const TextStyle(fontSize: 10),
        ),
        heading: "Contacts",
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: TabBar(
              key: const Key("tabbar"),
              controller: tabController,
              isScrollable: true,
              tabs: List.generate(
                  5,
                  (index) => Tab(
                        key: Key("tabbar$index"),
                        text: "Contact ${index + 1}",
                      ))),
        ),
        floatingButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          key: const Key("datepicker"),
          onPressed: () {
            setState(() {
              atoz = !atoz;
            });
            contactsBloc.add(SortContacts(contactlist, atoz));
            contactsBloc.add(SortContacts(contactlist, atoz));
            //   _selectDate(context);
          },
          child: Text(atoz ? "Z to A" : "A to Z"),
        ),
        child: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, ContactsState state) {
            if (state is ContactsLoad) {
              return loadData(context);
            }
            if (state is ContactsError) {
              return const ErrorsWidget(
                key: Key("errorwidget"),
              );
            }
            if (state is ContactsDone) {
              contactlist = state.contacts;
              return BodyData(
                  tabController: tabController, state: state.contacts);
            }
            return loadData(context);
          },
        ),
      ),
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
