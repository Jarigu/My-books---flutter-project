import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_books/core/snackbars/common_snackbar.dart';
import 'package:my_books/data/models/book_detail_model.dart';
import 'package:my_books/presentation/book_detail/cubit/book_detail_cubit.dart';

class BookDetailView extends StatelessWidget {
  const BookDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: BlocListener<BookDetailCubit, BookDetailState>(
          listener: (context, state) {
            if (state is BookDetailException) {
              commonSnackBar(
                  message: 'An error ocurred in the book detail load',
                  context: context);
            }
          },
          child: Column(
            children: const [
              Expanded(
                child: _Detail(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailCubit, BookDetailState>(
      builder: (context, state) {
        if (state is BookDetailLoaded) {
          final BookDetailModel bookDetail = state.bookDetail;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  bookDetail.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Text(
                bookDetail.subtitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              if (bookDetail.description.isNotEmpty)
                const Text(
                  'Description:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                bookDetail.description,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              if (bookDetail.subjects.isNotEmpty)
                const Text(
                  'Subjects:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              const SizedBox(
                height: 10.0,
              ),
              if (bookDetail.subjects.isNotEmpty)
                ListView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookDetail.subjects.length,
                    itemBuilder: (context, index) {
                      return Text(
                        bookDetail.subjects[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      );
                    }),
              const SizedBox(
                height: 20.0,
              ),
              if (bookDetail.authors.isNotEmpty)
                const Text(
                  'Authors:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                bookDetail.authors,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              if (bookDetail.authors.isNotEmpty)
                const Text(
                  'Publish date:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                bookDetail.publishDate,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black,
                ),
              )
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
