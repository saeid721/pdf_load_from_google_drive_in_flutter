import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/book_model.dart';

class PdfController extends GetxController {
  var pdfUrl = ''.obs;
  var bookmarks = <Bookmark>[].obs;
  var downloadBooks = <DownloadBooks>[].obs;
  var currentPage = 1.obs;
  var totalPages = 0.obs;
  var searchQuery = ''.obs;
  var isSearching = false.obs;

  @override
  void onInit() {
    loadBookmarks();
    loadDownloadBooks();
    super.onInit();
  }

  void setPdfUrl(String url) => pdfUrl.value = url;

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('bookmarks') ?? [];
    bookmarks.value = saved.map((e) => Bookmark.fromJson(e)).toList();
  }

  Future<void> addBookmark(int page, String message) async {
    final bookmark = Bookmark(
      pdfUrl: pdfUrl.value,
      page: page,
      message: message,
      timestamp: DateTime.now(),
    );
    bookmarks.add(bookmark);
    await _saveBookmarks();
  }

  Future<void> removeBookmark(Bookmark bookmark) async {
    bookmarks.remove(bookmark);
    await _saveBookmarks();
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'bookmarks',
      bookmarks.map((e) => e.toJson()).toList(),
    );
  }

  List<Bookmark> getBookmarksForCurrentPdf() {
    return bookmarks.where((b) => b.pdfUrl == pdfUrl.value).toList();
  }

  Future<void> loadDownloadBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('downloadBooks') ?? [];
    downloadBooks.value = saved.map((e) => DownloadBooks.fromJson(e)).toList();
  }

  Future<void> addDownloadBook(DownloadBooks book) async {
    downloadBooks.add(book);
    await _saveDownloadBooks();
  }

  Future<void> removeDownloadBook(DownloadBooks book) async {
    downloadBooks.remove(book);
    await _saveDownloadBooks();
  }

  Future<void> _saveDownloadBooks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'downloadBooks',
      downloadBooks.map((e) => e.toJson()).toList(),
    );
  }

  List<DownloadBooks> getDownloadBooks() {
    return downloadBooks.where((b) => b.pdfUrl == pdfUrl.value).toList();
  }

  Future<void> downloadAndSavePdf(DownloadBooks book) async {
    try {
      // Make HTTP request to download the PDF
      final response = await http.get(Uri.parse(book.pdfUrl));

      if (response.statusCode == 200) {
        // Get the directory to save the file
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/${book.bookName}.pdf';

        // Save the file
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Add to download list
        await addDownloadBook(book);

        Get.snackbar('Success', '${book.bookName} downloaded successfully');
      } else {
        Get.snackbar('Error', 'Failed to download PDF');
      }
    } catch (e) {
      Get.snackbar('Error', 'Download failed: $e');
    }
  }
}
