// import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';

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
  // List<types.Message> _messages = [];
  String message = '';
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final _controller = TextEditingController();

  Future _loadData() async {
    print('aaa');
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider<MainModel>(
            create: (_) => MainModel()..fetchChat(widget.document.id),
            child: Scaffold(
              appBar: AppBar(
                title:const Text("チャット"),
              ),
              body: Center(
                child: Consumer<MainModel>(builder: (context, model, child) {
                  final documentList = model.documentList;
                  return Column(
                    children: <Widget>[
                      Expanded(
                          child: RefreshIndicator(
                        onRefresh: () async {
                          await _loadData();
                        },
                        child: ListView.builder(
                            physics:const AlwaysScrollableScrollPhysics(),
                            itemCount: documentList.length,
                            itemBuilder: (BuildContext context, int item) {
                              return ListTile(
                                title: Text(documentList[item]["message"]),
                                subtitle: Text(
                                    documentList[item]["userName"].toString()),
                              );
                            }),
                      )),
                      TextField(
                        controller: _controller,
                        onChanged: (value) => message = value,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon:const Icon(Icons.send),
                            onPressed: () {
                              _addMessage(message);
                              _controller.clear();
                            },
                          ),
                          hintText: 'メッセージを入力してください',
                        ),
                      ),
                    ],
                  );
                }),
              ),
            )));
  }
// ignore_for_file: avoid_print
  void _addMessage(String message) async {
    await FirebaseFirestore.instance
        .collection('textbooks')
        .doc(widget.document.id)
        .collection('chat')
        .doc()
        .set({
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'message': message,
          'created': DateTime.now(),
          'userName': FirebaseAuth.instance.currentUser!.displayName,
        })
        
        .then((value) =>print("success"))
        .catchError((error) => print(error));

    if (FirebaseAuth.instance.currentUser!.uid != widget.document['userID']) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.document["userID"])
          .collection('information')
          .doc(widget.document.id)
          .set({
            'information': "出品中の商品「”${widget.document["item"]}”」にメッセージを送信しました。",
            'isRead': false,
            'timestamp': DateTime.now(),
          })
          .then((value) => print("success"))
          .catchError((error) => print(error));
    }
  }
}
