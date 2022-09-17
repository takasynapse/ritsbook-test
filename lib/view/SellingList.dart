//購入した商品一覧のページ
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:projectritsbook_native/view/ItemdetailPage.dart';

class SellingList extends StatefulWidget {
  @override
  _SellingListState createState() => _SellingListState();
}

class _SellingListState extends State<SellingList> {
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
        // final Object userinfo = user;
        userID = user.uid;
      }
    });
  }
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('出品した商品一覧ンゴ'),
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('textbooks')
            .where(uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return  ListTile(
                title:  Text(document['item']),
                leading: Image.network(document['imageurl']),
                subtitle: Text(document['price'].toString()),
                onTap:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemdetailPage(document),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
