import 'dart:io';
import 'package:projectritsbook_native/data/models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<List<Book>> getBooks();
  Future uploadBook(Book book);
  Future<String> uploadBookImage(File image);
}
