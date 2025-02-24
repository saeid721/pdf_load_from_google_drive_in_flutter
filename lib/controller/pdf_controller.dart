import 'package:get/get.dart';
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


  Future<void> downloadBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('downloadBooks') ?? [];
    downloadBooks.value = saved.map((e) => downloadBooks.fromJson(e)).toList();
  }

  List<DownloadBooks> getDownloadBooks() {
    return downloadBooks.where((b) => b.pdfUrl == pdfUrl.value).toList();
  }

}