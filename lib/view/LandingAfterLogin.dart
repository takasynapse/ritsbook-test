import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'package:projectritsbook_native/view/ItemdetailPage.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectritsbook_native/view_model/FetchBook.dart';
import "package:projectritsbook_native/view_model/Items.dart";
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LandingPageAfter extends StatefulWidget {
  @override
  _LandingPageAfterState createState() => _LandingPageAfterState();
}


class _LandingPageAfterState extends State<LandingPageAfter> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: ChangeNotifierProvider<MainModel>(
        create:(_) => MainModel()..fetchBooks(),
        child:Scaffold(
        appBar:AppBar(
          title:Text("ランディングページ"),
        ),
        body:Consumer<MainModel>(
          builder:(context,model,child){
            final documentList = model.documentList;
            return ListView.builder(
              itemCount: documentList.length,
              itemBuilder: (BuildContext context,int item){
                return ListTile(
                  title: Text(documentList[item]["item"]),
                  leading: Image.network(documentList[item]["imageurl"]),
                  subtitle: Text(documentList[item]["price"].toString()),
                  onTap:() {
                    // print(documentList[item].id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemdetailPage(documentList[item]),
                      ),
                    );},
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
