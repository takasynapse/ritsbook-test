import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectritsbook_native/view/EditProfilePage.dart';
import 'package:projectritsbook_native/view/TradingItem.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

String username = '未設定';
String qualifity = '未設定';
String grade = '未設定';

getUser() async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      try {
        final users =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        users.get().then((DocumentSnapshot ds) {
          username = user.displayName!;
          qualifity = ds["faculity"];
          grade = ds["grade"];
        });
      } catch (e) {
        print(e);
      }
    }
  });
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        try {
          final users =
              FirebaseFirestore.instance.collection('users').doc(user.uid);
          users.get().then((DocumentSnapshot ds) {
            username = user.displayName!;
            qualifity = ds["faculity"];
            grade = ds["grade"];
          });
        } catch (e) {
          print(e);
        }
      }
    });
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.white,
          ),
        ),
        // build:(_)=> getUser(),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                margin: EdgeInsets.only(top: 50),
                // height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffff6b6b)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left:16.0,
                    top: 16.0,),
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('ユーザー名',
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('学部',
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('学年',
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(username),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(qualifity),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(grade),
                                ],
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffffcfcf),
                                  onPrimary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfilePage()),
                                  );
                                },
                                child: Text('編集')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              child: Text('サインアウト'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
            Container(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: Icon(Icons.check_box_outlined),
                    title: Text('出品した商品・購入した商品'),
                    onTap: () {
                      Navigator.push (
                        context,
                        MaterialPageRoute(builder: (context) => TradingItem()),
                      );
                    },
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.question_mark),
                    title: Text('RitsBookの使い方'),
                    onTap: () {},
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.event_note_rounded),
                    title: Text('利用規約'),
                    onTap: () {},
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.chat),
                    title: Text('Twitter'),
                    onTap: () {},
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('ログアウト'),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 後でこれで書き直す
// listview.separated
Widget _menuItem(String title, Icon icon, Function onTap()) {
  return ListTile(
    leading: icon,
    title: Text(title),
  );
}
