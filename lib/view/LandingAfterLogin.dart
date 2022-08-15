import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectritsbook_native/view_model/Items.dart';

class LandingPageAfter extends StatefulWidget {
  @override
  _LandingPageAfterState createState() => _LandingPageAfterState();
}

class _LandingPageAfterState extends State<LandingPageAfter> {
  List<DocumentSnapshot> documentList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ランディングページ'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () async {
                      final snapshot = await FirebaseFirestore.instance
                          .collection('textbooks')
                          .get();
                      setState(() {
                        documentList = snapshot.docs;
                      });
                    },
                    child: Text('一覧取得')),
                    // Column(
                    //   children: documentList.map((doc) {
                    //     return Text(doc.data()['title']);
                    //   }).toList(),
                    // )
              ]),
        ));
  }
}
