import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? name;
  Timestamp? registerDate;
  bool? isActivate;
  bool? isActivateRequist;
  String? uid;

  UserModel(
    this.uid,
    this.email,
    this.name,
    this.isActivate,
    this.isActivateRequist,
    this.registerDate,
  );

  factory UserModel.fromMap(map) {
    return UserModel(
      map['uid'],
      map['email'],
      map['name'],
      map['isActivate'],
      map['isActivateRequist'],
      map['registerDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'registerDate': registerDate,
      'isActivate': isActivate,
      'isActivateRequist': isActivateRequist,
      'uid': uid,
    };
  }
}
