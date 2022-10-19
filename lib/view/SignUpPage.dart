import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:projectritsbook_native/view/LandingAfterLogin.dart';
import 'package:projectritsbook_native/view_model/Signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  String infoText = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  String isSelected_faculity = '情報理工学部情報理工学科';
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

  Future SignUP() async {
    try {
      // メールとパスワードでユーザー検索
      final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = result.user!;
      setState(() {
        infoText = "登録完了しました${user.email}";
      });
    } catch (e) {
      setState(() {
        infoText = "登録できませんでした${e.toString()}";
      });
    }
  }

  Future MailSignUp() async {
    try {
      // バリデーション後のメールアドレスとパスワードでアカウント登録
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // 確認メール送信
      await auth.currentUser?.sendEmailVerification();
      print('メール送信');
    } catch (e) {
      throw e;
    }
  }

  Future login() async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      final isVerified = await auth.currentUser?.emailVerified;
      if (!isVerified!) {
        await auth.currentUser?.sendEmailVerification();
        await auth.signOut();
        throw 'メールアドレスが確認できませんでした。メールを確認してください。';
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffff6b6b),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            // 画面サイズに合わせて変化する
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Text(
                  //   '立命館大学生専用',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 18,
                  //   ),
                  // ),
                  // Text(
                  //   '教科書フリマアプリ',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 20,
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  Container(
                    color: Colors.white,
                    width: 258,
                    height: 64,
                    child: Center(
                      child: Text(
                        'RITSBOOK',
                        style: TextStyle(
                          color: Color(0xff484848),
                          fontSize: 36,
                          letterSpacing: 10.44,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30)
                    ),
                   
                    child: Column(
                      children: [
                        Align(
                          child: Text(
                            "メールアドレス",
                            style: TextStyle(
                              fontSize: 12
                            ),
                            ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          height: 33,
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 12
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'メールアドレスを入力',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 15),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                email = value;
                              });
                            }
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          child: Text(
                            "パスワード",
                            style: TextStyle(
                              fontSize: 12
                            ),
                            ),
                          alignment: Alignment.centerLeft,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 33,
                          child: TextFormField(
                          style: TextStyle(
                            fontSize: 12
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "パスワードを作成",
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
                        Align(
                          child: Text(
                            "ユーザ名",
                            style: TextStyle(
                              fontSize: 12
                            )
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          height: 33,
                          child: TextFormField(
                          style: TextStyle(
                            fontSize: 12
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "ユーザ名を入力",
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
                        Align(
                          child: Text(
                            "学部学科",
                            style: TextStyle(
                              fontSize: 12
                            )
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          height: 33,
                          width: 270,
                          color: Colors.white,
                          child: DropdownButton<String>(
                            underline: Container(),
                            
                            items: faculity_list.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(
                                  dropDownStringItem,
                                  style: TextStyle(
                                    fontSize: 12
                                    )
                                  ),
                              );
                            }).toList(),
                            //ドロップダウンから選択されたら、isSelected_faculityが更新される
                            onChanged: (String? value) {
                              setState(() {
                                isSelected_faculity = value!;
                              });
                            },
                            value: isSelected_faculity,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          child: Text(
                            "学年",
                            style: TextStyle(
                              fontSize: 12
                            )
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          height: 33,
                          width: 270,
                          color: Colors.white,
                          child: DropdownButton<String>(
                            underline: Container(),
                            items: faculity_list.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(
                                  dropDownStringItem,
                                  style: TextStyle(
                                    fontSize: 12
                                    )
                                  ),
                              );
                            }).toList(),
                            //ドロップダウンから選択されたら、isSelected_faculityが更新される
                            onChanged: (String? value) {
                              setState(() {
                                isSelected_faculity = value!;
                              });
                            },
                            value: isSelected_faculity,
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            //ログイン処理
                            login();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
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
                    
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Align(
//                     child: Text("メールアドレス"),
//                     alignment: Alignment.centerLeft,
//                   ),
//                   TextFormField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: 'メールアドレスを入力',
//                         fillColor: Colors.white,
//                         filled: true,
//                         contentPadding:
//                             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                       ),
//                       onChanged: (String value) {
//                         setState(() {
//                           email = value;
//                         });
//                       }),
//                   const SizedBox(height: 8),
//                   Align(
//                     child: Text("パスワード"),
//                     alignment: Alignment.centerLeft,
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "パスワードを作成",
//                       fillColor: Colors.white,
//                       filled: true,
//                       contentPadding: EdgeInsets.symmetric(horizontal: 15),
//                     ),
//                     // パスワードガ見えないようにする
//                     obscureText: true,
//                     onChanged: (String value) {
//                       setState(() {
//                         password = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 8),
//                   Text(infoText),
//                   const SizedBox(height: 8),
//                   const Divider(
//                     color: Colors.white,
//                     thickness: 1,
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () async {
//                       //ログイン処理
//                       login();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(0),
//                       ),
//                     ),
//                     child: const Text(
//                       "ログインする",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   )