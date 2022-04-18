import 'package:my_books/core/enums/filter_book.dart';
import 'package:my_books/data/models/book_detail_model.dart';
import 'package:my_books/data/models/book_model.dart';
import 'package:my_books/domain/datasources/i_book_data_source.dart';
import 'package:my_books/domain/datasources/i_hive_data_source.dart';
import 'package:my_books/domain/repositories/i_book_repository.dart';

class BookRepository implements IBookRepository {
  BookRepository({
    required IBookDataSource bookDataSource,
    required IHiveDataSource<BookModel> favoriteBooksDataSource,
  })  : _bookDataSource = bookDataSource,
        _favoriteBooksDataSource = favoriteBooksDataSource;

  final IBookDataSource _bookDataSource;
  final IHiveDataSource<BookModel> _favoriteBooksDataSource;

  final idBookLocal = 'books';

  @override
  Future<List<BookModel>> searchBooks({
    required FilterBook filterBook,
    required String searchValue,
    required int page,
  }) async {
    try {
      final List<BookModel> books = await _bookDataSource.searchBooks(
          filterBook: filterBook, searchValue: searchValue, page: page);

      final List<BookModel> favoriteBooks =
          await _favoriteBooksDataSource.getList(idBookLocal);

      if (favoriteBooks.isNotEmpty) {
        List<BookModel> endBooks = [];
        for (var book in books) {
          bool isFavorite = false;
          for (var favoriteBook in favoriteBooks) {
            if (book.key == favoriteBook.key) {
              isFavorite = true;

              break;
            }
          }
          endBooks.add(
            BookModel(
              key: book.key,
              title: book.title,
              language: book.language,
              authorKey: book.authorKey,
              authorName: book.authorName,
              isbn: book.isbn,
              firstPublishYear: book.firstPublishYear,
              isFavorite: isFavorite,
            ),
          );
        }
        return endBooks;
      } else {
        return books;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BookDetailModel> detailBook({required String id}) async {
    try {
      return await _bookDataSource.detailBook(id: id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addFavoriteBook(BookModel book) async {
    try {
      await _favoriteBooksDataSource.add(
        book,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteFavoriteBook(int index) async {
    try {
      await _favoriteBooksDataSource.deleteAt(index);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<BookModel>> getFavoriteBooks() async {
    try {
      final List<BookModel> favoriteBooks =
          await _favoriteBooksDataSource.getList(idBookLocal);

      return favoriteBooks;
    } catch (e) {
      rethrow;
    }
  }
}
