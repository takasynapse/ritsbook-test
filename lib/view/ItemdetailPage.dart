import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectritsbook_native/view_model/FetchBook.dart';
import "package:projectritsbook_native/view_model/Items.dart";
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ItemdetailPage extends StatefulWidget {
  // final DocumentSnapshot document;
  final Map document;
  ItemdetailPage(this.document);
  @override
  _ItemdetailPageState createState() => _ItemdetailPageState();
}


Future<void>Purchase(item) async{
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user != null) {
      print('aaaaaaaaaaaaaaaaa');
      // print(item.id);
      FirebaseFirestore.instance.collection('users').doc(user.uid).collection('purchase').doc().set({
        'itemID': item["id"],
      });
      FirebaseFirestore.instance.collection('items').doc(item["itemID"]).update({
        'isSold': false,
      });
    }
  });
}
class _ItemdetailPageState extends State<ItemdetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品詳細"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.network(widget.document["imageurl"]),
            Text(widget.document["item"]),
            Text(widget.document["price"].toString()),
            Text(widget.document["description"]),
            Text(widget.document["condition"]),
            ElevatedButton(
              onPressed:(){
              Purchase(widget.document);
              },
              child: Text("購入する"),
            ),
            ElevatedButton(
              onPressed: (){
                print(widget.document);
              }, 
              child: Text("編集する"),
            ),
          ],
        ),
      ),
    );
  }
}

