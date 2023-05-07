import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectritsbook_native/data/models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<List<Book>> getBooks();
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;

  BookRemoteDataSourceImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
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
      );
    }).toList();
    return documentList;
  }
}
