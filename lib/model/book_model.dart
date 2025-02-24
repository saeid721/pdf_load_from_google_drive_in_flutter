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
  String? shortDescription;

  RecommendedBooks({
    required this.imageUrl,
    required this.pdfUrl,
    required this.bookName,
    required this.authorName,
    this.shortDescription,
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
  factory Bookmark.fromJson(String source) =>
      Bookmark.fromMap(json.decode(source));
}

class DownloadBooks {
  final String imageUrl;
  final String pdfUrl;
  final String bookName;
  final String authorName;

  DownloadBooks({
    required this.imageUrl,
    required this.pdfUrl,
    required this.bookName,
    required this.authorName,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'pdfUrl': pdfUrl,
      'bookName': bookName,
      'authorName': authorName,
    };
  }

  factory DownloadBooks.fromMap(Map<String, dynamic> map) {
    return DownloadBooks(
      imageUrl: map['imageUrl'],
      pdfUrl: map['pdfUrl'],
      bookName: map['bookName'],
      authorName: map['authorName'],
    );
  }

  String toJson() => json.encode(toMap());
  factory DownloadBooks.fromJson(String source) =>
      DownloadBooks.fromMap(json.decode(source));
}
