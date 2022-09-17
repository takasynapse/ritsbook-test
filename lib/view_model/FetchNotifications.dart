import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MainModel extends ChangeNotifier{
  List documentList = [];
  String? userID = FirebaseAuth.instance.currentUser?.uid;
  Future<void> fetchNotifications()async{
    final docs = await FirebaseFirestore.instance.collection("users").doc(userID).collection("information").get();
    // getter docs: docs(List<QueryDocumentSnapshot<T>>型)のドキュメント全てをリストにして取り出す。
    // toList(): Map()から返ってきたIterable→Listに変換する
    final documentList = docs.docs.
    map((doc)=>doc)
    .toList();
    this.documentList = documentList;
    notifyListeners();
  }
}