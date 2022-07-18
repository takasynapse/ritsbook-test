import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectritsbook_native/components/Header.dart';
import 'package:projectritsbook_native/view_model/Landing_page_googleLogin.dart';
import 'package:projectritsbook_native/components/Header.dart';


class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: Header(),
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
              Text(
                '必要なものを必要な人へ',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
              Text('あなたの要らないが',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),), 
              Text(
                '誰かの役に立つ',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
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