import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MainModel extends ChangeNotifier{
  List documentList = [];
  Future<void> fetchBooks()async{
    final docs = await FirebaseFirestore.instance.collection("textbooks").get();
    final documentList = docs.docs.map((doc)=>doc.data()).toList();
    this.documentList = documentList;
    notifyListeners();
  }
}