import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectritsbook_native/view/EditProfilePage.dart';

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
          username = ds["name"];
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
            username = ds["name"];
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
        // build:(_)=> getUser(),
        appBar: AppBar(
          title: const Text('プロフィール'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      // username = username;
                      // qualifity = qualifity;
                      // grade = grade;
                      return ListTile(
                        title: Text(username),
                        subtitle: Text(grade),
                        trailing: Text(qualifity),
                      );
                    }),
              ),
              ElevatedButton(
                child: Text('編集'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
              ),
              ElevatedButton(
                child:Text('サインアウト'),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
              )

              // Padding(
              //   padding:const EdgeInsets.all(10.0),
              //   child:ListView(
              //     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: <Widget>[
              //       Text('${username}さんのマイページ'),
              //       Text('学部学科'),
              //       Text('${qualifity}'),
              //       Text('学年'),
              //       Text('${grade}'),
              //       TextButton.icon(
              //         onPressed: (){
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(builder: (context) => EditProfilePage()),
              //           );
              //         },
              //         icon:Icon(Icons.edit),
              //         label:const Text('プロフィール編集'),
              //       ),
              //       TextButton.icon(
              //         onPressed: (){
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => SellingList(),
              //             ));
              //         },
              //         icon:const Icon(Icons.camera_alt_outlined),
              //         label:const Text('出品した商品'),
              //       ),
              //       TextButton.icon(
              //         onPressed: (){
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => PurchasedList(),
              //             ));
              //         },
              //         icon:Icon(Icons.shopping_bag),
              //         label:Text('購入した商品'),
              //       ),
              //       TextButton.icon(
              //         onPressed: (){
              //           print('aa');
              //         },
              //         icon:Icon(Icons.favorite),
              //         label:Text('いいね（未実装）'),
              //       ),
              //       // ElevatedButton(onPressed:(){
              //       //   getUser();
              //       // } , child: Text('aa'))
              //       ],
              //   )
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
