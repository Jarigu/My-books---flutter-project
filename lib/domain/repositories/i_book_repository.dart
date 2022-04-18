import 'package:my_books/core/enums/filter_book.dart';
import 'package:my_books/data/models/book_detail_model.dart';
import 'package:my_books/data/models/book_model.dart';

abstract class IBookRepository {
  Future<List<BookModel>> searchBooks({
    required FilterBook filterBook,
    required String searchValue,
    required int page,
  });

  Future<BookDetailModel> detailBook({required String id});

  Future<void> addFavoriteBook(BookModel book);

  Future<void> deleteFavoriteBook(int index);

  Future<List<BookModel>> getFavoriteBooks();
}
