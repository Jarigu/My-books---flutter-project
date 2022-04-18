import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/core/enums/action_view.dart';
import 'package:my_books/core/exceptions/app_exception.dart';
import 'package:my_books/data/models/book_model.dart';
import 'package:my_books/domain/use_cases/favorite_book_use_case.dart';

part 'favorite_book_state.dart';

class FavoriteBookCubit extends Cubit<FavoriteBookState> {
  FavoriteBookCubit(this._favoriteBookUseCase) : super(FavoriteBookState());

  final FavoriteBookUseCase _favoriteBookUseCase;

  Future<void> favoriteBookAction(BookModel book, ActionView view) async {
    emit(FavoriteBookLoading(view: view));
    try {
      if (book.isFavorite) {
        await _favoriteBookUseCase.removeFavoriteBook(book);
        emit(FavoriteBookRemoved(view: view));
      } else {
        await _favoriteBookUseCase.addFavoriteBook(
          BookModel(
            key: book.key,
            title: book.title,
            language: book.language,
            authorKey: book.authorKey,
            authorName: book.authorName,
            isbn: book.isbn,
            firstPublishYear: book.firstPublishYear,
            isFavorite: true,
          ),
        );
        emit(FavoriteBookAdded(view: view));
      }
    } catch (e) {
      emit(FavoriteBookException(
          exception: AppExceptionCode.genericError, view: view));
    }
  }
}
