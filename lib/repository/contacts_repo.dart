import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

import 'package:contacts/model/contacts_model.dart';

class ContactsRepository {
  static String url =
      "http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts";
  Future<List<ContactsModel>> data() async {
    var response = await http.get(Uri.parse(url));

    List<ContactsModel> cartListResponse = List.from(
        json.decode(response.body).map((e) => ContactsModel.fromJson(e)));

    return cartListResponse;
  }
}
