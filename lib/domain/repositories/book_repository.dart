import 'package:projectritsbook_native/data/models/book_model.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks();
}