import 'dart:io';

import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class ChatPage extends StatefulWidget {
  final DocumentSnapshot document;
  ChatPage(this.document);
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  String randomId = DateTime.now().millisecondsSinceEpoch.toString();
  // final username = FirebaseAuth.instance.currentUser!.displayName;
  final _user = types.User(
    id: '313wfww',
    firstName: 'test',
  );

  void initState() {
    _getMessages();
    super.initState();
  }

  void _getMessages() async {
    final getData = await FirebaseFirestore.instance
        .collection("textbooks")
        .doc(widget.document.id)
        .collection("chat")
        .get();

    final message = getData.docs
        .map((d) => types.TextMessage(
              author: types.User(
                id: d["user"]["id"],
                firstName: d["user"]["firstName"],
              ),
              id: d.id,
              text: d.data()["text"],
            ))
        .toList();
    setState(() {
      _messages = message;
    });
  }

  // メッセージ内容をfirestoreにセット
  void _addMessage(types.Message message) async {
    setState(() {
      _messages.insert(0, message);
    });
    await FirebaseFirestore.instance
        .collection("textbooks")
        .doc(widget.document.id)
        .collection("chat")
        .doc()
        .set({
      "createdAt": message.createdAt,
      "id": message.id,
      "text": message,
      "user": {
        "id": message.author.id,
        "firstName": message.author.firstName,
      }
    });
    // 通知処理
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

  void _handleSendPressed(types.PartialText message) {
    final newMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomId,
      text: message.text,
    );
    _addMessage(newMessage);
  }
  
  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: randomId,
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }
  @override
  Widget build(BuildContext context ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("チャット"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Chat(
              messages: _messages,
              onSendPressed: _handleSendPressed,
              user: _user,
              onAttachmentPressed: _handleImageSelection,
            ),
          ),
        ],
      ),
    );
  }
}
