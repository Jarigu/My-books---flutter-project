import 'package:my_books/data/models/book_model.dart';
import 'package:my_books/domain/repositories/i_book_repository.dart';

class FavoriteBookUseCase {
  FavoriteBookUseCase({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;

  final IBookRepository _bookRepository;

  Future<void> addFavoriteBook(BookModel book) async {
    try {
      List<BookModel> favoriteBooks = await _bookRepository.getFavoriteBooks();
      bool bookExists = false;

      for (int i = 0; i < favoriteBooks.length; i++) {
        if (favoriteBooks[i].key == book.key) {
          bookExists = true;
          break;
        }
      }
      if (!bookExists) {
        await _bookRepository.addFavoriteBook(book);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeFavoriteBook(BookModel book) async {
    try {
      List<BookModel> favoriteBooks = await _bookRepository.getFavoriteBooks();
      int i = 0;
      for (i; i < favoriteBooks.length; i++) {
        if (favoriteBooks[i].key == book.key) {
          break;
        }
      }
      if (i < favoriteBooks.length) {
        await _bookRepository.deleteFavoriteBook(i);
      }
    } catch (e) {
      rethrow;
    }
  }
}
