part of 'favorite_book_cubit.dart';

class FavoriteBookState {}

class FavoriteBookLoading extends FavoriteBookState {
  final ActionView view;

  FavoriteBookLoading({required this.view});
}

class FavoriteBookAdded extends FavoriteBookState {
  final ActionView view;

  FavoriteBookAdded({required this.view});
}

class FavoriteBookRemoved extends FavoriteBookState {
  final ActionView view;

  FavoriteBookRemoved({required this.view});
}

class FavoriteBookException extends FavoriteBookState {
  final AppExceptionCode exception;
  final ActionView view;

  FavoriteBookException({required this.exception, required this.view});
}
