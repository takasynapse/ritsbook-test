import 'dart:io';
import 'package:flutter/services.dart';
// import 'main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gap/gap.dart';

import 'package:projectritsbook_native/view/SignUpPage.dart';

import 'package:path/path.dart';

// /画像選択パッケージ
import 'package:image_picker/image_picker.dart';

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

  Future<void> _showDialog() async {
    await showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('出品しますか'),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('出品'),
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

  Future<void> _showDialogafterupload() async {
    await showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('出品が完了しました。\n出品した商品はマイページから確認できます。'),
          actions: [
            TextButton(
              child: const Text('閉じる'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDialogCheckauth() async {
    await showDialog(
      context: this.context,
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
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
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
      "img_url": _imageurl,
      "timestamp": FieldValue.serverTimestamp(),
      "isSold": true
    }).then((value) => _showDialogafterupload());
  }

// ignore: prefer_const_literals_to_create_immutables
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(20),
                  const Text("商品情報を入力してください",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  Image(image: NetworkImage(_imageurl)),
                  ElevatedButton(
                      onPressed: _uploadImage, child: const Text('画像を選択')),
                  const Text("商品名(必須)",
                      style: TextStyle(
                        color: Color(0xff8f8f8f),
                      )),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      maxLines: 1,
                      decoration: const InputDecoration(
                          hintText: '商品名',
                          // contentPadding: EdgeInsets.all(20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          )),
                      onChanged: (String text) {
                        setState(() {
                          item = text;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      maxLines: 8,
                      decoration: const InputDecoration(
                        hintText: ' 商品の説明\n・教科書の破損状態\n・使用した授業\n  など',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      onChanged: (String text) {
                        setState(() {
                          description = text;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("商品の状態"),
                  SizedBox(
                    width: 300,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: "商品の状態",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: '新品・未使用',
                          child: Text('新品・未使用'),
                        ),
                        DropdownMenuItem(
                          value: '未使用に近い',
                          child: Text('未使用に近い'),
                        ),
                        DropdownMenuItem(
                          value: '目立った傷や汚れなし',
                          child: Text('目立った傷や汚れなし'),
                        ),
                        DropdownMenuItem(
                          value: '傷や汚れあり',
                          child: Text('傷や汚れあり'),
                        ),
                        DropdownMenuItem(
                          value: '全体的に状態が悪い',
                          child: Text('全体的に状態が悪い'),
                        ),
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          condition = value;
                        });
                      },
                      value: condition,
                    ),
                  ),
                  const Text("値段"),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                          labelText: '値段',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onChanged: (value) {
                        price = int.parse(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xfff13838),
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                              width: 2.0, color: Color(0xfff13838)),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance
                              .authStateChanges()
                              .listen((user) {
                            if (user != null) {
                              _showDialog();
                            } else {
                              _showDialogCheckauth();
                            }
                          });
                        },
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: const Text("出品する"),
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
