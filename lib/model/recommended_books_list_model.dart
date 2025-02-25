// class Data {
//   List<RecommendedBooksList>? recommendedBooksList;
//
//   Data({this.recommendedBooksList});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['recommended_books_list'] != null) {
//       recommendedBooksList = <RecommendedBooksList>[];
//       json['recommended_books_list'].forEach((v) {
//         recommendedBooksList!.add(RecommendedBooksList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (recommendedBooksList != null) {
//       data['recommended_books_list'] =
//           recommendedBooksList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class RecommendedBooksList {
//   int? id;
//   String? bookName;
//   String? authorName;
//   String? imageUrl;
//   String? pdfUrl;
//   String? description;
//   String? status;
//
//   RecommendedBooksList(
//       {this.id,
//         this.bookName,
//         this.authorName,
//         this.imageUrl,
//         this.pdfUrl,
//         this.description,
//         this.status});
//
//   RecommendedBooksList.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     bookName = json['bookName'];
//     authorName = json['authorName'];
//     imageUrl = json['imageUrl'];
//     pdfUrl = json['pdfUrl'];
//     description = json['description'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['bookName'] = bookName;
//     data['authorName'] = authorName;
//     data['imageUrl'] = imageUrl;
//     data['pdfUrl'] = pdfUrl;
//     data['description'] = description;
//     data['status'] = status;
//     return data;
//   }
// }
