import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/core/enums/filter_book.dart';
import 'package:my_books/core/exceptions/app_exception.dart';
import 'package:my_books/data/models/book_model.dart';
import 'package:my_books/domain/use_cases/book_use_case.dart';

part 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  BooksCubit(this._bookUseCase) : super(BooksState());

  final BookUseCase _bookUseCase;

  FilterBook _filterBook = FilterBook.all;
  String _searchValue = '';
  int _page = 1;

  void getSearchValue(String value) {
    _searchValue = value;
    _searchBooks(reset: true);
  }

  void getFilterValue(FilterBook filterBook) {
    _filterBook = filterBook;
    _searchBooks(reset: true);
  }

  void getPaginatorValue(int page) {
    _page = page;
    _searchBooks(reset: false);
  }

  Future<void> _searchBooks({
    required bool reset,
  }) async {
    if (_searchValue.length < 5) return;

    emit(BooksLoading());

    try {
      List<BookModel> books = await _bookUseCase.searchBooks(
          filterBook: _filterBook, searchValue: _searchValue, page: _page);

      emit(BooksLoaded(bookList: books, reset: reset));
    } catch (e) {
      emit(BooksException(exception: AppExceptionCode.genericError));
    }
  }

  void reloadSearchBooks() {
    _searchBooks(reset: true);
  }
}
