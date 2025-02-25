class Bookmark {
  int? id;
  final String pdfUrl;
  final int page;
  final String message;
  final DateTime timestamp;

  Bookmark({
    this.id,
    required this.pdfUrl,
    required this.page,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pdfUrl': pdfUrl,
      'page': page,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'],
      pdfUrl: json['pdfUrl'],
      page: json['page'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}