import 'dart:convert';

import 'package:equatable/equatable.dart';

class BookDetail extends Equatable {
  final String title;
  final String subtitle;
  final String description;
  final String publishDate;
  final String physicalFormat;
  final String authors;
  final List<String> subjects;

  const BookDetail({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.publishDate,
    required this.physicalFormat,
    required this.authors,
    required this.subjects,
  });

  @override
  List<Object> get props {
    return [
      title,
      subtitle,
      description,
      publishDate,
      physicalFormat,
      authors,
      subjects,
    ];
  }
}
