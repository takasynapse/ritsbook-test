// import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';



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
  final _user = const types.User(
    id: 'uid', firstName: '名前');

  // final user = const types.User(
  //   id: FirebaseAuth.instance.currentUser!.uid,
  //   name: FirebaseAuth.instance.currentUser!.displayName,
  // ); 
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('チャット'),
        ),
        body: Column(
          mainAxisAlignment:MainAxisAlignment.end,
          children: <Widget>[
            // builder:(context,spnapshot)=>Chat(
            //   messages: _messages,
            //   onSendPressed: _sendMessage,
            //   user: _user,
            // ),
            // Chat(
            //   messages: _messages,
            //   onSendPressed: _sendMessage,
            //   user: _user,
            //   ),
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
        ),
      );

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
  void _handleSendPressed(types.PartialText message) async {
    _addMessage(message.text);
  }
  void _getMessages()async {
    final getData = await FirebaseFirestore.instance.collection('textbooks').doc(widget.document.id).collection('chat').get();
    final messages = getData.docs.
    map((doc) => types.Message.fromJson(doc.data())).toList();
    setState(() {
      _messages = messages;
    });
  }

}