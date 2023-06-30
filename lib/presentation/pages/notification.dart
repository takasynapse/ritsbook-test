import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  NotificationPageState createState() => NotificationPageState();
}

// <>の中は戻り値の指定
// ignore: prefer_typing_uninitialized_variables
var itemData;
Future getBook(itemID) async {
  DocumentSnapshot docs = await FirebaseFirestore.instance
      .collection("textbooks")
      .doc(itemID)
      .get();
  itemData = docs;
}

class NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "通知",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: const Center(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("出品された商品が購入された際や、\nコメントがつくと通知が送られます"),
        )));
  }
}

        // body: ChangeNotifierProvider<MainModel>(
        //     create: (_) => MainModel()..fetchNotifications(),
        //     child: Scaffold(
        //         appBar: AppBar(
        //           title: const Text(
        //             "通知",
        //             style: TextStyle(color: Colors.black),
        //           ),
        //           backgroundColor: Colors.white,
        //         ),
        //         body: Consumer<MainModel>(builder: (context, model, child) {
        //           final documentList = model.documentList;
        //           return ListView.builder(
        //               itemCount: documentList.length,
        //               itemBuilder: (BuildContext context, int item) {
        //                 return ListTile(
        //                   title: Text(documentList[item]["information"]),
        //                   trailing: const Icon(Icons.arrow_forward_ios),
        //                   onTap: () {
        //                     // final DocumentSnapshot test = getBook(documentList[item].id) as DocumentSnapshot;
        //                     getBook(documentList[item].id);
        //                     Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                         builder: (context) => ItemDetailPage(itemData),
        //                       ),
        //                     );
        //                   },
        //                 );
        //               });
        //         }))));