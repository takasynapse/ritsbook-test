import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> SignUp(BuildContext context) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    try {
      UserCredential result = await auth.signInWithCredential(authCredential);
      User user = result.user!;
      if (result != null) {
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Secondpage()));
        print('aaa');
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }
}
