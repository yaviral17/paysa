import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsController extends GetxController {
  RxList<Contact> contacts = <Contact>[].obs;

  @override
  void onInit() {
    super.onInit();
    getContacts();
  }

  void getContacts() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      contacts.value = await FlutterContacts.getContacts(
          withProperties: true, withAccounts: true, withPhoto: true);
    } else {
      await Permission.contacts.request();
      contacts.value = await FlutterContacts.getContacts(
          withProperties: true, withAccounts: true, withPhoto: true);
    }
  }
}
