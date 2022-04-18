import 'package:my_books/data/models/book_detail_model.dart';
import 'package:my_books/domain/repositories/i_book_repository.dart';

class BookDetailUseCase {
  BookDetailUseCase({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;

  final IBookRepository _bookRepository;

  Future<BookDetailModel> detailBook({required String id}) async {
    try {
      return await _bookRepository.detailBook(id: id);
    } catch (e) {
      rethrow;
    }
  }
}
