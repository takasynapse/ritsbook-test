import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void>signInWithGoogle()async{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn =GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount =await googleSignIn.signIn();
  if (googleSignInAccount!=null){
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
          final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
    UserCredential result = await auth.signInWithCredential(authCredential);
    User user = result.user!;
    if (result!=null){
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Secondpage()));
      print('aaa');
    }
  }
}

  