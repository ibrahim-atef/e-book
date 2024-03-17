import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/services/local_services/local_storage_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';
import '../../routes/routes.dart';
import '../../services/remote_services/firestore_methods.dart';
import '../../utils/my_strings.dart';
import '../../utils/themes.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FireStoreMethods _fireStoreMethods = FireStoreMethods();
  FlipCardController flipCardController = FlipCardController();
  bool loginPasswordSecure = true;
  bool signUpPasswordSecure = true;
  bool? isUserX;

  bool? isAdminX;

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Observables for loading states
  final RxBool isLoginLoading = false.obs;
  final RxBool isSignUpLoading = false.obs;

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> init controller Function

  @override
  void onInit() async {
    isAdminX = await isAdmin();
    isUserX = await isUser();
    print("$isAdminX $isUserX");
    // TODO: implement onInit
    super.onInit();
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> show password secure Fun

  void loginVisibility() {
    loginPasswordSecure = !loginPasswordSecure;
    update();
  }

  void signUpVisibility() {
    signUpPasswordSecure = !signUpPasswordSecure;
    update();
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Method to flip login card

  void flipCard() {
    flipCardController.toggleCard();
    update();
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Method to sign up a user using Firebase authentication
  void signUpUsingFirebase({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isSignUpLoading.value = true;
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final UserModel newUser = UserModel(
        userCredential.user!.uid,
        email,
        name,
        false,
        true,
        Timestamp.now(),
      );
      await _fireStoreMethods.insertUserInfoFireStorage(userModel: newUser);
      LocalStorage.saveString(KUid, newUser.uid!);
      LocalStorage.saveString(KRole, usersCollectionKey);
      isSignUpLoading.value = false;
      Get.offNamed(Routes.userHomeScreen);
    } on FirebaseAuthException catch (error) {
      handleAuthError(error);
    } catch (error) {
      handleGeneralError(error);
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Method to login a user using Firebase authentication
  void loginUsingFirebase({
    required String email,
    required String password,
  }) async {
    try {
      isLoginLoading.value = true;
      update();
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final role = await checkUserRole(email);
    await  LocalStorage.saveString(KUid, userCredential.user!.uid.toString());
     await LocalStorage.saveString(KRole, role);
      isLoginLoading.value = false;
      if (role == adminCollectionKey) {
        isAdminX=true;

        Get.offNamed(Routes.adminHomeScreen);
      } else {
        isUserX=true;

        Get.offNamed(Routes.userHomeScreen);
      }

    } on FirebaseAuthException catch (error) {
      handleAuthError(error);
      isLoginLoading.value = false;
      update();
    } catch (error) {
      handleGeneralError(error);
      isLoginLoading.value = false;
      update();
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Method to check the user's role based on their email
  Future<String> checkUserRole(String email) async {
    final adminDocs = await FirebaseFirestore.instance
        .collection(adminCollectionKey)
        .where("email", isEqualTo: email)
        .get();
    final userDocs = await FirebaseFirestore.instance
        .collection(usersCollectionKey)
        .where("email", isEqualTo: email)
        .get();
    if (adminDocs.docs.isNotEmpty) {
      return adminCollectionKey;
    } else if (userDocs.docs.isNotEmpty) {
      return usersCollectionKey;
    } else {
      throw "User not found";
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Handle specific FirebaseAuth errors
  void handleAuthError(FirebaseAuthException error) {
    isSignUpLoading.value = false;
    isLoginLoading.value = false;
    String title = error.code.toString().replaceAll(RegExp('-'), ' ');
    String message = "";
    switch (error.code) {
      case 'weak-password':
        message = "Password is too weak.";
        break;
      case 'email-already-in-use':
        message = "Account already exists.";
        break;
      case 'user-not-found':
        message = "Account does not exist. Create your account by signing up.";
        break;
      case 'wrong-password':
        message = "Invalid Password. Please try again!";
        break;
      default:
        message = error.message.toString();
    }
    showErrorDialog(title, message);
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Handle general errors
  void handleGeneralError(dynamic error) {
    isSignUpLoading.value = false;
    isLoginLoading.value = false;
    showErrorSnackbar("Error", error.toString());
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Show error dialog
  void showErrorDialog(String title, String message) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textCancel: "Ok",
      buttonColor: MAINCOLOR,
      cancelTextColor: PARAGRAPH,
      backgroundColor: WHITE,
    );
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Show error snack-bar
  void showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
    );
  }



  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Sign out from the app
  void signOutFromApp() async {
    try {
      await _auth.signOut();
      LocalStorage.removeString(KRole);
      LocalStorage.removeString(KUid);
      LocalStorage.clear();
      Get.offAllNamed(Routes.loginScreen);
    } catch (error) {
      showErrorDialog("Error", error.toString());
    }
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> check if is user or admin

  Future<bool> isAdmin() async {
    try {
      if (LocalStorage.getString("role") == adminCollectionKey) {
        debugPrint("admin.doc.exists");
        return true;
      }
      return false; // Return false if user is not logged in
    } catch (e) {
      print("Error checking admin status: $e");
      return false; // Return false in case of any errors
    }
  }

  Future<bool> isUser() async {
    try {
      // Check if the current user is a regular user

      if (LocalStorage.getString("role") == usersCollectionKey) {
        debugPrint("user.doc.exists");

        return true;
      }
      return false; // Return false if user is not logged in
    } catch (e) {
      print("Error checking user status: $e");
      return false; // Return false in case of any errors
    }
  }
}
