import 'dart:convert';

class TrendingBooks {
  final String imageUrl;
  final String pdfUrl;
  final String bookName;
  final String authorName;

  TrendingBooks({
    required this.imageUrl,
    required this.pdfUrl,
    required this.bookName,
    required this.authorName,
  });
}

class RecommendedBooks {
  final String imageUrl;
  final String pdfUrl;
  final String bookName;
  final String authorName;

  RecommendedBooks({
    required this.imageUrl,
    required this.pdfUrl,
    required this.bookName,
    required this.authorName,
  });
}

class Bookmark {
  final String pdfUrl;
  final int page;
  final String message;
  final DateTime timestamp;

  Bookmark({
    required this.pdfUrl,
    required this.page,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'pdfUrl': pdfUrl,
      'page': page,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Bookmark.fromMap(Map<String, dynamic> map) {
    return Bookmark(
      pdfUrl: map['pdfUrl'],
      page: map['page'],
      message: map['message'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  String toJson() => json.encode(toMap());
  factory Bookmark.fromJson(String source) => Bookmark.fromMap(json.decode(source));
}