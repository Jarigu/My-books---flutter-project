import 'package:dio/dio.dart';
import 'package:my_books/core/enums/filter_book.dart';
import 'package:my_books/data/models/book_detail_model.dart';
import 'package:my_books/data/models/book_model.dart';
import 'package:my_books/domain/datasources/i_book_data_source.dart';

class BookDataSource implements IBookDataSource {
  BookDataSource({required Dio client}) : _client = client;

  final Dio _client;

  @override
  Future<List<BookModel>> searchBooks({
    required FilterBook filterBook,
    required String searchValue,
    required int page,
  }) async {
    String filter = '';
    switch (filterBook) {
      case FilterBook.all:
        filter = 'q=$searchValue';
        break;
      case FilterBook.author:
        filter = 'author=$searchValue';
        break;
      case FilterBook.title:
        filter = 'title=$searchValue';
        break;
      default:
        filter = 'q=$searchValue';
        break;
    }

    try {
      final response =
          await _client.get('/search.json?$filter&page=$page&limit=10');

      List<BookModel> books = [];

      for (var item in response.data['docs']) {
        books.add(BookModel.fromMap(item));
      }

      return books;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BookDetailModel> detailBook({required String id}) async {
    final String isbn = 'ISBN:$id';
    try {
      final response = await _client
          .get('/api/books?bibkeys=$isbn&jscmd=details&format=json');

      return BookDetailModel.fromMap(response.data[isbn]['details']);
    } catch (e) {
      rethrow;
    }
  }
}
