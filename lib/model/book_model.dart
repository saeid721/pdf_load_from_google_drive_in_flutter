class TrendingBooks {
  final String id;
  final String imageUrl;
  final String pdfUrl;
  final String bookName;
  final String authorName;
  String? shortDescription;

  TrendingBooks({
    required this.id,
    required this.imageUrl,
    required this.pdfUrl,
    required this.bookName,
    required this.authorName,
    this.shortDescription,
  });
}

class RecommendedBooks {
  final String id;
  final String imageUrl;
  final String pdfUrl;
  final String bookName;
  final String authorName;
  String? shortDescription;

  RecommendedBooks({
    required this.id,
    required this.imageUrl,
    required this.pdfUrl,
    required this.bookName,
    required this.authorName,
    this.shortDescription,
  });
}
