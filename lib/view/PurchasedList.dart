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
        print(user);
        // final Object userinfo = user;
        userID = user.uid;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('購入した商品一覧ンゴ'),
      ),
    );
  }
}
