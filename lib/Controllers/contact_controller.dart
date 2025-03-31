import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsController extends GetxController {
  RxList<Contact> contacts = <Contact>[].obs;

  @override
  void onInit() {
    super.onInit();
    // getContacts();
  }

  void getContacts() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      contacts.value = await FlutterContacts.getContacts(
          withProperties: true, withAccounts: true, withPhoto: true);
    } else {
      // await Permission.contacts.request();
      await FlutterContacts.requestPermission().then(
        (value) async {
          if (value) {
            contacts.value = await FlutterContacts.getContacts(
                withProperties: true, withAccounts: true, withPhoto: true);
          } else {
            PHelper.showErrorMessageGet(
                title: "Permission Denied 🥺",
                message:
                    "Please allow contacts permission to use this feature");
          }
        },
      );
    }
  }
}
