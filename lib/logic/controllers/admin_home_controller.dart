import 'dart:html';

import 'package:e_book/models/book_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';
import '../../services/remote_services/firestore_methods.dart';

class AdminHomeController extends GetxController {
  // Observables
  RxList usersWithRequist = [].obs;
  RxList<Book> booksList = <Book>[].obs;
  RxBool isConfirming = false.obs;
  RxBool isDecliningUser = false.obs;
  RxBool isUploadingNewBook = false.obs;
  RxString pdfPathName = "".obs;
  RxString audioPathName = "".obs;
  RxString imagePathName = "".obs;
  File? pdfFilePath;
  File? audioFilePath;
  File? imageFilePath;

  // FirebaseAuth instance and other helpers
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Lifecycle method
  @override
  void onInit() async {
    getUsersRequistList();
    getBooksList();
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
   getBooksList() async {
    await FireStoreMethods()
        .books

        .snapshots()
        .listen((event) {
      booksList.clear();
      for (int i = 0; i < event.docs.length; i++) {
        booksList.add(Book.fromJson(event.docs[i]));
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
        print(
            '**Important:** Direct image data access is limited on Flutter web.');
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

  void addNewBook({
    required String title,
    required String category,
    required String author,
    required BuildContext context,
  }) async {
    isUploadingNewBook.value = true;

    try {
      // Check if any of the required files (audio, image, PDF) is not selected
      if (pdfFilePath == null || audioFilePath == null || imageFilePath == null) {
        // Show a snackbar or dialog to inform the user to complete the data
        isUploadingNewBook.value = false;
        Get.snackbar(
          "Incomplete Data",
          "Please add all required files (BOOK PDF, BOOK VOICE, BOOK COVER).",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
        return; // Exit the method without proceeding
      }

      // All required files are selected, proceed with uploading and adding the new book
      String pdfLink = await FireStoreMethods().uploadFileToFirebaseStorage(pdfFilePath!);
      String coverLink = await FireStoreMethods().uploadFileToFirebaseStorage(imageFilePath!);
      String voiceLink = await FireStoreMethods().uploadFileToFirebaseStorage(audioFilePath!);

      // Check if any upload failed
      if (pdfLink == null || coverLink == null || voiceLink == null) {
        throw Exception('Error uploading files to Firebase Storage.');
      }

      // All files uploaded successfully, now insert the new book to Firestore
      await FireStoreMethods().insertNewBookToFireStore(
        book: Book(
          title: title,
          coverImage: coverLink,
          pdfLink: pdfLink,
          category: category,
          author: author,
          voiceLink: voiceLink,
        ),
      );

      // Show success message and navigate back
      showSnackbar("Done", "New book added successfully", Colors.greenAccent);
      isUploadingNewBook.value = false;
     Navigator.pop(context);
    } catch (e) {
      // Handle any errors during the process
      print('Error adding new book: $e');
      isUploadingNewBook.value = false;
      Get.snackbar(
        "Error",
        "Failed to add new book. Please try again later.",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    }
  }



}
