import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../view/download/components/download_model.dart';

class DownloadController extends GetxController {
  List<DownloadBooks> downloadBooks = [];
  String pdfUrl = '';
  bool isDownloading = false;
  double downloadProgress = 0.0;
  late Database database;


  @override
  void onInit() {
    super.onInit();
    _initDatabase();
  }

  void setPdfUrl(String url) {
    pdfUrl = url;
    update(); // Optional: Remove if UI doesn't need immediate update
  }

  Future<void> _initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'download_books.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE downloadBooks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imageUrl TEXT,
            pdfUrl TEXT,
            bookName TEXT,
            authorName TEXT,
            shortDescription TEXT
          )
        ''');
      },
      version: 1,
    );
    await loadDownloadBooks();
  }

  Future<void> loadDownloadBooks() async {
    final List<Map<String, dynamic>> maps =
        await database.query('downloadBooks');
    downloadBooks = List.generate(maps.length, (i) {
      return DownloadBooks.fromMap(maps[i]);
    });
    update(); // Notify UI of loaded books
  }

  Future<void> addDownloadBook(DownloadBooks book) async {
    await database.insert(
      'downloadBooks',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (!downloadBooks.any((b) => b.pdfUrl == book.pdfUrl)) {
      downloadBooks.add(book);
      update(); // Notify UI of new book
    }
  }

  Future<void> removeDownloadBook(DownloadBooks book) async {
    await database.delete(
      'downloadBooks',
      where: 'pdfUrl = ?',
      whereArgs: [book.pdfUrl],
    );

    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${book.bookName}.pdf';
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error deleting file: $e');
    }

    downloadBooks.removeWhere((b) => b.pdfUrl == book.pdfUrl);
    update(); // Notify UI of removal
  }

  Future<bool> checkIfFileExists(String filePath) async {
    final file = File(filePath);
    return await file.exists();
  }

  Future<void> downloadAndSavePdf(DownloadBooks book) async {
    try {
      if (isDownloading) {
        Get.snackbar('Info', 'Another download is in progress');
        return;
      }

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${book.bookName}.pdf';

      if (await checkIfFileExists(filePath)) {
        Get.snackbar('Info', '${book.bookName} is already downloaded');
        await addDownloadBook(book);
        return;
      }

      isDownloading = true;
      downloadProgress = 0.0;
      update(); // Notify UI of download start

      final response = await http.get(Uri.parse(book.pdfUrl));

      if (response.statusCode == 200) {
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        await addDownloadBook(book);

        isDownloading = false;
        downloadProgress = 1.0;
        update(); // Notify UI of download completion
        Get.snackbar('Success', '${book.bookName} downloaded successfully');
      } else {
        isDownloading = false;
        downloadProgress = 0.0;
        update(); // Notify UI of failure
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      isDownloading = false;
      downloadProgress = 0.0;
      update(); // Notify UI of error
      Get.snackbar('Error', 'Download failed: $e');
    }
  }

  bool isBookDownloaded(String pdfUrl) {
    return downloadBooks.any((book) => book.pdfUrl == pdfUrl);
  }

  DownloadBooks? getDownloadedBook(String pdfUrl) {
    try {
      return downloadBooks.firstWhere((book) => book.pdfUrl == pdfUrl);
    } catch (e) {
      return null;
    }
  }
}
