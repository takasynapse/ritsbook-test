import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  Future<void> _showDialogAfterEditingProfile() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('プロフィール編集が完了しました。\n しばらくすると更新されます。'),
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

  Future<void> editProfile(name, faculty, grade) async {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'faculty': faculty,
          'grade': grade,
          'email': user.email
        }).then((value) {
          _showDialogAfterEditingProfile();
        });
      }
    });
    FirebaseAuth.instance.currentUser?.updateDisplayName(name);
  }

  String? username = FirebaseAuth.instance.currentUser?.displayName;
  String isSelectedFaculty = '情報理工学部情報理工学科';
  final facultyList = <String>[
    '情報理工学部情報理工学科',
    '経済学部経済学科国際専攻',
    '経済学部経済学科経済専攻',
    'スポーツ健康科学部スポーツ健康科学科',
    '食マネジメント学部食マネジメント学科',
    '理工学部電子情報工学科',
    '理工学部数理学科',
    '理工学部物理科学科',
    '理工学部電気電子工学科',
    '理工学部機械工学科',
    '理工学部ロボティクス学科',
    '理工学部環境都市工学科',
    '理工学部建築都市デザイン学科',
    '生命科学部応用化学科',
    '生命科学部生物工学科',
    '生命科学部生命情報学科',
    '生命科学部生命医科学科',
    '薬学部薬学科',
    '薬学部創薬科学科',
  ];
  final gradeList = <String>[
    '1年',
    '2年',
    '3年',
    '4年',
  ];
  String isSelectedGrade = '1年';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(
      children: <Widget>[
        const Text('ユーザ名'),
        TextField(
          onChanged: (value) {
            setState(() {
              username = value;
              // print(username);
            });
          },
        ),
        const Text('学部学科（選択してください）'),
        SizedBox(
          height: 50.0,
          child: DropdownButton<String>(
            items: facultyList.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                isSelectedFaculty = value!;
              });
            },
            value: isSelectedFaculty,
          ),
        ),
        const Text('学年(選択してください)'),
        SizedBox(
          height: 50.0,
          child: DropdownButton<String>(
            items: gradeList.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                isSelectedGrade = value!;
                // print(isSelectedGrade);
              });
            },
            value: isSelectedGrade,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            editProfile(username, isSelectedFaculty, isSelectedGrade);
          },
          child: const Text('編集を完了する'),
        )
      ],
    )));
  }
}
