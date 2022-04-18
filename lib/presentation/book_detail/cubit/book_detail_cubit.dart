import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/core/exceptions/app_exception.dart';
import 'package:my_books/data/models/book_detail_model.dart';
import 'package:my_books/data/models/book_model.dart';
import 'package:my_books/domain/use_cases/book_detail_use_case.dart';

part 'book_detail_state.dart';

class BookDetailCubit extends Cubit<BookDetailState> {
  BookDetailCubit(this._bookDetailUseCase) : super(BookDetailState());

  final BookDetailUseCase _bookDetailUseCase;

  void getBookOfList(BookModel book) {
    emit(BookOfList(book: book));

    _getDetailBook(book);
  }

  Future<void> _getDetailBook(BookModel book) async {
    emit(BookDetailLoading());
    try {
      /**
      * TODO: It was not expected that the ISBN could be null, 
       */
      if (book.isbn.isNotEmpty) {
        final BookDetailModel bookDetail =
            await _bookDetailUseCase.detailBook(id: book.isbn);
        emit(BookDetailLoaded(bookDetail: bookDetail));
      } else {
        final BookDetailModel bookDetail = BookDetailModel(
          title: book.title,
          subtitle: '',
          description: '',
          publishDate: book.firstPublishYear,
          physicalFormat: '',
          authors: book.authorName,
          subjects: const [],
        );

        emit(BookDetailLoaded(bookDetail: bookDetail));
      }
    } catch (e) {
      emit(BookDetailException(exception: AppExceptionCode.genericError));
    }
  }
}
