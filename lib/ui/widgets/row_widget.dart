import 'package:flutter/material.dart';

import '../../model/contacts_model.dart';

class RowWidget extends StatelessWidget {
  final ContactsModel contactdetail;
  const RowWidget({Key? key, required this.contactdetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
