part of 'favorite_books_cubit.dart';

class FavoriteBooksState {}

class FavoriteBooksLoading extends FavoriteBooksState {}

class FavoriteBooksLoaded extends FavoriteBooksState {
  final List<BookModel> bookList;

  FavoriteBooksLoaded({required this.bookList});
}

class FavoriteBooksException extends FavoriteBooksState {
  final AppExceptionCode exception;

  FavoriteBooksException({required this.exception});
}
