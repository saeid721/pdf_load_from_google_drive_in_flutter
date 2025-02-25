import 'dart:convert';

class DownloadBooks {
  final String imageUrl;
  final String pdfUrl;
  final String bookName;
  final String authorName;
  final String shortDescription;

  DownloadBooks({
    required this.imageUrl,
    required this.pdfUrl,
    required this.bookName,
    required this.authorName,
    required this.shortDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'pdfUrl': pdfUrl,
      'bookName': bookName,
      'authorName': authorName,
      'shortDescription': shortDescription,
    };
  }

  factory DownloadBooks.fromMap(Map<String, dynamic> map) {
    return DownloadBooks(
      imageUrl: map['imageUrl'],
      pdfUrl: map['pdfUrl'],
      bookName: map['bookName'],
      authorName: map['authorName'],
      shortDescription: map['shortDescription'],
    );
  }

  String toJson() => json.encode(toMap());
  factory DownloadBooks.fromJson(String source) =>
      DownloadBooks.fromMap(json.decode(source));
}