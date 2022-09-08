// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';

// class MainModel extends ChangeNotifier{
//   List documentList = [];
//   Future<void> fetchPurchased()async{
//     final docs = await FirebaseFirestore.instance.collection("users").doc('purchase').get();
//     // getter docs: docs(List<QueryDocumentSnapshot<T>>型)のドキュメント全てをリストにして取り出す。
//     // toList(): Map()から返ってきたIterable→Listに変換する
//     final documentList = 
//     docs.docs.
//     map((doc)=>
//     doc
//     )
//     .toList();
//     this.documentList = documentList;
//     notifyListeners();
//   }
// }