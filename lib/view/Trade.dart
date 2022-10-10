// import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';

class TradeChatPage extends StatefulWidget {
  // const ChatPage({super.key});
  final DocumentSnapshot document;
  TradeChatPage(this.document);
  @override
  State<TradeChatPage> createState() => _TradeChatPageState();
}

class _TradeChatPageState extends State<TradeChatPage> {
  // List<types.Message> _messages = [];
  String message = '';
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  final _controller = TextEditingController();

  Future _loadData() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, model, child) {
        return Column(
          children: <Widget>[
            Expanded(
                child: RefreshIndicator(
              onRefresh: () async {
                await _loadData();
              },
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("textbooks")
                      .doc(widget.document.id)
                      .collection("Tradechat")
                      // .orderBy("createdAt", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    // print(documents);
                    // print(widget.document.id);
                    return ListView(
                      reverse: true,
                      children: documents
                          .map((document) => ListTile(
                                title: Text(document['message']),
                                subtitle: Text(document['userName'] ?? "匿名さん"),
                                // subtitle: Text(document['createdAt']
                                // .toDate()
                                // .toString()),
                              ))
                          .toList(),
                    );
                  }),
            )),
            TextField(
              controller: _controller,
              onChanged: (value) => message = value,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
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
    );
  }

// ignore_for_file: avoid_print
  void _addMessage(String message) async {
    await FirebaseFirestore.instance
        .collection('textbooks')
        .doc(widget.document.id)
        .collection('Tradechat')
        .doc()
        .set({
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'message': message,
          'created': DateTime.now(),
          'userName': FirebaseAuth.instance.currentUser!.displayName,
        })
        .then((value) => print("success"))
        .catchError((error) => print(error));

    if (FirebaseAuth.instance.currentUser!.uid != widget.document['userID']) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.document["userID"])
          .collection('information')
          .doc(widget.document.id)
          .set({
            'information': "取引中の商品「”${widget.document["item"]}”」にメッセージを送信しました。",
            'isRead': false,
            'timestamp': DateTime.now(),
          })
          .then((value) => print("success"))
          .catchError((error) => print(error));
    }
  }
}
