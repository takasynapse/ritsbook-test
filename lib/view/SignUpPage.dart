import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gap/gap.dart';
import 'package:projectritsbook_native/view/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String email = "";
  String password = "";
  String infoText = "";
  String username = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  String isSelectedFaculty = '選択してください';
  final facultyList = <String>[
    '選択してください',
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
    '選択してください',
    '1年',
    '2年',
    '3年',
    '4年',
  ];
  String isSelectedGrade = '選択してください';

  Future mailSignUp(username, faculty, grade) async {
    try {
      // バリデーション後のメールアドレスとパスワードでアカウント登録
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // 確認メール送信
      await auth.currentUser?.sendEmailVerification();
      final user = auth.currentUser;
      FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'name': username,
        'faculty': faculty,
        'grade': grade,
        'email': user?.email
      }).then((value) {});
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffff6b6b),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            // 画面サイズに合わせて変化する
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Gap(10),
                  Container(
                    color: Colors.white,
                    width: 258,
                    height: 64,
                    child: const Center(
                      child: Text(
                        'RITSBOOK',
                        style: TextStyle(
                          color: Color(0xff484848),
                          fontSize: 34,
                          letterSpacing: 10.44,
                        ),
                      ),
                    ),
                  ),
                  const Gap(60),
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "メールアドレス",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          height: 33,
                          child: TextFormField(
                              style: const TextStyle(fontSize: 12),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'メールアドレスを入力',
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 15),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  email = value;
                                });
                              }),
                        ),
                        const SizedBox(height: 8),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "パスワード",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 33,
                          child: TextFormField(
                            style: const TextStyle(fontSize: 12),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "パスワードを作成",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                            ),
                            // パスワードガ見えないようにする
                            obscureText: true,
                            onChanged: (String value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(infoText),
                        const SizedBox(height: 15),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("ユーザ名", style: TextStyle(fontSize: 12)),
                        ),
                        SizedBox(
                          height: 33,
                          child: TextFormField(
                            style: const TextStyle(fontSize: 12),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "ユーザ名を入力",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                            ),
                            // パスワードガ見えないようにする
                            onChanged: (String value) {
                              setState(() {
                                username = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("学部学科", style: TextStyle(fontSize: 12)),
                        ),
                        Container(
                          height: 33,
                          width: 300,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: DropdownButton<String>(
                              underline: Container(),
                              items:
                                  facultyList.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem,
                                      style: const TextStyle(fontSize: 12)),
                                );
                              }).toList(),
                              //ドロップダウンから選択されたら、isSelected_faculityが更新される
                              onChanged: (String? value) {
                                setState(() {
                                  isSelectedFaculty = value!;
                                });
                              },
                              value: isSelectedFaculty,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("学年", style: TextStyle(fontSize: 12)),
                        ),
                        Container(
                          height: 33,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: DropdownButton<String>(
                              underline: Container(),
                              items: gradeList.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem,
                                      style: const TextStyle(fontSize: 12)),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  isSelectedGrade = value!;
                                });
                              },
                              value: isSelectedGrade,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            //新規登録処理
                            mailSignUp(
                                username, isSelectedFaculty, isSelectedGrade);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: const Text(
                            "新規登録する",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      onPressed: () {
                        //ログイン画面に飛ばす処理
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text(
                        "アカウントをお持ちの方はこちら",
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
