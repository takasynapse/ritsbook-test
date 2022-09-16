// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';

// class MainModel extends ChangeNotifier{
//   List documentList = [];
//   Future<void> fetchChat(document)async{
//     final docs = await FirebaseFirestore.instance.collection("textbooks").doc(document).collection("chat").snapshots();
//     // getter docs: docs(List<QueryDocumentSnapshot<T>>型)のドキュメント全てをリストにして取り出す。
//     // toList(): Map()から返ってきたIterable→Listに変換する
//     final documentList = docs.
//     map((doc)=>doc)
//     .toList();
//     this.documentList = documentList;
//     notifyListeners();
//   }
// }