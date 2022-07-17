import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectritsbook_native/view_model/Landing_page_googleLogin.dart';



class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Landing Page'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image:DecorationImage(
            image: AssetImage('images/landing-background.png'),
            fit : BoxFit.cover,
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('必要なものを必要な人へ'),
              Text('あなたの要るらないが\n誰かの役に立つ'),
              Text('RitsBook派立命館大学生のための\n教科書フリマアプリです'),
              ElevatedButton(
                onPressed:() async {
                  try{
                   await signInWithGoogle(); 
                  }
                  catch(e){
                    print(e);
                  }
                },
              child:Text('Googleでログイン')),
            ],
          ),
        ),
      ),
      );
  }
}