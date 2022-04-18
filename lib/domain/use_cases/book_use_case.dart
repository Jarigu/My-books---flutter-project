import 'package:my_books/core/enums/filter_book.dart';
import 'package:my_books/data/models/book_model.dart';
import 'package:my_books/domain/repositories/i_book_repository.dart';

class BookUseCase {
  BookUseCase({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;

  final IBookRepository _bookRepository;

  Future<List<BookModel>> searchBooks({
    required FilterBook filterBook,
    required String searchValue,
    required int page,
  }) async {
    try {
      return await _bookRepository.searchBooks(
          filterBook: filterBook, searchValue: searchValue, page: page);
    } catch (e) {
      rethrow;
    }
  }
}
