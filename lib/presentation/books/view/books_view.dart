import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/core/enums/action_view.dart';
import 'package:my_books/core/enums/filter_book.dart';
import 'package:my_books/core/routing/routes.dart';
import 'package:my_books/core/snackbars/common_snackbar.dart';
import 'package:my_books/core/widgets/buttons/select_button.dart';
import 'package:my_books/core/widgets/cards/card_book.dart';
import 'package:my_books/data/models/book_model.dart';
import 'package:my_books/presentation/book_detail/cubit/book_detail_cubit.dart';
import 'package:my_books/presentation/books/cubit/books_cubit.dart';
import 'package:my_books/presentation/cubits/favorite_book_cubit.dart';

class BooksView extends StatelessWidget {
  const BooksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocListener<BooksCubit, BooksState>(
            listener: (context, state) {
              if (state is BooksException) {
                commonSnackBar(
                    message: 'An error occurred in the search',
                    context: context);
              }
            },
            child: BlocListener<FavoriteBookCubit, FavoriteBookState>(
              listener: (context, state) {
                if (state is FavoriteBookAdded) {
                  if (state.view == ActionView.books) {
                    context.read<BooksCubit>().reloadSearchBooks();
                    commonSnackBar(
                        message: 'Book added to Favorites', context: context);
                  }
                }

                if (state is FavoriteBookRemoved) {
                  if (state.view == ActionView.books) {
                    context.read<BooksCubit>().reloadSearchBooks();
                    commonSnackBar(
                        message: 'Book removed of Favorites', context: context);
                  }
                }

                if (state is FavoriteBookException) {
                  if (state.view == ActionView.books) {
                    commonSnackBar(
                        message: 'Book added to Favorites', context: context);
                  }
                }
              },
              child: Column(
                children: const [
                  SizedBox(
                    height: 20.0,
                  ),
                  _InputSearch(),
                  _FilterSearch(),
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

class _InputSearch extends StatelessWidget {
  const _InputSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => context.read<BooksCubit>().getSearchValue(value),
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        hintText: 'Enter a search term',
      ),
    );
  }
}

class _FilterSearch extends StatefulWidget {
  const _FilterSearch({Key? key}) : super(key: key);

  @override
  State<_FilterSearch> createState() => _FilterSearchState();
}

class _FilterSearchState extends State<_FilterSearch> {
  FilterBook filterBook = FilterBook.all;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        selectButton(
          text: 'All',
          context: context,
          iconData: Icons.all_inclusive_outlined,
          actionOnPressed: () {
            context.read<BooksCubit>().getFilterValue(FilterBook.all);
            setState(() {
              filterBook = FilterBook.all;
            });
          },
          selected: FilterBook.all == filterBook,
        ),
        const SizedBox(
          width: 10.0,
        ),
        selectButton(
          text: 'Author',
          context: context,
          iconData: Icons.person_outline_outlined,
          actionOnPressed: () {
            context.read<BooksCubit>().getFilterValue(FilterBook.author);
            setState(() {
              filterBook = FilterBook.author;
            });
          },
          selected: FilterBook.author == filterBook,
        ),
        const SizedBox(
          width: 10.0,
        ),
        selectButton(
          text: 'Title',
          context: context,
          iconData: Icons.book_outlined,
          actionOnPressed: () {
            context.read<BooksCubit>().getFilterValue(FilterBook.title);
            setState(() {
              filterBook = FilterBook.title;
            });
          },
          selected: FilterBook.title == filterBook,
        ),
      ],
    );
  }
}

class _BooksContent extends StatefulWidget {
  const _BooksContent({Key? key}) : super(key: key);

  @override
  State<_BooksContent> createState() => _BooksContentState();
}

class _BooksContentState extends State<_BooksContent> {
  late ScrollController scrollController;
  List<BookModel> books = [];
  bool isLoaded = false;
  bool isNotEmpty = false;
  int page = 1;

  _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        isLoaded &&
        isNotEmpty) {
      context.read<BooksCubit>().getPaginatorValue(page);
      page = page + 1;
      isLoaded = false;
    }
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit, BooksState>(
      // buildWhen: (previous, current) =>
      //     previous is BooksLoaded != current is BooksLoaded,
      builder: (context, state) {
        if (state is BooksLoaded) {
          isNotEmpty = state.bookList.isNotEmpty;

          if (state.reset) {
            books = state.bookList;
          } else {
            books.addAll(state.bookList);
          }

          isLoaded = true;
        }
        if (books.isNotEmpty) {
          return Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.only(top: 10.0),
                controller: scrollController,
                itemCount: books.length, // the length
                itemBuilder: (context, index) {
                  var book = books[index];

                  return cardBook(
                    context: context,
                    onAction: () {
                      context.read<BookDetailCubit>().getBookOfList(book);
                      Navigator.pushNamed(context, RoutePaths.bookDetail);
                    },
                    onFavoriteAction: () {
                      context
                          .read<FavoriteBookCubit>()
                          .favoriteBookAction(book, ActionView.books);
                    },
                    bookModel: book,
                  );
                },
              ),
              if (state is BooksLoading)
                Positioned(
                  bottom: 0,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 65.0,
                    child: Transform.translate(
                      offset: const Offset(-20.0, 0),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
            ],
          );
        } else if (state is BooksLoaded) {
          return const Center(
            child: Text('Content not found'),
          );
        } else if (state is BooksLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center(
          child: Text('Search for show'),
        );
      },
    );
  }
}
