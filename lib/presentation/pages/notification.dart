import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectritsbook_native/view_model/FetchNotifications.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

var itemData;
// <>の中は戻り値の指定
Future getBook(itemID) async {
  DocumentSnapshot docs = await FirebaseFirestore.instance
      .collection("textbooks")
      .doc(itemID)
      .get();
  itemData = docs;
}

class _NotificationPageState extends State<NotificationPage> {
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
