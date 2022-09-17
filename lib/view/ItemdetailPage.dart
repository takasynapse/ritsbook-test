import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'package:projectritsbook_native/view/Chat.dart';
import 'package:projectritsbook_native/view/SignUpPage.dart';
import 'package:projectritsbook_native/view/Trade.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectritsbook_native/view_model/FetchBook.dart';
import "package:projectritsbook_native/view_model/Items.dart";
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:projectritsbook_native/view/EditItem.dart';

class ItemdetailPage extends StatefulWidget {
  final DocumentSnapshot document;
  ItemdetailPage(this.document);
  @override
  _ItemdetailPageState createState() => _ItemdetailPageState();
}

Future<void> Purchase(itemID) async {
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('purchase')
          .doc()
          .set({
        'itemID': itemID,
      });
      FirebaseFirestore.instance.collection('textbooks').doc(itemID).update({
        'isSold': false,
      });
    }
  });
}

class _ItemdetailPageState extends State<ItemdetailPage> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  Future<void> _showDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('購入しますか？'),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('購入'),
              onPressed: () {
                Purchase(widget.document.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TradeChatPage(widget.document),
                )
                );
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _showDialogCheckauth() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ログインしてください'),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('ログインする'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品詳細"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Image.network(widget.document["imageurl"]),
            Text(widget.document["item"]),
            Text(widget.document["price"].toString()),
            Text(widget.document["description"]),
            Text(widget.document["condition"]),
            if (uid == widget.document['userID'])
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditItem(widget.document)),
                  );
                },
                child: const Text("編集する"),
              )
            else
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.authStateChanges().listen((user) {
                    if (user != null) {
                      if (widget.document["isSold"] == true) {
                        _showDialog();
                      } else {
                        null;
                      }
                    } else {
                      _showDialogCheckauth();
                    }
                  });
                },
                child: Text("購入する"),
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatPage(widget.document)),
                );
              },
              child: const Text("チャットを見る"),
            ),
          ],
        ),
      ),
    );
  }
}
