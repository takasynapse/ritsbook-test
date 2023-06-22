// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class LandingPage extends StatefulWidget {
//   @override
//   _LandingPageState createState() => _LandingPageState();
// }

// class _LandingPageState extends State<LandingPage> {
//   String newEmail = "";
//   String newPassword = "";
//   String infoText = "";

//   //googleログイン
//   Future<UserCredential> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication? googleAuth =
//         await googleUser?.authentication;

//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );

//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
//   // ↑ここまで

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(0),
//         child: AppBar(
//           backgroundColor: Colors.white,
//         ),
//       ),
//       body: Center(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(32),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 // テキスト入力ラベル
//                 TextFormField(
//                     decoration: const InputDecoration(labelText: "メールアドレス"),
//                     onChanged: (String value) {
//                       setState(() {
//                         newEmail = value;
//                       });
//                     }),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: "パスワード"),
//                   // パスワードガ見えないようにする
//                   obscureText: true,
//                   onChanged: (String value) {
//                     setState(() {
//                       newPassword = value;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       // メールとパスワードでユーザー検索
//                       final FirebaseAuth auth = FirebaseAuth.instance;
//                       final UserCredential result =
//                           await auth.signInWithEmailAndPassword(
//                         email: newEmail,
//                         password: newPassword,
//                       );
//                       final User user = result.user!;
//                       setState(() {
//                         infoText = "登録完了しました${user.email}";
//                       });
//                     } catch (e) {
//                       setState(() {
//                         infoText = "登録できませんでした${e.toString()}";
//                       });
//                     }
//                   },
//                   child: const Text("sign in"),
//                 ),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       // メールとパスワードでユーザー検索
//                       final FirebaseAuth auth = FirebaseAuth.instance;
//                       final UserCredential result =
//                           await auth.createUserWithEmailAndPassword(
//                         email: newEmail,
//                         password: newPassword,
//                       );
//                       final User user = result.user!;
//                       setState(() {
//                         infoText = "登録完了しました${user.email}";
//                       });
//                     } catch (e) {
//                       setState(() {
//                         infoText = "登録できませんでした${e.toString()}";
//                       });
//                     }
//                   },
//                   child: const Text("ユーザー登録"),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(infoText),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () async {
//                     // サインイン画面を表示する
//                     try {
//                       signInWithGoogle();
//                     } catch (e) {
//                       setState(() {
//                         infoText = "登録できませんでした${e.toString()}";
//                       });
//                     }
//                   },
//                   child: const Text("Googleアカウントで登録"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
