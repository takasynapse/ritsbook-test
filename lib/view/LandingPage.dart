import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectritsbook_native/view/Chat.dart';

import 'package:projectritsbook_native/view/Exhibitation.dart';
import 'package:projectritsbook_native/view/LandingAfterLogin.dart';
import 'package:projectritsbook_native/view/LoginPage.dart';
import 'package:projectritsbook_native/view/SignUpPage.dart';
// import 'package:projectritsbook_native/view_model/Landing_page_googleLogin.dart';
import 'package:projectritsbook_native/view_model/Signup.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String newEmail = "";
  String newPassword = "";
  String infoText = "";

  //googleログイン
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  // ↑ここまで

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('テストです'),
      ),
      body: Center(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // テキスト入力ラベル
                TextFormField(
                decoration:InputDecoration(labelText:"メールアドレス"),
                onChanged:(String value){
                  setState(() {
                    newEmail = value;
                  });
                }
                ),
                const SizedBox(height:8),
                TextFormField(
                  decoration: InputDecoration(labelText:"パスワード"),
                  // パスワードガ見えないようにする
                  obscureText:true,
                  onChanged: (String value){
                    setState((){
                      newPassword = value;
                    });
                  },
                ),
                const SizedBox(height:8),
                ElevatedButton(
                  onPressed: () async {
                    try{
                      // メールとパスワードでユーザー検索
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final UserCredential result = 
                      await auth.createUserWithEmailAndPassword(
                        email: newEmail,
                        password: newPassword,
                      );
                      final User user = result.user!;
                      setState(() {
                        infoText = "登録完了しました${user.email}";
                      });
                    }catch(e){
                      setState(() {
                        infoText = "登録できませんでした${e.toString()}";
                      });
                    }
                  },
                  child:Text("ユーザー登録"),
                ),
                const SizedBox(height:8),
                Text(infoText),
                const SizedBox(height:8),
                ElevatedButton(
                  onPressed: () async {
                    // サインイン画面を表示する
                    signInWithGoogle();
                  },
                  child:Text("Googleアカウントで登録de"),
                ),
                  ElevatedButton(
                  onPressed:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Exhibition(),
                      ));
                  },
                  child:Text("出品画面に移動"),
                ),
                  ElevatedButton(
                  onPressed:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>UserLogin(),
                      ));
                  },
                  child:Text("ログイン"),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // Navigator.push(
          //   context,
          //   // MaterialPageRoute(builder: (context) => SecondPage()),
          //   // print('object'),
          // );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}