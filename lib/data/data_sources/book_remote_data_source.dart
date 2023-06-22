import 'dart:io';
import 'package:projectritsbook_native/domain/entities/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

abstract class BookRemoteDataSource {
  Future<List<Book>> getBooks();
  Future uploadBook(Book book);
  Future<String> uploadBookImage(File image);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final FirebaseFirestore _firebaseFireStore;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  BookRemoteDataSourceImpl({required FirebaseFirestore firebaseFireStore})
      : _firebaseFireStore = firebaseFireStore;

  ///本の一覧取得メソッド
  @override
  Future<List<Book>> getBooks() async {
    final docs = await _firebaseFireStore
        .collection("textbooks")
        .orderBy("timestamp", descending: true)
        .get();
    final documentList = docs.docs.map((doc) {
      final data = doc.data();
      return Book(
        title: data["item"],
        author: data["userID"],
        description: data["description"],
        imageUrl: data["img_url"],
        condition: data["condition"],
        isSold: data["isSold"],
        documentID: doc.id,
        price: data["price"],
      );
    }).toList();
    return documentList;
  }

  ///本の出品メソッド
  @override
  Future uploadBook(Book book) async {
    await _firebaseFireStore.collection("textbooks").add({
      "item": book.title,
      "userID": book.author,
      "description": book.description,
      "img_url": book.imageUrl,
      "condition": book.condition,
      "isSold": book.isSold,
      "price": book.price,
      "timestamp": Timestamp.now(),
    });
  }

  ///本の画像をアップロードするメソッド
  @override
  Future<String> uploadBookImage(File image) async {
    final fileName = basename(image.path);
    final ref = _firebaseStorage.ref("images/$fileName");
    await ref.putFile(image);
    final downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }
}
