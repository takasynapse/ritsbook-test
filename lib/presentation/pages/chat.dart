import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';

class ChatPage extends StatefulWidget {
  final DocumentSnapshot document;
  const ChatPage(this.document, {super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String message = '';
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  final controller = TextEditingController();

  Future loadData() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("チャット"),
      ),
      // body: Consumer(builder: (context, model, child) {
      //   return Column(
      //     children: <Widget>[
      //       Expanded(
      //           child: RefreshIndicator(
      //         onRefresh: () async {
      //           await _loadData();
      //         },
      //         child: StreamBuilder<QuerySnapshot>(
      //             stream: FirebaseFirestore.instance
      //                 .collection("textbooks")
      //                 .doc(widget.document.id)
      //                 .collection("chat")
      //                 // .orderBy("createdAt", descending: true)
      //                 .snapshots(),
      //             builder: (context, snapshot) {
      //               if (!snapshot.hasData) {
      //                 return const Center(
      //                   child: CircularProgressIndicator(),
      //                 );
      //               }
      //               final List<DocumentSnapshot> documents =
      //                   snapshot.data!.docs;
      //               // print(documents);
      //               // print(widget.document.id);
      //               return ListView(
      //                 reverse: true,
      //                 children: documents
      //                     .map((document) => ListTile(
      //                           title: Text(document['message']),
      //                           subtitle: Text(document['userName'] ?? "匿名さん"),
      //                           // subtitle: Text(document['createdAt']
      //                           // .toDate()
      //                           // .toString()),
      //                         ))
      //                     .toList(),
      //               );
      //             }),
      //       )),
      //       TextField(
      //         autofocus: true,
      //         controller: _controller,
      //         onChanged: (value) => message = value,
      //         decoration: InputDecoration(
      //           suffixIcon: IconButton(
      //             icon: const Icon(Icons.send),
      //             onPressed: () {
      //               _addMessage(message);
      //               _controller.clear();
      //             },
      //           ),
      //           hintText: 'メッセージを入力してください',
      //         ),
      //       ),
      //     ],
      //   );
      // }),
    );
  }

// ignore_for_file: avoid_print
  void addMessage(String message) async {
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
    });

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
