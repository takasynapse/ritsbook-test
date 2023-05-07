import 'package:projectritsbook_native/data/models/book_model.dart';

import '../repositories/book_repository.dart';

//出品中のすべての本を取得
class GetAllBooksUseCase {
  final BookRepository _bookRepository;

  GetAllBooksUseCase(this._bookRepository);

  Future<List<Book>> execute() async {
    return await _bookRepository.getBooks();
  }
}


