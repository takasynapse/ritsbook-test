import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Future 

// Future signUp()async{
//   try{
//     String newEmail = "";
//     String newPassword = "";
//     String infoText = "";
    
//     final FirebaseAuth auth = FirebaseAuth.instance;
//     final UserCredential result = await auth.createUserWithEmailAndPassword(
//       email: newEmail,
//       password: newPassword,
//     );
//     final User user = result.user!;
//     if (result!=null){
//       infoText = "登録完了しました";
//     }
//     else{
//       infoText = "登録に失敗しました";
//     } 
//   }catch(e){
//     print(e);
//   }
// }
