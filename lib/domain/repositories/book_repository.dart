import 'package:projectritsbook_native/data/models/book_model.dart';

abstract class BookRepository {
  //教科書の一覧取得メソッド
  Future<List<Book>> getBooks();
  //教科書の出品メソッド
  Future<Book> uploadBook(Book book);
}
