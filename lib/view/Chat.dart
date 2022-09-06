// import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:projectritsbook_native/view_model/FetchChat.dart';
import 'package:provider/provider.dart';



class ChatPage extends StatefulWidget {
  // const ChatPage({super.key});
  final DocumentSnapshot document;
  ChatPage(this.document);
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  String message = '';
  final String uid = FirebaseAuth.instance.currentUser!.uid; 
  // final _user = const types.User(
  //   id: 'uid', firstName: '名前');
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: ChangeNotifierProvider<MainModel>(
        create:(_) => MainModel()..fetchChat(widget.document.id),
        child:Scaffold(
        appBar:AppBar(
          title:Text("チャット"),
        ),
        body:Center(
          child: Consumer<MainModel>(
            builder:(context,model,child){
              final documentList = model.documentList;
              return Column(
                children: <Widget>[
                  Expanded(
                    child:ListView.builder(
                    itemCount: documentList.length,
                    itemBuilder: (BuildContext context,int item){
                      return ListTile(
                        title: Text(documentList[item]["message"]),
                        subtitle: Text(documentList[item]["userName"].toString()),
                      );
                    }
                  )
                  ),
          TextField(
              onChanged: (value) => message = value,
              decoration: InputDecoration(
                hintText: 'メッセージを入力してください',
              ),
            ),
            ElevatedButton(
              onPressed: (){
              _addMessage(message); 
              },
            child: Text('送信')),
                ],
              );
            }
          ),
        ),
        )
        )
        );
  }

  void _sendMessage(types.PartialText text) {
    print(text);
  }
  void _addMessage(String message) async{
    print('aaaaaaaaaaaaaaaaaaaaaaaa');
    await FirebaseFirestore.instance.collection('textbooks').doc(widget.document.id).collection('chat').doc().set({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'message': message,
      'created': DateTime.now(),
      'userName' : FirebaseAuth.instance.currentUser!.displayName,
    }).then((value) => print("success")).catchError((error) => print(error));
    setState(() {
      message = '';
    });

    if(FirebaseAuth.instance.currentUser!.uid != widget.document['userID']){
      await FirebaseFirestore.instance.collection('users').doc(widget.document["userID"]).collection('information').doc(widget.document.id).set({
        'information': "出品中の商品「”${widget.document["item"]}”」にメッセージを送信しました。",
        'isRead': false,
        'timestamp': DateTime.now(),
      }).then((value) => print("success")).catchError((error) => print(error));
    }
  }
  // void _handleSendPressed(types.PartialText message) async {
  //   _addMessage(message.text);
  // }
  // void _getMessages()async {
  //   final getData = await FirebaseFirestore.instance.collection('textbooks').doc(widget.document.id).collection('chat').get();
  //   final messages = getData.docs.
  //   map((doc) => types.Message.fromJson(doc.data())).toList();
  //   setState(() {
  //     _messages = messages;
  //   });
  }

