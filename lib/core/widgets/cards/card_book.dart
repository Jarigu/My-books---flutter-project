import 'package:flutter/material.dart';
import 'package:my_books/data/models/book_model.dart';

Widget cardBook({
  required BuildContext context,
  required Function onAction,
  required Function onFavoriteAction,
  required BookModel bookModel,
}) {
  return GestureDetector(
    onTap: () => onAction(),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookModel.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Authors ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(text: bookModel.authorName),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(bookModel.language),
                      Text(bookModel.firstPublishYear),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => onFavoriteAction(),
              icon: Icon(
                bookModel.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
