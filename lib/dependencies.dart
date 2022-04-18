import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:my_books/data/datasources/book_data_source.dart';
import 'package:my_books/data/datasources/local/hive_data_source.dart';
import 'package:my_books/data/models/book_model.dart';
import 'package:my_books/data/repositories/book_repository.dart';
import 'package:my_books/domain/repositories/i_book_repository.dart';
import 'package:my_books/domain/use_cases/book_detail_use_case.dart';
import 'package:my_books/domain/use_cases/book_use_case.dart';
import 'package:my_books/domain/use_cases/favorite_book_use_case.dart';
import 'package:my_books/domain/use_cases/favorite_books_use_case.dart';
import 'package:my_books/presentation/book_detail/cubit/book_detail_cubit.dart';
import 'package:my_books/presentation/books/cubit/books_cubit.dart';
import 'package:my_books/presentation/cubits/favorite_book_cubit.dart';
import 'package:my_books/presentation/favorite_books/cubit/favorite_books_cubit.dart';

List<RepositoryProvider> buildRepositories({
  required Dio client,
  required Box<BookModel> bookBox,
}) {
  return [
    //Repositories
    RepositoryProvider<IBookRepository>(
      create: (_) => BookRepository(
        bookDataSource: BookDataSource(client: client),
        favoriteBooksDataSource: HiveDataSource(box: bookBox),
      ),
    ),

    //Use cases
    RepositoryProvider<FavoriteBookUseCase>(
      create: (context) => FavoriteBookUseCase(
        bookRepository: context.read<IBookRepository>(),
      ),
    ),

    RepositoryProvider<BookUseCase>(
      create: (context) => BookUseCase(
        bookRepository: context.read<IBookRepository>(),
      ),
    ),

    RepositoryProvider<FavoriteBooksUseCase>(
      create: (context) => FavoriteBooksUseCase(
        bookRepository: context.read<IBookRepository>(),
      ),
    ),

    RepositoryProvider<BookDetailUseCase>(
      create: (context) => BookDetailUseCase(
        bookRepository: context.read<IBookRepository>(),
      ),
    ),
  ];
}

List<BlocProvider> buildBlocs(BuildContext context) {
  return [
    BlocProvider<BooksCubit>(
      create: (context) => BooksCubit(
        context.read<BookUseCase>(),
      ),
    ),
    BlocProvider<FavoriteBookCubit>(
      create: (context) => FavoriteBookCubit(
        context.read<FavoriteBookUseCase>(),
      ),
    ),
    BlocProvider<FavoriteBooksCubit>(
      create: (context) => FavoriteBooksCubit(
        context.read<FavoriteBooksUseCase>(),
      ),
    ),
    BlocProvider<BookDetailCubit>(
      create: (context) => BookDetailCubit(
        context.read<BookDetailUseCase>(),
      ),
    ),
  ];
}
