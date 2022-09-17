//購入した商品一覧のペー
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:projectritsbook_native/view/ItemdetailPage.dart';

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

  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  var purchasedList = <QueryDocumentSnapshot>[];
  var purchasedItemList = <QuerySnapshot>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('purchase')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text('not found');
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, index) {
                var element = snapshot.data?.docs[index];
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('textbooks')
                        .doc(element!.get('itemID'))
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      return ListTile(
                        title: Text(
                            snapshot.hasData ? snapshot.data!.get('item') : ''),
                        leading: Image.network(snapshot.hasData
                            ? snapshot.data!.get('imageurl')
                            : ''),
                        subtitle: Text(snapshot.hasData
                            ? snapshot.data!.get('price').toString()
                            : ''),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemdetailPage(snapshot.data!),
                            ),
                          );
                        },
                      );
                    });
              });
        },
      ),
    );
  }
}