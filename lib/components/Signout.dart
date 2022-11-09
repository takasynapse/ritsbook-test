import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';


Future<void>Signout(BuildContext context) async {
  await GoogleSignIn().disconnect();
  FirebaseAuth.instance.signOut();

  final snackBar = SnackBar(
    content:const Text('ログアウトしました'),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}