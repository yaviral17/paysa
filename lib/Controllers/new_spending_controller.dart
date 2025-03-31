import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:paysa/APIs/api_function.dart';
import 'package:paysa/APIs/firebsae_functions_api.dart';
import 'package:paysa/APIs/firestore_apis.dart';
import 'package:paysa/Controllers/dashboard_controller.dart';
import 'package:paysa/Models/chat_model.dart';
import 'package:paysa/Models/chat_session.dart';
import 'package:paysa/Models/notification_model.dart';
import 'package:paysa/Models/place_details_model.dart';
import 'package:paysa/Models/shopping_model.dart';
import 'package:paysa/Models/spending_model.dart';
import 'package:paysa/Models/split_spending_model.dart';
import 'package:paysa/Models/transfer_spending_model.dart';
import 'package:paysa/Models/user_model.dart';
import 'package:paysa/Models/user_split_model.dart';
import 'package:paysa/Utils/constants/custom_enums.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
import 'package:paysa/Views/Dashboard/dashboard_view.dart';
import 'package:uuid/uuid.dart';

class NewSpendingController {
  Rx<SpendingType> spendingMode = SpendingType.shopping.obs;
  RxString amount = "".obs;
  RxBool isLoading = false.obs;
  RxList<UserSplitModel> splitmembers = <UserSplitModel>[].obs;
  Rx<File> image = File('').obs;

  final storageRef = FirebaseStorage.instance.ref();

  Rx<UserModel?> transferUser = Rx<UserModel?>(null);
  RxList<UserModel> searchedUsers = <UserModel>[].obs;

  TextEditingController messageControler = TextEditingController();

  final ApiFunctions apiFunctions = Get.put(ApiFunctions());

