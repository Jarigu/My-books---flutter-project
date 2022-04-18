import 'dart:html';

import 'package:bloc_test/bloc_test.dart';
import 'package:my_books/data/models/book_model.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_books/domain/use_cases/favorite_books_use_case.dart';
import 'package:my_books/presentation/favorite_books/cubit/favorite_books_cubit.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

List<BookModel> booksMock = [];

class FavoriteBooksUseCaseMock extends Mock implements FavoriteBooksUseCase {}

main() {
  late FavoriteBooksUseCaseMock favoriteBooksUseCaseMock;

  late FavoriteBooksCubit favoriteBooksCubit;

  setUp(() {
    favoriteBooksUseCaseMock = FavoriteBooksUseCaseMock();

    favoriteBooksCubit = FavoriteBooksCubit(favoriteBooksUseCaseMock);
  });

  tearDown(() {
    favoriteBooksCubit.close();
  });

  test('cubit should have initial state as [FavoriteBooksState]', () {
    expect(favoriteBooksCubit.state.runtimeType, FavoriteBooksState);
  });

  blocTest(
    'should emit [FavoriteBooksLoading] when favorite books return success',
    build: () => favoriteBooksCubit,
    act: (FavoriteBooksCubit bloc) {
      when(favoriteBooksUseCaseMock.getFavoriteBooks())
          .thenAnswer((_) async => booksMock);

      bloc.getFavoriteBooks();
    },
    expect: () => [
      //isA<FavoriteBooksLoading>(),
      //isA<FavoriteBooksLoaded>(),
      FavoriteBooksLoading(),
      FavoriteBooksLoaded(bookList: booksMock),
    ],
  );
}
