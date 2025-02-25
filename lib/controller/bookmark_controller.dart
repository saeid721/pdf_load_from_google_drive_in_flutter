import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../view/bookmarks_screen/components/bookmark_model.dart';

class BookmarkController extends GetxController {
  var bookmarks = <BookmarkModel>[].obs;
  var pdfUrl = ''.obs;
  var isDownloading = false.obs;
  var downloadProgress = 0.0.obs;
  late Database database;

  @override
  void onInit() {
    super.onInit();
    _initDatabase();
  }

  void setPdfUrl(String url) {
    pdfUrl.value = url;
    loadBookmarks();
  }

  Future<void> _initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'bookmarks.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE bookmarks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            pdfUrl TEXT,
            pageNumber INTEGER,
            note TEXT,
            dateAdded TEXT
          )
        ''');
      },
      version: 1,
    );
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    final List<Map<String, dynamic>> maps = await database.query(
      'bookmarks',
      where: 'pdfUrl = ?',
      whereArgs: [pdfUrl.value],
      orderBy: 'pageNumber ASC',
    );

    bookmarks.value = List.generate(maps.length, (i) {
      return BookmarkModel.fromMap(maps[i]);
    });
  }

  Future<void> addBookmark(int pageNumber, String note) async {
    final bookmark = BookmarkModel(
      pdfUrl: pdfUrl.value,
      pageNumber: pageNumber,
      note: note,
      dateAdded: DateTime.now(),
    );

    final id = await database.insert(
      'bookmarks',
      bookmark.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    bookmarks.add(BookmarkModel(
      id: id,
      pdfUrl: bookmark.pdfUrl,
      pageNumber: bookmark.pageNumber,
      note: bookmark.note,
      dateAdded: bookmark.dateAdded,
    ));

    Get.snackbar('Success', 'Bookmark added for page $pageNumber');
  }

  Future<void> removeBookmark(BookmarkModel bookmark) async {
    await database.delete(
      'bookmarks',
      where: 'id = ?',
      whereArgs: [bookmark.id],
    );

    bookmarks.removeWhere((b) => b.id == bookmark.id);
    Get.snackbar('Success', 'Bookmark removed');
  }

  Future<List<BookmarkModel>> getAllBookmarks() async {
    final List<Map<String, dynamic>> maps = await database.query('bookmarks');
    return List.generate(maps.length, (i) {
      return BookmarkModel.fromMap(maps[i]);
    });
  }
}
