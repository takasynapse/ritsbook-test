import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

Future<void>Edit_profile(name,faculity,grade)async{
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user != null) {
      FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': name,
        'faculity': faculity,
        'grade': grade,
      });
    }
  });

}

class _EditProfilePageState extends State<EditProfilePage> {
  String username = 'aa';
  String isSelected_faculity ='情報理工学部情報理工学科';
  final faculity_list = <String>[
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
  final grade_list = <String>[
    '1年',
    '2年',
    '3年',
    '4年',
  ];
  String isSelected_grade = '1年';

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール編集'),
      ),
      body: Center(
        child:ListView(
          children: <Widget>[
            Text('ユーザ名'),
            TextField(
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
            ),
            Text('学部学科（選択してください）'),
            Container(
              height: 50.0,
              child: DropdownButton<String>(
                items: faculity_list.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String? value) {
                    setState(() {
                      isSelected_faculity = value!;
                    });
                  },
                  value: isSelected_faculity,
              ),
            ),
            Text('学年(選択してください)'),
            Container(
              height: 50.0,
              child: DropdownButton<String>(
                items: grade_list.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String? value) {
                    setState(() {
                      isSelected_grade = value!;
                    });
                  },
                  value: isSelected_grade,
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Edit_profile(username,isSelected_faculity,isSelected_grade);
              },
              child: Text('編集を完了する'),
            )
          ],
        )
      )
      );
  }
}
