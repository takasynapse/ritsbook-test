import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectritsbook_native/view_model/Items.dart';


class LandingPageAfter_model extends ChangeNotifier{
  List <Item> items= [];

  Future <void> fetchItems()async{

    final docs = await FirebaseFirestore.instance..collection('textbooks').orderBy("timestamp").get()
    .then(snap => {
      snap.forEach(doc =>{
        const itemData = doc.data();
        itemData.itemID = doc.id;
        items.add(Item(doc));
      });
    // final items = docs.doc.map((doc)=>Item(doc)).toList();
    this.items = items;
    notifyListeners();
    });
  }
}