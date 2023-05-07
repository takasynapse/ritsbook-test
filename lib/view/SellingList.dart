//購入した商品一覧のページ
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:projectritsbook_native/view/itemdetail.dart';

class SellingList extends StatefulWidget {
  @override
  _SellingListState createState() => _SellingListState();
}

class _SellingListState extends State<SellingList> {
  String? userID;
  //ライフサイクルフックにおいてcreated時にユーザがログインしているか検証

  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    if (uid == null) {
      return const Scaffold(
        body: Center(
          child: Text('ログインしてください'),
        ),
      );
    } else {
      return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('textbooks')
              // .orderBy('timestamp', descending: true)
              .where("userID", isEqualTo: uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Text("出品した商品はありません");
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text(document['item']),
                    leading: Image.network(document['img_url']),
                    subtitle: Text(document['price'].toString()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetailPage(document),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      );
    }
  }
}
