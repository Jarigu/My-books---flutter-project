part of 'books_cubit.dart';

class BooksState {}

class BooksLoading extends BooksState {}

class BooksLoaded extends BooksState {
  final List<BookModel> bookList;
  final bool reset;

  BooksLoaded({required this.bookList, required this.reset});
}

class BooksException extends BooksState {
  final AppExceptionCode exception;

  BooksException({required this.exception});
}