  Future<String?> addFileFirebaseStorage({File? file, String? fileName}) async {
    if (file == null || fileName == null) {
      return null;
    }
    try {
      final spendingStorage = storageRef.child('spendings').child(fileName!);

      await spendingStorage.putFile(file!);

      String imageUrl = await spendingStorage.getDownloadURL();

      return imageUrl;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  Future<void> createSpending() async {
    log("Create Spending : isloading : ${isLoading.value}");
    log("Create Spending : isloading : ${isLoading.value}");
    if (isLoading.value) {
      PHelper.showInfoMessageGet(
        title: "Please Wait",
        message: "Please wait for the current operation to complete",
      );
      log("Please Wait");
      return;
    }
    isLoading.value = true;

    switch (spendingMode.value) {
      case SpendingType.shopping:
        await shoppingCreation();
        break;
      case SpendingType.transfer:
        await transferCreation();
        break;
      case SpendingType.split:
        await splitCreation();
        break;
      case SpendingType.income:
        await incomeCreation();
        break;
      case SpendingType.other:
        log("Other");
        break;
    }

    isLoading.value = false;
  }

  Future<void> shoppingCreation() async {
    if (amount.value.isEmpty) {
      PHelper.showErrorMessageGet(
          title: "Amount is empty", message: "Please enter the amount");
      log("Amount is empty");
      return;
    }
    if (messageControler.text.trim().isEmpty) {
      PHelper.showErrorMessageGet(
          title: "Message is empty 😕", message: "Please enter a message");
      log("Amount is empty");
      return;
    }
    PlaceDetailsModel? placeDetailsModel =
        await apiFunctions.getAddressFromLatLng(
            apiFunctions.currentLocation!.latitude,
            apiFunctions.currentLocation!.longitude);
    double amountValue = double.parse(amount.value);

    if (amountValue <= 0) {
      PHelper.showErrorMessageGet(
          title: "Amount is invalid", message: "Please enter a valid amount");
      log("Amount is invalid");
      return;
    }

    String id = Uuid().v4();

    String? imageUrl =
        await addFileFirebaseStorage(fileName: id, file: image.value);

    SpendingModel spending = SpendingModel(
      id: id,
      createdAt: DateTime.now().toIso8601String(),
      createdBy: FirebaseAuth.instance.currentUser!.uid,
      updatedAt: DateTime.now().toIso8601String(),
      updatedBy: FirebaseAuth.instance.currentUser!.uid,
      spendingType: spendingMode.value,
      billImage: imageUrl ?? "",
      users: [FirebaseAuth.instance.currentUser!.uid],
      location: placeDetailsModel,
      shoppingModel: ShoppingModel(
        amount: amount.value,
        message: messageControler.text.trim(),
        dateTime: DateTime.now(),
        location: "",
        category: "",
      ),
    );

    Get.log(id);
    await FirestoreAPIs.addSpendingToUser(
        FirebaseAuth.instance.currentUser!.uid, spending.id);
    await FirestoreAPIs.addSpending(spending);
    Get.back();
    PHelper.showSuccessMessageGet(
        title: "Spending Created", message: "Spending created successfully");
    log("Spending Created");
  }

  Future<void> transferCreation({PlaceDetailsModel? placeDetailsModel}) async {
    if (transferUser.value == null) {
      PHelper.showErrorMessageGet(
        title: "No User Selected 😕",
        message: "Please select a user !",
      );
      log("No user Selected");
      return;
    }

    if (amount.value.isEmpty) {
      PHelper.showErrorMessageGet(
        title: "Amount is empty",
        message: "Please enter the amount",
      );
      log("Amount is empty");
      return;
    }

    double amountValue = double.parse(amount.value);

    if (amountValue <= 0) {
      PHelper.showErrorMessageGet(
        title: "Amount is invalid",
        message: "Please enter a valid amount",
      );
      log("Amount is invalid");
      return;
    }
    PlaceDetailsModel? placeDetailsModel =
        await apiFunctions.getAddressFromLatLng(
            apiFunctions.currentLocation!.latitude,
            apiFunctions.currentLocation!.longitude);
    String id = Uuid().v4();

    String? imageUrl =
        await addFileFirebaseStorage(fileName: id, file: image.value);
    List<String> users = [
      FirebaseAuth.instance.currentUser!.uid,
      transferUser.value!.uid!,
    ];
    users = PHelper.sortAlphabetically(users);
    String? billUrl =
        await addFileFirebaseStorage(fileName: id, file: image.value);
    SpendingModel spending = SpendingModel(
      id: id,
      createdAt: DateTime.now().toIso8601String(),
      createdBy: FirebaseAuth.instance.currentUser!.uid,
      updatedAt: DateTime.now().toIso8601String(),
      updatedBy: FirebaseAuth.instance.currentUser!.uid,
      spendingType: spendingMode.value,
      billImage: imageUrl ?? "",
      location: placeDetailsModel,
      shoppingModel: null,
      splitSpendingModel: null,
      transferSpendingModel: TransferSpendingModel(
        amount: amount.value,
        message: messageControler.text.trim(),
        dateTime: DateTime.now(),
        location: "",
        transferedFrom: FirebaseAuth.instance.currentUser!.uid,
        transferedTo: transferUser.value!.uid!,
        transferdFromUser: Get.find<DashboardController>().user.value!,
        transferdToUser: transferUser.value!,
      ),
      users: users,
    );
    await FirestoreAPIs.addSpendingToUser(
        FirebaseAuth.instance.currentUser!.uid, spending.id);
    await FirestoreAPIs.addSpendingToUser(
        transferUser.value!.uid!, spending.id);
    await FirestoreAPIs.addSpending(spending);
    String myToken = Get.find<DashboardController>().fcmToken.value;
    String? sessionId = Uuid().v4();
    ChatSession data = ChatSession(
      id: sessionId,
      participants: [
        Get.find<DashboardController>().user.value!,
        transferUser.value!,
      ],
      messages: [
        ChatMessage(
          id: Uuid().v4(),
          message: "Transfer of ${amount.value} sent",
          time: DateTime.now(),
          sender: Get.find<DashboardController>().user.value!,
          isSpending: true,
          spedingId: spending.id,
        ),
      ],
      createdAt: DateTime.now(),
      spendingModel: spending,
      users: users,
      lastMessage: "Transfer of ${amount.value} sent",
    );

    await FirestoreAPIs.checkAndCreateChatSession(data);

    await FirebsaeFunctionsApi.sendNotifications(
      [
        NotificationModel(
            title: "New Transfer Added",
            body:
                "You have received a transfer of ${amount.value} from ${FirebaseAuth.instance.currentUser!.displayName}",
            token: transferUser.value!.token!),
        NotificationModel(
          title: "New Transfer Added",
          body:
              "You have sent a transfer of ${amount.value} to ${transferUser.value!.firstname}",
          token: Get.find<DashboardController>().fcmToken.value,
        ),
      ],
    );

    Get.back();
    PHelper.showSuccessMessageGet(
        title: "Spending Created", message: "Spending created successfully");
    log("Spending Created");
  }

  Future<void> splitCreation({PlaceDetailsModel? placeDetailsModel}) async {
    if (amount.value.isEmpty) {
      PHelper.showErrorMessageGet(
        title: "Amount is empty 😕",
        message: "Please enter the amount",
      );
      log("Amount is empty");
      return;
    }
    double amountValue = double.parse(amount.value);
    if (amountValue <= 0) {
      PHelper.showErrorMessageGet(
        title: "Amount is invalid 😕",
        message: "Please enter a valid amount",
      );
      log("Amount is invalid");
      return;
    }

    if (splitmembers.isEmpty) {
      PHelper.showErrorMessageGet(
        title: "No Members Selected 😕",
        message: "Please select members",
      );
      log("No Members Selected");
      return;
    }
    if (image.value.path.isEmpty) {
      PHelper.showErrorMessageGet(
        title: "No Image Selected 😕",
        message: "Please select an image",
      );
      log("No Image Selected");
      return;
    }
    PlaceDetailsModel? placeDetailsModel =
        await apiFunctions.getAddressFromLatLng(
            apiFunctions.currentLocation!.latitude,
            apiFunctions.currentLocation!.longitude);
    String id = Uuid().v4();

    String? billUrl =
        await addFileFirebaseStorage(fileName: id, file: image.value);
    List<String> users = splitmembers.map((e) => e.uid).toList();

    users = PHelper.sortAlphabetically(users);
    SpendingModel spending = SpendingModel(
      id: id,
      createdAt: DateTime.now().toIso8601String(),
      createdBy: FirebaseAuth.instance.currentUser!.uid,
      updatedAt: DateTime.now().toIso8601String(),
      updatedBy: FirebaseAuth.instance.currentUser!.uid,
      spendingType: spendingMode.value,
      billImage: billUrl ?? "",
      users: users,
      location: placeDetailsModel,
      shoppingModel: null,
      transferSpendingModel: null,
      splitSpendingModel: SplitSpendingModel(
        dateTime: DateTime.now(),
        message: messageControler.text.trim(),
        totalAmount: amount.value,
        userSplit: splitmembers,
        category: "",
        location: "",
      ),
    );

    for (UserSplitModel user in splitmembers) {
      await FirestoreAPIs.addSpendingToUser(user.uid, spending.id);
    }

    await FirestoreAPIs.addSpending(spending);

    String sessionId = Uuid().v4();
    ChatSession data = ChatSession(
      id: sessionId,
      participants: List.generate(
        splitmembers.length,
        (index) {
          return splitmembers[index].user!;
        },
      ),
      messages: [
        ChatMessage(
          id: Uuid().v4(),
          message: "Split of ${amount.value} created",
          time: DateTime.now(),
          sender: Get.find<DashboardController>().user.value!,
          isSpending: true,
          spedingId: spending.id,
        ),
      ],
      createdAt: DateTime.now(),
      spendingModel: spending,
      users: users,
      lastMessage: "Split of ${amount.value} created",
    );
    await FirestoreAPIs.checkAndCreateChatSession(data);
    // send notification
    List<NotificationModel> notifications = [];

    for (UserSplitModel user in splitmembers) {
      if (user.token != null) {
        if (user.uid == FirebaseAuth.instance.currentUser!.uid) {
          PHelper.showSuccessMessageGet(
              title: "Spending Created",
              message: "Spending created successfully");
          continue;
        }
        notifications.add(NotificationModel(
          title: "New Split Added",
          body:
              "You have been added to a split of ${amount.value} by ${Get.find<DashboardController>().user.value!.firstname}",
          token: user.token!,
        ));
      }
    }

    await FirebsaeFunctionsApi.sendNotifications(notifications);
    PNavigate.toAndRemoveUntil(DashMenuView());
  }

  Future<void> incomeCreation() async {
    log("Income");
  }

  Future<void> otherCreation() async {
    log("Other");
  }
}
