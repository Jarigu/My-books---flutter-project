import 'package:my_books/data/models/book_model.dart';
import 'package:my_books/domain/repositories/i_book_repository.dart';

class FavoriteBooksUseCase {
  FavoriteBooksUseCase({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;

  final IBookRepository _bookRepository;

  Future<List<BookModel>> getFavoriteBooks() async {
    try {
      return await _bookRepository.getFavoriteBooks();
    } catch (e) {
      rethrow;
    }
  }
}
