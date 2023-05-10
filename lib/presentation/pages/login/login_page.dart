import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectritsbook_native/core/validation/email_validation.dart';
import 'package:projectritsbook_native/core/validation/password_validation.dart';


class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _mailAddressController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBarのタイトルを消す
        title: const Text(''),
        // AppBarの背景色を変更する
        backgroundColor: const Color(0xffff6b6b),
        // AppBarの下に影をつける
        elevation: 0,
      ),
      body: Form(
        key: _key,
        child: Container(
          color: const Color(0xffff6b6b),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    '立命館大学生専用',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    '教科書フリマアプリ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.white,
                    // width: 258,
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
                  const SizedBox(
                    height: 32,
                  ),
                  Image.asset('images/Bookimage.png'),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "メールアドレス",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        TextFormField(
                            style: const TextStyle(fontSize: 12),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'メールアドレスを入力',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                            ),
                            controller: _mailAddressController,
                            validator: (value){
                              return EmailValidator.validate(value!);
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        TextFormField(
                          style: const TextStyle(fontSize: 12),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "パスワードを作成",
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                          ),
                          controller: _passwordController,
                          validator: (value){
                            return PassWordValidator.validate(value!);
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // パスワードが見えないようにする
                          obscureText: true,
                        ),
                        const SizedBox(height: 8),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              // バリデーションチェックに問題がなければ、ログイン処理を行う
                              // await context
                              //     .read(loginUseCaseProvider)
                              //     .login(_mailAddressController.text,
                              //         _passwordController.text);
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => HomePage()));
                            }
                            //ログイン処理
                            // login();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: const Text(
                            "ログイン",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextButton(
                            onPressed: () {
                              //ログイン画面に飛ばす処理
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ResetPassword()));
                            },
                            child: const Text(
                              "パスワードをお忘れの方はこちら",
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline),
                            )),
                        TextButton(
                            onPressed: () {
                              //ログイン画面に飛ばす処理
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => SignUpPage()));
                            },
                            child: const Text(
                              "新規登録の方はこちら",
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
