import 'package:projectritsbook_native/data/models/book_model.dart';
import 'package:projectritsbook_native/data/repository/userrepository.dart';

class GetAllBooksUseCase {
  final BookRepository _bookRepository;

  GetAllBooksUseCase(this._bookRepository);

  Future<List<Book>> execute() async {
    return await _bookRepository.getBooks();
  }
}