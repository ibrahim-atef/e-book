import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user_model.dart';
import '../../services/remote_services/firestore_methods.dart';
import '../../view/widgets/admin_panal_widgets/add_book_dialog.dart';

class AdminHomeController extends GetxController {
  // Observables
  RxList usersWithRequist = [].obs;
  RxBool isConfirming = false.obs;
  RxBool isDecliningUser = false.obs;
  RxString pdfPathName = "".obs;
  RxString audioPathName = "".obs;
  RxString imagePathName = "".obs;
  File? pdfFilePath;
  File? audioFilePath;
  File? imageFilePath;

  // FirebaseAuth instance and other helpers
  FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _imagePicker = ImagePicker();
  final FileUploadInputElement _fileUploadInput = FileUploadInputElement();
  final InputElement _voiceUploadInput = InputElement();

  // Lifecycle method
  @override
  void onInit() async {
    getUsersRequistList();
    super.onInit();
  }

  // Fetch user request list from Firestore
  getUsersRequistList() async {
    await FireStoreMethods()
        .users
        .where('isActivateRequist', isEqualTo: true)
        .snapshots()
        .listen((event) {
      usersWithRequist.clear();
      for (int i = 0; i < event.docs.length; i++) {
        usersWithRequist.add(UserModel.fromMap(event.docs[i]));
      }
      update();
    });
  }

  // Confirm user request
  confirmUserRequest({required String userId}) {
    isConfirming.value = true;
    update();
    return FireStoreMethods().users.doc(userId).update({
      "isActivate": true,
      "isActivateRequist": false,
    }).then((value) async {
      Get.snackbar(
        "Updated ✔✔",
        "user Confirmed Successfully",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
      );
      isConfirming.value = false;
      update();
    }).catchError((error) {
      isConfirming.value = false;
      update();
      Get.snackbar(
        "Error",
        "$error",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    });
  }

  // Decline user request
  declineUserRequest({required String userId}) async {
    isDecliningUser.value = true;
    return FireStoreMethods().users.doc(userId).delete().then((value) async {
      await _auth.currentUser!.delete();
      isDecliningUser.value = false;
      Get.snackbar(
        "Deleted ✔✔",
        "user Deleted Successfully",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
      );
    }).catchError((onError) {
      isDecliningUser.value = false;
      update();
      Get.snackbar(
        "Error",
        "$onError",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    });
  }

  // Pick PDF file
  void pickPdfFile() async {
    // Use the specific type FileUploadInputElement here
    FileUploadInputElement uploadInput = FileUploadInputElement()
      ..accept = 'application/pdf';

    uploadInput.click();

    await uploadInput.onChange.first;

    final files = uploadInput.files;
    if (files != null && files.isNotEmpty) {
      final file = files[0];
      if (file.type != 'application/pdf') {
        showSnackbar('Error', 'Only PDF files are allowed.', Colors.red);

        return null;
      }

      pdfFilePath = file;
      pdfPathName.value = file.name;
      print(pdfFilePath!.name + " picked");
      update();
    }
  }

  // Show snack bar message
  void showSnackbar(String title, String message, Color backgroundColor) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      snackPosition: SnackPosition.TOP,
    );
  }

  // Pick cover image
  void pickCoverImage() async {
    FileUploadInputElement uploadInput = FileUploadInputElement()
      ..accept = 'image/*' // Accept any image format
      ..multiple = false; // Allow only single file selection

    uploadInput.click();

    await uploadInput.onChange.first;

    final files = uploadInput.files;
    if (files != null && files.isNotEmpty) {
      final file = files[0]; // Access the first (and only) selected file

      // Validate file type (optional for added security)
      if (!file.type.startsWith('image/')) {
        showSnackbar('Error', 'Only image files are allowed.', Colors.red);
        return;
      }

      // Handle limitations on Flutter web
      if (kIsWeb) {
        print('**Important:** Direct image data access is limited on Flutter web.');
        print('Consider server-side uploading or alternative approaches.');
        imageFilePath = file;
        imagePathName.value = file.name;
        print(imageFilePath!.name + " picked");
        update();
        // Implement server-side image upload logic here, or use alternative workarounds
        // as discussed previously (e.g., limited image selection with file_picker).
      } else {
        // Handle image file directly on other platforms (e.g., mobile, desktop)
        imageFilePath = file;
        imagePathName.value = file.name;
        print(imageFilePath!.name + " picked");
        update(); // Assuming a function to update UI elements
      }
    } else {
      // Handle no file selected case (optional)
      print('No image selected.');
    }
  }

  // Pick voice file
  Future<void> pickVoice() async {
    // Constrain input to audio files
    FileUploadInputElement uploadInput = FileUploadInputElement()
      ..accept = 'audio/*'; // Accept any audio file type

    uploadInput.click();

    await uploadInput.onChange.first;

    final files = uploadInput.files;
    if (files != null && files.isNotEmpty) {
      final file = files[0];
      if (!file.type.startsWith('audio/')) {
        showSnackbar('Error', 'Only audio files are allowed.', Colors.red);
        return null;
      }

      audioFilePath = file;
      audioPathName.value = file.name;
      print(audioFilePath!.name + " picked");
      update(); // Assuming a function to update UI elements
    }
  }

  // Add new book
  void addNewBook() {
    // Implement adding a new book logic
  }
}
