import 'dart:convert';

import 'package:my_books/domain/entities/book_detail.dart';

class BookDetailModel extends BookDetail {
  const BookDetailModel({
    required final String title,
    required final String subtitle,
    required final String description,
    required final String publishDate,
    required final String physicalFormat,
    required final String authors,
    required final List<String> subjects,
  }) : super(
          title: title,
          subtitle: subtitle,
          description: description,
          publishDate: publishDate,
          physicalFormat: physicalFormat,
          authors: authors,
          subjects: subjects,
        );

  @override
  String toString() {
    return 'BookDetail(title: $title, subtitle: $subtitle, description: $description, publishDate: $publishDate, physicalFormat: $physicalFormat, authors: $authors, subjects: $subjects)';
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'publishDate': publishDate,
      'physicalFormat': physicalFormat,
      'authors': authors,
      'subjects': subjects,
    };
  }

  factory BookDetailModel.fromMap(Map<String, dynamic> map) {
    // final List<String> _authors = (map['authors'] as List<dynamic>)
    //     .map((dynamic value) => value['name'] as String)
    //     .toList();

    String _authors = '';

    if (map['authors'] != null) {
      for (var item in map['authors'] as List<dynamic>) {
        if (_authors.isEmpty) {
          _authors = item['name'] as String;
        } else {
          _authors = _authors + ', ' + item['name'];
        }
      }
    }
    return BookDetailModel(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      description: map['description'] ?? '',
      publishDate: map['publish_date'] ?? '',
      physicalFormat: map['physical_format'] ?? '',
      authors: _authors,
      subjects:
          map['subjects'] != null ? List<String>.from(map['subjects']) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookDetailModel.fromJson(String source) =>
      BookDetailModel.fromMap(json.decode(source));
}
