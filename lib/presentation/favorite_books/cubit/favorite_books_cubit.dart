import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/core/exceptions/app_exception.dart';
import 'package:my_books/data/models/book_model.dart';
import 'package:my_books/domain/use_cases/favorite_books_use_case.dart';

part 'favorite_books_state.dart';

class FavoriteBooksCubit extends Cubit<FavoriteBooksState> {
  FavoriteBooksCubit(this._favoriteBooksUseCase) : super(FavoriteBooksState());

  final FavoriteBooksUseCase _favoriteBooksUseCase;

  Future<void> getFavoriteBooks() async {
    emit(FavoriteBooksLoading());
    try {
      List<BookModel> books = await _favoriteBooksUseCase.getFavoriteBooks();
      emit(FavoriteBooksLoaded(bookList: books));
    } catch (e) {
      emit(FavoriteBooksException(exception: AppExceptionCode.genericError));
    }
  }
}
