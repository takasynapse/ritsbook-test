
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectritsbook_native/view/ItemdetailPage.dart';
import 'package:projectritsbook_native/view_model/FetchNotifications.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget{
  @override
  _NotificationPageState createState() => _NotificationPageState();
}
// <>の中は戻り値の指定
  Future<DocumentSnapshot> getBook(itemID)async{
    DocumentSnapshot docs = await FirebaseFirestore.instance.collection("textbooks").doc(itemID).get() as DocumentSnapshot;
    return docs as DocumentSnapshot;
  }
class _NotificationPageState extends State<NotificationPage>{
  Widget build(BuildContext context){
    return MaterialApp(
      home: ChangeNotifierProvider<MainModel>(
        create:(_) => MainModel()..fetchNotifications(),
        child:Scaffold(
        appBar:AppBar(
          title:Text("通知"),
        ),
        body:Consumer<MainModel>(
          builder:(context,model,child){
            final documentList = model.documentList;
            return ListView.builder(
              itemCount: documentList.length,
              itemBuilder: (BuildContext context,int item){
                return ListTile(
                  title: Text(documentList[item]["information"]),
                  onTap:() {
                    final DocumentSnapshot test = getBook(documentList[item].id) as DocumentSnapshot;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemdetailPage(test),
                      ),
                    );
                    },
                );
              }
            );
          }
        )
        )
        )
        );
  }
}
