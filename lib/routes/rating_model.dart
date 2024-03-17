import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  String? userName;
  Timestamp? rateDate;
  String? userId;
  int? ratingValue;
  String? comment;

  RatingModel(
    this.userName,
    this.userId,
    this.rateDate,
    this.ratingValue,
    this.comment,
  );

  factory RatingModel.fromMap(map) {
    return RatingModel(
      map['userName'],
      map['userId'],
      map['rateDate'],
      map['ratingValue'],
      map['comment'],
    );
  }
}
