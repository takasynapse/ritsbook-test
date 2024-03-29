import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new // new
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:projectritsbook_native/presentation/pages/landing_page/landing_page.dart';

// /画像選択パッケージ
import 'package:image_picker/image_picker.dart';

// class EditItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('上記の内容で出品しますか？'),
//       actions: <Widget>[
//         GestureDetector(
//           child: const Text('はい'),
//           onTap: () {},
//         )
//       ],
//     );
//   }
// }
// ignore_for_file: avoid_print

class EditItem extends StatefulWidget {
  final DocumentSnapshot document;
  const EditItem(this.document, {super.key});
  @override
  EditItemState createState() => EditItemState();
}

class EditItemState extends State<EditItem> {
  //null許容でとりあえず教科書の状態の変数宣言
  late String? condition = widget.document["condition"];
  late String? description = widget.document["description"];
  late String imageUrl = widget.document["img_url"];
  late bool? isSold = widget.document["isSold"];
  late String? item = widget.document["item"];
  late int? price = widget.document["price"];
  // late String? seller = widget.document["seller"];
  String? timestamp;
  String? userID;

  //ライフサイクルフックにおいてcreated時にユーザがログインしているか検証
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {});
  }

  void _upload() async {
    // final ImagePicker picker = ImagePicker();
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
        imageUrl = uploadedImageURL;
      });
    } catch (e) {
      print(e);
      print("アップロード失敗");
    }
  }

  Future<void> _showDialogAfterDelete() async {
    await showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('商品を削除しました'),
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

  void _deleteItem() async {
    var deleteItem = FirebaseFirestore.instance
        .collection("textbooks")
        .doc(widget.document.id);
    deleteItem.delete().then(((value) {
      print("商品を削除しました");
      _showDialogAfterDelete();
    }));
  }

  Future<void> _showDeleteDialog() async {
    await showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('商品を削除しますか'),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('削除'),
              onPressed: () {
                _deleteItem();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
            // backgroundColor: Colors.white,
            ),
      ),
      body: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text("商品名"),
            TextField(
              decoration: const InputDecoration(hintText: '商品名'),
              controller: TextEditingController(text: item),
              onChanged: (String? value) {
                setState(() {
                  item = value;
                });
              },
            ),
            const Text("画像を選択"),
            Image(image: NetworkImage(imageUrl)),
            ElevatedButton(onPressed: _upload, child: const Text('画像を選択')),
            TextField(
              decoration: const InputDecoration(hintText: '商品の説明'),
              controller: TextEditingController(text: description),
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
            const Text("値段"),
            TextField(
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: price.toString()),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(hintText: ''),
              onChanged: (value) {
                price = int.parse(value);
              },
            ),
            ElevatedButton(
                onPressed: () {
                  var exhibit = FirebaseFirestore.instance
                      .collection("textbooks")
                      .doc(widget.document.id);
                  exhibit.update({
                    "condition": condition,
                    "item": item,
                    "description": description,
                    "price": price,
                    "userID": userID,
                    "img_url": imageUrl,
                    "isSold": true
                  });
                },
                child: const Text('出品する')),
            ElevatedButton(
                onPressed: () {
                  _showDeleteDialog();
                },
                child: const Text('商品を削除する'))
          ]),
    );
  }
}
