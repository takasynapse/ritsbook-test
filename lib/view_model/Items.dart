import 'package:cloud_firestore/cloud_firestore.dart';

class Item{
  // ドキュメントを扱くdocumentsnapshotを引数にしたコンストラクタ

  Item(DocumentSnapshot doc){
   item = doc['item'];
  }
  // フィールドを定義
  late String item;
}