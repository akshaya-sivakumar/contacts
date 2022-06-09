import 'dart:developer';

import 'package:contacts/bloc/contacts/contacts_bloc.dart';
import 'package:contacts/config.dart';
import 'package:contacts/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ContactsBloc contactsBloc;
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
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Contacts"),
              IconButton(
                  key: const Key("theme"),
                  onPressed: () {
                    currentTheme.switchTheme();
                  },
                  icon: const Icon(Icons.brightness_high))
            ],
          ),
          backgroundColor: Theme.of(context).primaryColor,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: TabBar(
                key: const Key("tabbar"),
                controller: tabController,
                isScrollable: true,
                onTap: (index) {},
                tabs: List.generate(
                    5,
                    (index) => Tab(
                          key: Key("tabbar$index"),
                          text: "Contact ${index + 1}",
                        ))),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          key: const Key("floatbutton"),
          onPressed: () {
            setState(() {
              atoz = !atoz;
            });
            contactsBloc.add(SortContacts(contactlist, atoz));
          },
          child: Text(atoz ? "Z to A" : "A to Z"),
        ),
        body: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, ContactsState state) {
            if (state is ContactsLoad) {
              return loadData(context);
            }
            if (state is ContactsError) {
              return const ErrorWidget();
            }
            if (state is ContactsDone) {
              contactlist = state.contacts;
              return TabBarView(
                key: const Key("listview"),
                controller: tabController,
                children: List.generate(
                    5,
                    (i) => ListView.separated(
                        key: Key("tabview$i"),
                        cacheExtent: 50,
                        padding: const EdgeInsets.only(top: 20),
                        itemCount: state.contacts.length,
                        itemBuilder: (context, index) {
                          log(index.toString());
                          return SizedBox(
                              key: Key("item$index"),
                              child: bodyData(state.contacts[index]));
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 40,
                          );
                        })),
              );
            }
            return loadData(context);
          },
        ),
      ),
    );
  }

  Widget bodyData(ContactsModel contactdetail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contactdetail.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(contactdetail.contacts)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Image.asset(
            "lib/assets/contact.png",
            height: 30,
          ),
        )
      ],
    );
  }

  Center loadData(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: Theme.of(context).primaryColor,
    ));
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
  }) : super(key: key);

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
