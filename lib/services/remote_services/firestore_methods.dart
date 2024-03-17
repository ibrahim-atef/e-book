import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/models/book_model.dart';
import 'package:e_book/models/user_model.dart';
import '../../utils/my_strings.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
class FireStoreMethods {
  CollectionReference users =
      FirebaseFirestore.instance.collection(usersCollectionKey);
  CollectionReference books =
      FirebaseFirestore.instance.collection(booksCollectionKey);

  Future<void> insertUserInfoFireStorage({required UserModel userModel}) async {
    users.doc(userModel.uid).set(userModel.toJson());
    return;
  }

  Future<void> insertNewBookToFireStore({required Book book}) async {
    try {
      // Validate the book object before insertion (e.g., check required fields)


      // Add the book data to Firestore with automatic ID generation
      await books.add(book.toJson());

      // Log success or perform any additional actions
      print('New book added to Firestore successfully.');
    } catch (e) {
      // Handle any errors (e.g., log, show error message, etc.)
      print('Error adding new book to Firestore: $e');
      throw e; // Rethrow the exception to propagate it to the caller
    }
  }

  Future<String> uploadFileToFirebaseStorage(File file) async {
    try {
      String fileName = basename(file.name);
      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putBlob(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading file to Firebase Storage: $e');
      return '';
    }
  }
}
