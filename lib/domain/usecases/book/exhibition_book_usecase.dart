//本を出品時のユースケース
import 'dart:io';

import 'package:projectritsbook_native/domain/repositories/book_repository.dart';

import '../../entities/book_model.dart';
///本のCLUDを行うユースケース
class ExhibitionBookUseCase {
  final BookRepository _bookRepository;

  ExhibitionBookUseCase(this._bookRepository);

  Future uploadBookImage(File image) async {
    await _bookRepository.uploadBookImage(image);
  }

  Future uploadBook(Book book) async {
    await _bookRepository.uploadBook(book);
  }
}
