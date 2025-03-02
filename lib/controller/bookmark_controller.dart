import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../view/bookmarks_screen/components/bookmark_model.dart';

class BookmarkController extends GetxController {
  List<BookmarkModel> bookmarks = [];
  bool isDownloading = false; // Consider removing if not used
  double downloadProgress = 0.0; // Consider removing if not used
  String pdfUrl = '';
  String imageUrl = '';

  late Database database;

  @override
  void onInit() {
    super.onInit();
    _initDatabase();
  }

  void setPdfUrl(String url) {
    pdfUrl = url;
    loadBookmarks();
  }

  // Initialize the SQLite database
  Future<void> _initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'bookmarks.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE bookmarks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            pdfUrl TEXT,
            bookName TEXT,
            pageNumber INTEGER,
            note TEXT,
            dateAdded TEXT
          )
        ''');
      },
      version: 1,
    );
    await loadBookmarks();
  }

  // Load bookmarks from the database
  Future<void> loadBookmarks() async {
    final List<Map<String, dynamic>> maps = await database.query(
      'bookmarks',
      where: 'pdfUrl = ?',
      whereArgs: [pdfUrl],
      orderBy: 'pageNumber ASC',
    );
    bookmarks = List.generate(maps.length, (i) {
      return BookmarkModel.fromMap(maps[i]);
    });
    update(); // Notify UI of loaded bookmarks
  }

  // Add a new bookmark
  Future<void> addBookmark({
    required int pageNumber,
    required String bookName,
    required String note,
  }) async {
    final bookmark = BookmarkModel(
      imageUrl: imageUrl,
      pdfUrl: pdfUrl,
      bookName: bookName,
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
      imageUrl: bookmark.imageUrl,
      pdfUrl: bookmark.pdfUrl,
      bookName: bookmark.bookName,
      pageNumber: bookmark.pageNumber,
      note: bookmark.note,
      dateAdded: bookmark.dateAdded,
    ));
    update(); // Notify UI of added bookmark

    Get.snackbar('Success', 'Bookmark added for page $pageNumber');
  }

  // Remove a bookmark
  Future<void> removeBookmark(BookmarkModel bookmark) async {
    await database.delete(
      'bookmarks',
      where: 'id = ?',
      whereArgs: [bookmark.id],
    );
    bookmarks.removeWhere((b) => b.id == bookmark.id);
    update(); // Notify UI of removed bookmark

    Get.snackbar('Success', 'Bookmark removed');
  }

  // Fetch all bookmarks
  Future<List<BookmarkModel>> getAllBookmarks() async {
    final List<Map<String, dynamic>> maps = await database.query('bookmarks');
    return List.generate(maps.length, (i) {
      return BookmarkModel.fromMap(maps[i]);
    });
  }
}