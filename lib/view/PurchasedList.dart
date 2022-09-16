//購入した商品一覧のページ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_storage/firebase_storage.dart';

class PurchasedList extends StatefulWidget {
  @override
  _PurchasedListState createState() => _PurchasedListState();
}

class _PurchasedListState extends State<PurchasedList> {
  String? userID;
  //ライフサイクルフックにおいてcreated時にユーザがログインしているか検証
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        print('userinfo:');
        userID = user.uid;
      }
    });
  }
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  var purchasedList = [];
  var purchasedItemList = [];
  @override
  Widget build(BuildContext context) {
    print('aa');
    stream:FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('purchase')
            .snapshots()
            .forEach((element) {
              element.docs.forEach((element) {
                purchasedList.add(element.data());
              });
            });
    stream: for(var i in purchasedList){
     purchasedItemList.add(FirebaseFirestore.instance
            .collection('textbooks')
            .doc(i['itemID'])
            .snapshots());
    }
    return Scaffold(
              body: ListView(
            children: purchasedItemList.map((DocumentSnapshot document) {
              return ListTile(
                title: Text(document['itemID']),
                // subtitle: Text(document['price'].toString()),
              );
            }).toList(),
          );
    );
  }
}
