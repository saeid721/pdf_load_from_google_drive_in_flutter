class BookmarkModel {
  final int? id;
  final String imageUrl;
  final String pdfUrl;
  final String bookName;
  final int pageNumber;
  final String note;
  final DateTime dateAdded;

  BookmarkModel({
    this.id,
    required this.imageUrl,
    required this.pdfUrl,
    required this.bookName,
    required this.pageNumber,
    required this.note,
    required this.dateAdded,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'pdfUrl': pdfUrl,
      'bookName': bookName,
      'pageNumber': pageNumber,
      'note': note,
      'dateAdded': dateAdded.toIso8601String(),
    };
  }

  factory BookmarkModel.fromMap(Map<String, dynamic> map) {
    return BookmarkModel(
      id: map['id'] as int?,
      imageUrl: map['imageUrl'],
      pdfUrl: map['pdfUrl']?.toString() ?? '',
      bookName: map['bookName']?.toString() ?? 'Unknown Book',
      pageNumber: (map['pageNumber'] as int?) ?? 0,
      note: map['note']?.toString() ?? 'No note',
      dateAdded: DateTime.parse(map['dateAdded']?.toString() ??
          DateTime.now().toIso8601String()),
    );
  }
}