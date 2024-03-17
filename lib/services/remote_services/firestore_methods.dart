import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/models/user_model.dart';
import '../../utils/my_strings.dart';

class FireStoreMethods {
  CollectionReference users =
      FirebaseFirestore.instance.collection(usersCollectionKey);

  Future<void> insertStudentsInfoFireStorage(
      {required UserModel userModel}) async {
    users.doc(userModel.uid).set(userModel.toJson());
    return;
  }


}
