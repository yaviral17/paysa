import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

class SettingsController {
  late String fileName;
  final user = FirebaseAuth.instance.currentUser;
  Uint8List? _image;
  String? imageUrl;

  pickImage(ImageSource source) async {
    final ImagePicker imagepicker = ImagePicker();
    XFile? file = await imagepicker.pickImage(source: source);

    if (file != null) {
      return await file.readAsBytes();
    }
    log('No image selected.');
  }

  Future<Uint8List> selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    return img;
  }

  Future<String?> uploadImageToFirebaseStorage(Uint8List imageBytes) async {
    try {
      // Generate a unique filename
      fileName = '${user!.uid}profileImage.jpg';

      log('Uploading image: $fileName');

      // Upload image to Firebase Storage
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('user_data')
          .child(fileName);
      // await ref.delete();
      await ref.putData(imageBytes);

      // Get download URL of the uploaded image
      String imageUrl = await ref.getDownloadURL();

      log('Image uploaded: $imageUrl');

      return imageUrl;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  Future<void> updateProfileInFirebase(BuildContext context) async {
    try {
      File? img = await THelperFunctions.pickImageWithCrop(context, false);

      if (img == null) {
        THelperFunctions.showErrorMessageGet(
            title: 'Image Not Found', message: 'No image selected.');
      }
      _image = await img!.readAsBytes();

      imageUrl = await uploadImageToFirebaseStorage(_image!);
      // Update user's profile image
      if (imageUrl != null) {
        await user!.updatePhotoURL(imageUrl);
      }
    } catch (e) {
      log('Error updating profile: $e');
    }
  }
}
