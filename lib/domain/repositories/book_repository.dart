import 'dart:io';

import 'package:projectritsbook_native/domain/entities/book_model.dart';

abstract class BookRepository {
  ///教科書の一覧取得メソッド
  Future<List<Book>> getBooks();
  ///教科書の出品メソッド
  Future uploadBook(Book book);
  ///教科書の画像をアップロードするメソッド
  Future<String> uploadBookImage(File image);
}
