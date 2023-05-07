import 'dart:io';

import 'package:projectritsbook_native/data/datasources/bookremotedatasource.dart';
import 'package:projectritsbook_native/data/models/book_model.dart';

import '../../domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource _bookRemoteDataSource;

  BookRepositoryImpl({required BookRemoteDataSource bookRemoteDataSource})
      : _bookRemoteDataSource = bookRemoteDataSource;
  @override
  Future<List<Book>> getBooks() async {
    return await _bookRemoteDataSource.getBooks();
  }

  @override
  Future uploadBook(Book book) async {
    await _bookRemoteDataSource.uploadBook(book);
  }

  @override
  Future<String> uploadBookImage(File image) async {
    return await _bookRemoteDataSource.uploadBookImage(image);
  }
}
