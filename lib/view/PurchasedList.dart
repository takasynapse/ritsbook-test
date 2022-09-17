//購入した商品一覧のペー
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_storage/firebase_storage.dart';
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
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  var purchasedList = [];
  var purchasedItemList = [];
  // @override
//   Widget build(BuildContext context) {
//     stream:FirebaseFirestore.instance
//             .collection('users')
//             .doc(uid)
//             .collection('purchase')
//             .snapshots()
//             .forEach((element) {
//               element.docs.forEach((element) {
//                 purchasedList.add(element.data());
//               });
//             });
//     stream: for(var i in purchasedList){
//       FirebaseFirestore.instance
//             .collection('textbooks')
//             .doc(i['item'])
//             .snapshots()
//             .forEach((element) {
//               purchasedItemList.add(element.data());
//               print(element.data());
//             });
//         return Scaffold(
//           body: ListView.builder(
//             itemCount: purchasedItemList.length,
//             itemBuilder: (BuildContext context, int index) {
//               return ListTile(
//                 title: Text(purchasedItemList[index]['item']),
//                 leading: Image.network(purchasedItemList[index]['imageurl']),
//                 subtitle: Text(purchasedItemList[index]['price'].toString())
//               );
//             },
//           ),
//         );
//   }
// }
  @override
  Widget build(BuildContext context){
 stream:FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('purchase')
            .snapshots()
            .forEach((element) {
              element.docs.forEach((element) {
                purchasedList.add(element.data());
              });
              print(purchasedList);
        for(var i in purchasedList){
      FirebaseFirestore.instance
            .collection('textbooks')
            .doc(i["itemID"].toString())
            .snapshots()
            .forEach((element) {
              purchasedItemList.add(element.data());
              print(element.data());
              print(i);
              print('aaaaaaaaaaaaaaaaaaaaaaaa');
              print(purchasedItemList[0]["item"]);
            });
            }
    }
            );
  return Scaffold(
          body: ListView.builder(
            itemCount: purchasedItemList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(purchasedItemList[index]['item']),
                leading: Image.network(purchasedItemList[index]['imageurl']),
                subtitle: Text(purchasedItemList[index]['price'].toString())
              );
            },
          ),
        );
  }  }
