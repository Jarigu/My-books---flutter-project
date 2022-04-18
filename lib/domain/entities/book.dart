import 'dart:convert';

import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String key;
  final String title;
  final String language;
  final String authorKey;
  final String authorName;
  final String isbn;
  final String firstPublishYear;
  final bool isFavorite;

  const Book({
    required this.key,
    required this.title,
    required this.language,
    required this.authorKey,
    required this.authorName,
    required this.isbn,
    required this.firstPublishYear,
    required this.isFavorite,
  });

  @override
  List<Object> get props {
    return [
      key,
      title,
      language,
      authorKey,
      authorName,
      isbn,
      firstPublishYear,
      isFavorite,
    ];
  }
}
