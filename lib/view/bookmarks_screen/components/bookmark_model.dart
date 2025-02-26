class BookmarkModel {
  final int? id;
  final String pdfUrl;
  final String bookName;
  final int pageNumber;
  final String note;
  final DateTime dateAdded;

  BookmarkModel({
    this.id,
    required this.pdfUrl,
    required this.bookName,
    required this.pageNumber,
    required this.note,
    required this.dateAdded,
  });

  // Convert a BookmarkModel into a Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pdfUrl': pdfUrl,
      'bookName': bookName,
      'pageNumber': pageNumber,
      'note': note,
      'dateAdded': dateAdded.toIso8601String(),
    };
  }

  // Create a BookmarkModel from a Map retrieved from the database
  factory BookmarkModel.fromMap(Map<String, dynamic> map) {
    return BookmarkModel(
      id: map['id'],
      pdfUrl: map['pdfUrl'],
      bookName: map['bookName'],
      pageNumber: map['pageNumber'],
      note: map['note'],
      dateAdded: DateTime.parse(map['dateAdded']),
    );
  }
}