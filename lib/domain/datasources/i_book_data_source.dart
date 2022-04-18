import 'package:my_books/core/enums/filter_book.dart';
import 'package:my_books/data/models/book_detail_model.dart';
import 'package:my_books/data/models/book_model.dart';

abstract class IBookDataSource {
  Future<List<BookModel>> searchBooks({
    required FilterBook filterBook,
    required String searchValue,
    required int page,
  });

  Future<BookDetailModel> detailBook({required String id});
}
