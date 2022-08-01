import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectritsbook_native/view_model/Items.dart';


class LandingPageAfter extends StatefulWidget {
  @override
  _LandingPageAfterState createState() => _LandingPageAfterState();
}

class _LandingPageAfterState extends State<LandingPageAfter>{
  List<Item> items = [];

  Future<void> fetchBooks() async{
    final snapshot = await FirebaseFirestore.instance.collection('textbooks').get();
    setState(() {
      List items = snapshot.docs;
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('ランディングページ'),
      ),
      body: Center(
        child: Column(

        children:<Widget> [
          ListView(
            children: items.map((Item item){
              return ListTile(
                title: Text(item.item),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: (){
              fetchBooks();
            },
            child: Text('更新'),
          ),
        ],
        ),
        ),
      );
      }
}