import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class ChatPage extends StatelessWidget {
  final String documentId;
  ChatPage(this.documentId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット'),
        // backgroundColor: const Color(0xffff6b6b),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('textbooks')
            .doc(documentId)
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView(
              children: documents.map((document) {
                return Card(
                  child: ListTile(
                    title: Text(document['text']),
                    subtitle: Text(document['createdAt'].toString()),
                  ),
                );
              }).toList(),
            );
          }
          return const Text('読み込み中...');
        },
      ),
    );
  }
}
