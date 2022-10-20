import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectritsbook_native/view/EditProfilePage.dart';
import 'package:projectritsbook_native/view/SignUpPage.dart';
import 'package:projectritsbook_native/view/TradingItem.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final url = Uri.parse("https://twitter.com/ritsbook");
  final terms = Uri.parse("https://ritsbook.netlify.app/policy");
  final guide = Uri.parse("https://ritsbook.netlify.app/guide");
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
    return (Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.white,
        ),
      ),
      // build:(_)=> getUser(),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top:40,
              left: 40,
              ),
            child: Container(
              width: double.infinity,
              child: Text(
                'プロフィール',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 32,
              bottom: 10
              ),
            child: Container(
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom (
                    onPrimary: Colors.black,
                    primary: Color(0xffffcfcf),
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.authStateChanges().listen((User? user) {
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage()),
                        );
                      } else {
                        _showDialogCheckauth();
                      }
                    });
                  },
                  child: Icon(Icons.edit_outlined),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right:40.0,
              left: 36,),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffff6b6b)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 18.0,
                  bottom: 18.0,
                  left: 18.0,
                ),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
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
                      SizedBox(
                        width: 50,
                      ),
                      Flexible(
                        child: Column(
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
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 80),
                        padding: EdgeInsets.only(
                          top: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
              top: 52,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left:20,
                      top:8,
                      bottom: 8
                    ),
                    child: ListTile(
                      leading: Icon(Icons.check_box_outlined),
                      title: Text('出品した商品・購入した商品'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TradingItem()),
                        );
                      },
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left:20,
                      top:8,
                      bottom: 8
                      ),
                    child: ListTile(
                      leading: Icon(Icons.question_mark),
                      title: Text('RitsBookの使い方'),
                      onTap: () {
                        launchUrl(guide);
                      },
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left:20,
                      top:8,
                      bottom: 8
                      ),
                    child: ListTile(
                      leading: Icon(Icons.event_note_rounded),
                      title: Text('利用規約'),
                      onTap: () {
                        launchUrl(terms);
                      },
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left:20,
                      top:8,
                      bottom: 8
                      ),
                    child: ListTile(
                      leading: Icon(Icons.chat),
                      title: Text('Twitter'),
                      onTap: () async {
                        await launchUrl(url);
                      },
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left:20,
                      top:8,
                      bottom: 8
                    
                      ),
                    child: ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('ログアウト'),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
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
