//本を出品時のユースケース
import 'package:projectritsbook_native/domain/repositories/book_repository.dart';

import '../../data/models/book_model.dart';

class ExhibitionBookUseCase {
  final BookRepository _bookRepository;

  ExhibitionBookUseCase(this._bookRepository);

  Future<Book> uploadBook(Book book) async {
    return await _bookRepository.uploadBook(book);
  }
}
