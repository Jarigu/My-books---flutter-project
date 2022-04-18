import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/core/enums/action_view.dart';
import 'package:my_books/core/routing/routes.dart';
import 'package:my_books/core/snackbars/common_snackbar.dart';
import 'package:my_books/core/widgets/cards/card_book.dart';
import 'package:my_books/presentation/book_detail/cubit/book_detail_cubit.dart';
import 'package:my_books/presentation/books/cubit/books_cubit.dart';
import 'package:my_books/presentation/books/view/books_view.dart';
import 'package:my_books/presentation/cubits/favorite_book_cubit.dart';
import 'package:my_books/presentation/favorite_books/cubit/favorite_books_cubit.dart';

class FavoriteBooksView extends StatelessWidget {
  const FavoriteBooksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocListener<FavoriteBooksCubit, FavoriteBooksState>(
            listener: (context, state) {
              if (state is FavoriteBooksException) {
                commonSnackBar(
                    message: 'An error occurred in the favorite books load',
                    context: context);
              }
            },
            child: BlocListener<FavoriteBookCubit, FavoriteBookState>(
              listener: (context, state) {
                if (state is FavoriteBookRemoved) {
                  if (state.view == ActionView.favorites) {
                    commonSnackBar(
                        message: 'Book removed of Favorites', context: context);
                  }
                  context.read<FavoriteBooksCubit>().getFavoriteBooks();
                  context.read<BooksCubit>().reloadSearchBooks();
                }

                if (state is FavoriteBookException) {
                  if (state.view == ActionView.favorites) {
                    commonSnackBar(
                        message: 'Book added to Favorites', context: context);
                  }
                }
              },
              child: Column(
                children: const [
                  Expanded(
                    child: _BooksContent(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BooksContent extends StatelessWidget {
  const _BooksContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBooksCubit, FavoriteBooksState>(
      builder: (context, state) {
        if (state is FavoriteBooksLoaded) {
          if (state.bookList.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10.0),
              itemCount: state.bookList.length, // the length
              itemBuilder: (context, index) {
                var book = state.bookList[index];

                return cardBook(
                  context: context,
                  onAction: () {
                    context.read<BookDetailCubit>().getBookOfList(book);
                    Navigator.pushNamed(context, RoutePaths.bookDetail);
                  },
                  onFavoriteAction: () {
                    context
                        .read<FavoriteBookCubit>()
                        .favoriteBookAction(book, ActionView.favorites);
                  },
                  bookModel: book,
                );
              },
            );
          } else {
            return const Center(
              child: Text('Not content yet'),
            );
          }
        } else if (state is FavoriteBooksLoading) {}
        return Container();
      },
    );
  }
}
