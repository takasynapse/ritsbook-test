import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String name;
  String faculty;
  String grade;

  UserData({
    required this.name,
    required this.faculty,
    required this.grade,
  });

  ///Firestoreから取得したデータをUserData型に変換
  factory UserData.fromMap(DocumentSnapshot map) {
    return UserData(
      name: map['name'],
      faculty: map['faculty'],
      grade: map['grade'],
    );
  }

  ///Firestore用のMap型に変換
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'faculty': faculty,
      'grade': grade,
    };
  }
}
