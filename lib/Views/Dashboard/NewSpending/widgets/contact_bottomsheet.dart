import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Controllers/contact_controller.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/utils/theme/colors.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../../../Utils/helpers/helper.dart';

class ContactBottomSheet extends StatefulWidget {
  ContactBottomSheet({super.key});

  @override
  State<ContactBottomSheet> createState() => _ContactBottomSheetState();
}

class _ContactBottomSheetState extends State<ContactBottomSheet> {
  final ContactsController contactController = Get.put(ContactsController());
  final TextEditingController searchController = TextEditingController();
  RxList filteredContacts = [].obs;

  @override
  void initState() {
    super.initState();
    // filteredContacts.addAll(contactController.contactList);

    // searchController.addListener(() {
    //   filterContacts(searchController.text);
    // });
  }

  void filterContacts(String query) {
    // if (query.isEmpty) {
    //   filteredContacts.assignAll(contactController.contactList);
    // } else {
    //   filteredContacts.assignAll(
    //     contactController.contactList.where((contact) =>
    //         contact.displayName?.toLowerCase().contains(query.toLowerCase()) ??
    //         false),
    //   );
    // }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'Contacts',
                  style: TextStyle(
                    fontSize: PSize.arw(context, 40),
                    fontWeight: FontWeight.w400,
                    color: PColors.primaryTextDark,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    size: PSize.arw(context, 26),
                    color: PColors.secondaryText(context),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: PSize.arw(context, 10)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Contacts',
                hintStyle: TextStyle(
                  fontSize: PSize.arw(context, 14),
                  color: PColors.secondaryText(context),
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: PColors.secondaryText(context),
                ),
                filled: true,
                fillColor: PColors.containerSecondary(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: PSize.arw(context, 20)),
          SizedBox(
            height: PSize.arh(context, 80),
            child: Obx(() {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    filteredContacts.length,
                    (i) => GestureDetector(
                      onTap: () {
                        // var contact = filteredContacts[i];
                        // if (contactController.selectedContactList
                        //     .contains(contact)) {
                        //   PHelper.showErrorMessageGet(
                        //       title: 'Contact Already Added',
                        //       message: 'Contact Already Added');
                        // } else {
                        //   contactController.selectedContactList.add(contact);
                        // }
                      },
                      child: Row(
                        children: [
                          SizedBox(width: PSize.arw(context, 10)),
                          Column(
                            children: [
                              SizedBox(
                                height: PSize.arw(context, 50),
                                width: PSize.arw(context, 50),
                                child: RandomAvatar(
                                  filteredContacts[i].displayName ?? 'User',
                                ),
                              ),
                              SizedBox(width: PSize.arw(context, 10)),
                              Text(
                                filteredContacts[i].displayName ?? 'User',
                                style: TextStyle(
                                  color: PColors.primaryTextDark,
                                  fontSize: PSize.arw(context, 14),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: PSize.arw(context, 10)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
