import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectritsbook_native/data/models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<List<Book>> getBooks();
  Future<Book> uploadBook(Book book);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;

  BookRemoteDataSourceImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  //本の一覧取得メソッド
  @override
  Future<List<Book>> getBooks() async {
    final docs = await _firebaseFirestore
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

  //本の出品メソッド
  @override
  Future<Book> uploadBook(Book book) async {
    final doc = await _firebaseFirestore.collection("textbooks").add({
      "item": book.title,
      "userID": book.author,
      "description": book.description,
      "img_url": book.imageUrl,
      "condition": book.condition,
      "isSold": book.isSold,
      "price": book.price,
      "timestamp": Timestamp.now(),
    });
    return doc.id as Book;
  }
}
