class ContactsModel {
  ContactsModel({
    required this.id,
    required this.name,
    required this.contacts,
    required this.url,
  });
  late final String id;
  late final String name;
  late final String contacts;
  late final String url;

  ContactsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contacts = json['Contacts'];
    url = json['url'];
  }
}
