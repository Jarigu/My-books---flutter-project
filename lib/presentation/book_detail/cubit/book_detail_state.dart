part of 'book_detail_cubit.dart';

class BookDetailState {}

class BookDetailLoading extends BookDetailState {}

class BookDetailLoaded extends BookDetailState {
  final BookDetailModel bookDetail;

  BookDetailLoaded({required this.bookDetail});
}

class BookOfList extends BookDetailState {
  final BookModel book;

  BookOfList({required this.book});
}

class BookDetailException extends BookDetailState {
  final AppExceptionCode exception;

  BookDetailException({required this.exception});
}
