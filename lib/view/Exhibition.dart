import 'dart:io';
import 'package:flutter/services.dart';
// import 'main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectritsbook_native/view/SignUpPage.dart';
import 'package:provider/provider.dart'; // new
// import 'exhibition.dart';
// import 'firebase_options.dart'; // new
// import 'src/authentication.dart'; // new
// import 'src/widgets.dart';
import 'package:path/path.dart';

// /画像選択パッケージ
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('上記の内容で出品しますか？'),
      actions: <Widget>[
        GestureDetector(
          child: Text('はい'),
          onTap: () {},
        )
      ],
    );
  }
}

class Exhibition extends StatefulWidget {
  @override
  _Exhibition createState() => _Exhibition();
}

class _Exhibition extends State<Exhibition> {
  //null許容でとりあえず教科書の状態の変数宣言
  String? condition;
  String? description;
  String _imageurl =
      "https://firebasestorage.googleapis.com/v0/b/ritsbook-997bf.appspot.com/o/images%2Fcamera.png?alt=media&token=de6c74f8-f799-448d-8625-f8a34258b531";
  bool? isSold;
  String? item;
  int? price;
  String? seller;
  String? timestamp;
  String? userID;

  //ライフサイクルフックにおいてcreated時にユーザがログインしているか検証
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        print('userinfo:');
        print(user);
        // final Object userinfo = user;
        userID = user.uid;
      }
    });
  }

  void _uploadImage() async {
    final ImagePicker _picker = ImagePicker();
    // imagePickerで画像を選択
    final pickerFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    File file = File(pickerFile!.path);
    //ファイル名取得
    String filename = basename(file.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref('images/$filename').putFile(file);
      print("アップロード成功");
      String uploadedImageURL =
          await storage.ref().child('images/$filename').getDownloadURL();
      setState(() {
        _imageurl = uploadedImageURL;
      });
      print(_imageurl);
    } catch (e) {
      print(e);
      print("アップロード失敗");
    }
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
   Future<void>_showDialog()async {
    await showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('出品しますか'),
          actions: <Widget>[
            TextButton(
              child: Text('キャンセル'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('出品'),
              onPressed: () {
                uploadBook();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  Future<void>_showDialogafterupload() async {
    await showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('出品が完了しました。\n出品した商品はマイページから確認できます。'),
          actions: [
            TextButton(
              child: Text('閉じる'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> uploadBook() async {
    CollectionReference exhibit =
        FirebaseFirestore.instance.collection("textbooks");
    exhibit.add({
      "condition": condition,
      "item": item,
      "description": description,
      "price": price,
      "userID": userID,
      "imageurl": _imageurl,
      "isSold": true
    }).then((value) => _showDialogafterupload());
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('出品画面やで'),
      ),
      body: Container(
        child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text("商品名"),
              TextField(
                decoration: InputDecoration(hintText: '商品名'),
                onChanged: (String text) {
                  setState(() {
                    item = text;
                  });
                },
              ),
              Text("画像を選択"),
              Image(image: NetworkImage(_imageurl)),
              ElevatedButton(onPressed: _uploadImage, child: Text('画像を選択')),
              TextField(
                decoration: InputDecoration(hintText: '商品の説明'),
                onChanged: (String text) {
                  setState(() {
                    description = text;
                  });
                },
              ),
              const Text("商品の状態"),
              DropdownButton(
                items: const [
                  DropdownMenuItem(
                    child:Text('新品・未使用'),
                    value: '新品・未使用',
                  ),
                  DropdownMenuItem(
                    child: Text('未使用に近い'),
                    value: '未使用に近い',
                  ),
                  DropdownMenuItem(
                    child: Text('目立った傷や汚れなし'),
                    value: '目立った傷や汚れなし',
                  ),
                  DropdownMenuItem(
                    child: Text('傷や汚れあり'),
                    value: '傷や汚れあり',
                  ),
                  DropdownMenuItem(
                    child: Text('全体的に状態が悪い'),
                    value: '全体的に状態が悪い',
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    condition = value;
                  });
                },
                value: condition,
              ),
              Text('$condition'),
              Text("値段"),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(hintText: ''),
                onChanged: (value) {
                  price = int.parse(value);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.authStateChanges().listen((User? user) {
                    if (user!=null){
                      _showDialog();
                    }else{
                      _showDialogCheckauth();
                      }
                  });
              }, child: Text('出品する'))
            ]),
      ),
    );
  }
}
