import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/models/book_model.dart';
import 'package:e_book/models/user_model.dart';
import '../../utils/my_strings.dart';
import 'dart:io';

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

  Future<void> insertNewBookToFireStorage({required Book book}) async {
    books.doc().set(book.toJson());
    return;
  }

  Future<String> uploadFileToFirebaseStorage(File file) async {
    try {
      String fileName = basename(file.path);
      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading file to Firebase Storage: $e');
      return '';
    }
  }
}
