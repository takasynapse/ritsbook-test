import 'package:projectritsbook_native/data/datasources/bookremotedatasource.dart';
import 'package:projectritsbook_native/data/models/book_model.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks();
}

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource _bookRemoteDataSource;

  BookRepositoryImpl({required BookRemoteDataSource bookRemoteDataSource})
      : _bookRemoteDataSource = bookRemoteDataSource;
  @override
  Future<List<Book>> getBooks() async {
    return await _bookRemoteDataSource.getBooks();
  }
}
