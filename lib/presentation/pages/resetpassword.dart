import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String email = "";
  String infoText = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'success';
    } catch (error) {
      print("エラー");
      return error;
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    width: 30,
                    child: Image.asset('images/Bookimage.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "パスワード再設定メールを送信",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 33,
                    child: TextFormField(
                        style: const TextStyle(fontSize: 12),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'メールアドレスを入力',
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            email = value;
                          });
                        }),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String _result = await sendPasswordResetEmail(email);
                      if (_result == 'success') {
                        setState(() {
                          infoText = "メールを送信しました。\n 届いていない場合は迷惑メールフォルダをご確認ください。";
                        });
                      } else {
                        setState(() {
                          infoText = "メールアドレスが不正です。";
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: const Text(
                      "メール送信",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      infoText,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
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
