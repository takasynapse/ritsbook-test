// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // StateProviderを使い受け渡すデータを定義
// final constProvider = StateProvider((ref){
//   return 0;
// });

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   Widget build(BuildContext context , ScopedReader watch){
//     // 値が更新されたら自動的に反映
//     final count = watch(constProvider);

//     return Scaffold(
//       body:Center(
//         child: Text("count is $count"),
//         ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           // Providerを使って値を更新
//           constProvider.read(context).state++;
//         },
//         child: Icon(Icons.add),
//       ),
//       );
//   }
// }