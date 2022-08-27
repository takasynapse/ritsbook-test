import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:projectritsbook_native/view_model/Items.dart";

class LandingPageAfter extends StatefulWidget {
  @override
  _LandingPageAfterState createState() => _LandingPageAfterState();
}


class _LandingPageAfterState extends State<LandingPageAfter> {
  List documentList = ["hahha","ufahfu","oafjoi"];
  Future<void> fetchBooks()async{
    final docs = await FirebaseFirestore.instance.collection("items").get();
    final documentList = docs.docs.map((doc)=>doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ランディングページ"),
        ),
        body: Center(
          child: ListView.builder(
            itemBuilder: (BuildContext context,int item){
            // return _buildListItem(documentList[item]);
            return Text(documentList[item]);
          }
          ),
        ));
  }
}

Widget _buildListItem(String document) {
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