//本を出品時のユースケース
import 'package:projectritsbook_native/domain/repositories/book_repository.dart';

import '../../data/models/book_model.dart';

class ExhibitionBookUseCase {
  final BookRepository _bookRepository;

  ExhibitionBookUseCase(this._bookRepository);

  Future uploadBook(Book book) async {
    await _bookRepository.uploadBook(book);
  }
}
