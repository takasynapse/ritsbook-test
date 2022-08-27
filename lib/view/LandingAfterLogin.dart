import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectritsbook_native/view_model/FetchBook.dart';
import "package:projectritsbook_native/view_model/Items.dart";
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

// class LandingPageAfter extends StatefulWidget {
//   @override
//   _LandingPageAfterState createState() => _LandingPageAfterState();
// }


// class _LandingPageAfterState extends State<LandingPageAfter> {
//   // List documentList = ["hahha","ufahfu","oafjoi"];
//   // Future<void> fetchBooks()async{
//   //   final docs = await FirebaseFirestore.instance.collection("textbooks").get();
//   //   final documentList = docs.docs.map((doc)=>doc.data()).toList();
//   // }

//   @override
//   Widget build(BuildContext context) {
//   create: (_)=>MainModel()..fetchBooks();
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("ランディングページ"),
//         ),
//         body: Consumer<MainModel>(
//           builder:(context, model, child){
//             final documentList = model.documentList;
//            ListView.builder(
//             itemCount: documentList.length,
//             itemBuilder: (BuildContext context,int item){
//             // return _buildListItem(documentList[item]);
//             return Text(documentList[item]);
//           }
//           );
//           }
//         ));
//   }
// }

class LandingPageAfter extends StatelessWidget{
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
                  title: Text(documentList[item]["item"])
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

Widget _buildListItem(document) {
  return Container(
    decoration: new BoxDecoration(
      border:new Border(
        bottom: new BorderSide(
          color: Colors.grey,
        ),
      ),
    ),
    child: ListTile(
      leading: Image.asset("images/logo.png"),
      title: Text(
        "aaあ",
        style:TextStyle(
          color: Colors.black,
          fontSize: 20,
        )
      ),
      onTap: (){
        print("aaaa");
      },
      
    )
      );
    }