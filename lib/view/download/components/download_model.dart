class DownloadBooks {
  final int? id;
  final String imageUrl;
  final String pdfUrl;
  final String bookName;
  final String authorName;
  final String shortDescription;

  DownloadBooks({
    this.id,
    required this.imageUrl,
    required this.pdfUrl,
    required this.bookName,
    required this.authorName,
    required this.shortDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'pdfUrl': pdfUrl,
      'bookName': bookName,
      'authorName': authorName,
      'shortDescription': shortDescription,
    };
  }

  static DownloadBooks fromMap(Map<String, dynamic> map) {
    return DownloadBooks(
      id: map['id'],
      imageUrl: map['imageUrl'],
      pdfUrl: map['pdfUrl'],
      bookName: map['bookName'],
      authorName: map['authorName'],
      shortDescription: map['shortDescription'],
    );
  }
}