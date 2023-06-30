// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class WithdrawalPage extends StatefulWidget {
//   const WithdrawalPage({super.key});

//   @override
//   WithdrawalPageState createState() => WithdrawalPageState();
// }

// class WithdrawalPageState extends State<WithdrawalPage> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   String info1 =
//       "退会した後は下記のアカウント情報が削除され復旧できなくなります。\n ・プロフィール \n ・出品/購入した商品の情報 \n ・やり取りの内容 \n 退会後も再登録可能ですが、退会したアカウントは上記のアカウント情報が削除されるため再登録したアカウントでデータを引き継ぐことはできません。";

//   Future<void> deleteUser() async {
//     await auth.currentUser?.delete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             SizedBox(
//               width: 300,
//               child: Text(info1),
//             ),
//             ElevatedButton(
//                 onPressed: () async {
//                   await deleteUser();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xffff6b6b),
//                 ),
//                 child: const Text("退会する")),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text("戻る"))
//           ],
//         ),
//       ),
//     );
//   }
// }
