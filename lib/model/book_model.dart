import 'dart:convert';

class TrendingBooks {
  final String imageUrl;
  final String pdfUrl;
  final String bookName;
  final String authorName;
  String? shortDescription;

  TrendingBooks({
    required this.imageUrl,
    required this.pdfUrl,
    required this.bookName,
    required this.authorName,
    this.shortDescription,
  });
}

class RecommendedBooks {
  final String imageUrl;
  final String pdfUrl;
  final String bookName;
  final String authorName;
  String? shortDescription;

  RecommendedBooks({
    required this.imageUrl,
    required this.pdfUrl,
    required this.bookName,
    required this.authorName,
    this.shortDescription,
  });
}
