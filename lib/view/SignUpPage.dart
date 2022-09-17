import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectritsbook_native/view/LandingAfterLogin.dart';
import 'package:projectritsbook_native/view_model/Signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  String newEmail = "";
  String newPassword = "";
  String infoText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新規登録画面'),
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
                    try{
                    print("Googleログイン"); 
                    await SignUp(context);
                    }catch(e){
                      print(e);
                    }
                  },
                  child:Text("Googleアカウントで登録"),
                ),
                ElevatedButton(
                  onPressed:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LandingPageAfter(),
                      ));
                  },
                  child:Text("ランディングページに移動"),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}