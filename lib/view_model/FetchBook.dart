import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MainModel extends ChangeNotifier{
  List documentList = [];
  Future<void> fetchBooks()async{
    final docs = await FirebaseFirestore.instance.collection("textbooks").get();
    // getter docs: docs(List<QueryDocumentSnapshot<T>>型)のドキュメント全てをリストにして取り出す。
    // toList(): Map()から返ってきたIterable→Listに変換する
    final documentList = docs.docs.
    map((doc)=>doc)
    .toList();
    this.documentList = documentList;
    notifyListeners();
  }
}