import 'dart:convert';

import 'package:my_books/domain/entities/book.dart';

import 'package:hive/hive.dart';

part 'adapters/book_model.g.dart';

//@HiveType(typeId: 0)
class BookModel extends Book {
  const BookModel({
    required final String key,
    required final String title,
    required final String language,
    required final String authorKey,
    required final String authorName,
    required final String isbn,
    required final String firstPublishYear,
    required final bool isFavorite,
    //});
  }) : super(
          key: key,
          title: title,
          language: language,
          authorKey: authorKey,
          authorName: authorName,
          isbn: isbn,
          firstPublishYear: firstPublishYear,
          isFavorite: isFavorite,
        );

  // @HiveField(0)
  // final String key;
  // @HiveField(1)
  // final String title;
  // @HiveField(2)
  // final String language;
  // @HiveField(3)
  // final String authorKey;
  // @HiveField(4)
  // final String authorName;
  // @HiveField(5)
  // final String isbn;
  // @HiveField(6)
  // final String firstPublishYear;
  // @HiveField(7)
  // final bool isFavorite;

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'title': title,
      'language': language,
      'authorKey': authorKey,
      'authorName': authorName,
      'isbn': isbn,
      'firstPublishYear': firstPublishYear,
      'isFavorite': isFavorite,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    String _authors = '';

    if (map['author_name'] != null) {
      for (var item in map['author_name'] as List<dynamic>) {
        if (_authors.isEmpty) {
          _authors = item;
        } else {
          _authors = _authors + ', ' + item;
        }
      }
    }

    return BookModel(
      key: map['key'] ?? '',
      title: map['title'] ?? '',
      language: map['language'] != null ? map['language'][0] : '',
      authorKey: map['author_key'] != null ? map['author_key'][0] : '',
      authorName: _authors,
      isbn: map['isbn'] != null ? map['isbn'][0] : '',
      firstPublishYear: map['first_publish_year'] != null
          ? map['first_publish_year'].toString()
          : '',
      isFavorite: false,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source));
}
