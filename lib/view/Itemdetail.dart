// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:projectritsbook_native/view_model/Items.dart';

// class ItemdetailPage extends StatefulWidget{
//   @override
//   _ItemdetailPageState createState() => _ItemdetailPageState();
// }

// class _ItemdetailPageState extends State<ItemdetailPage>{
//   Item item;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('商品詳細'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(item.title),
//             Text(item.price.toString()),
//             Text(item.description),
//             Text(item.imageUrl),
//           ],
//         ),
//       ),
//     );
//   }
// }