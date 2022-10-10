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
  Future SignUP ()async{
                          try {
                        // メールとパスワードでユーザー検索
                        final UserCredential result =
                            await auth.createUserWithEmailAndPassword(
                          email:  email,
                          password:  password,
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
  Future MailSignUp()async{
    try{
      // バリデーション後のメールアドレスとパスワードでアカウント登録
      await auth.createUserWithEmailAndPassword(email:  email, password:  password);
      // 確認メール送信
      await auth.currentUser?.sendEmailVerification();
      print('メール送信');
    }catch(e){
      throw e;
    }
  }
  Future login()async {
    try{
      await auth.signInWithEmailAndPassword(
        email:  email,
        password:  password
        );

      final isVerified = await auth.currentUser?.emailVerified;
      if(!isVerified!){
        await auth.currentUser?.sendEmailVerification();
        await auth.signOut();
        throw 'メールアドレスが確認できませんでした。メールを確認してください。';        
      }
    }
    catch(e){
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
                  Text(
                    '立命館大学生専用',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '教科書フリマアプリ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
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
                  SizedBox(height: 32),
                  Image.asset('images/Bookimage.png'),
                  Text(
                    '新規登録',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'メールアドレス',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onChanged: (String value) {
                        setState(() {
                           email = value;
                        });
                      }),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "パスワード",
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    // パスワードガ見えないようにする
                    obscureText: true,
                    onChanged: (String value) {
                      setState(() {
                         password = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      MailSignUp();},
                    child: Text("ユーザー登録"),
                  ),
                  const SizedBox(height: 8),
                  Text(infoText),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    icon: ImageIcon(AssetImage('images/googleicon.png')),
                    // icon:  Icon(Icons.login),
                    onPressed: () async {
                      try {
                        print("Googleログイン");
                        await SignUp(context);
                      } catch (e) {
                        print(e);
                      }
                    },
                    label: Text("Googleアカウントで登録",
                        style: TextStyle(
                          color: Color(0xff727272),
                        )),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
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
