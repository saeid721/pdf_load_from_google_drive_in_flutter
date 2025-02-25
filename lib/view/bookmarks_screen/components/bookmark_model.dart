class BookmarkModel {
  final int? id;
  final String pdfUrl;
  final int pageNumber;
  final String note;
  final DateTime dateAdded;

  BookmarkModel({
    this.id,
    required this.pdfUrl,
    required this.pageNumber,
    required this.note,
    required this.dateAdded,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pdfUrl': pdfUrl,
      'pageNumber': pageNumber,
      'note': note,
      'dateAdded': dateAdded.toIso8601String(),
    };
  }

  static BookmarkModel fromMap(Map<String, dynamic> map) {
    return BookmarkModel(
      id: map['id'],
      pdfUrl: map['pdfUrl'],
      pageNumber: map['pageNumber'],
      note: map['note'],
      dateAdded: DateTime.parse(map['dateAdded']),
    );
  }
}
