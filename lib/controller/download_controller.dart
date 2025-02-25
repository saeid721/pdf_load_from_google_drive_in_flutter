import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../view/download/components/download_model.dart';

class DownloadController extends GetxController {
  var downloadBooks = <DownloadBooks>[].obs;
  var pdfUrl = ''.obs;
  var isDownloading = false.obs;
  var downloadProgress = 0.0.obs;
  late Database database;

  @override
  void onInit() {
    super.onInit();
    _initDatabase();
  }

  void setPdfUrl(String url) => pdfUrl.value = url;

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
    loadDownloadBooks();
  }

  Future<void> loadDownloadBooks() async {
    final List<Map<String, dynamic>> maps =
        await database.query('downloadBooks');
    downloadBooks.value = List.generate(maps.length, (i) {
      return DownloadBooks.fromMap(maps[i]);
    });
  }

  Future<void> addDownloadBook(DownloadBooks book) async {
    await database.insert(
      'downloadBooks',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Check if the book is already in the list before adding
    if (!downloadBooks.any((b) => b.pdfUrl == book.pdfUrl)) {
      downloadBooks.add(book);
    }
  }

  Future<void> removeDownloadBook(DownloadBooks book) async {
    await database.delete(
      'downloadBooks',
      where: 'pdfUrl = ?',
      whereArgs: [book.pdfUrl],
    );

    // Also remove the PDF file from storage
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
  }

  Future<bool> checkIfFileExists(String filePath) async {
    final file = File(filePath);
    return await file.exists();
  }

  Future<void> downloadAndSavePdf(DownloadBooks book) async {
    try {
      if (isDownloading.value) {
        Get.snackbar('Info', 'Another download is in progress');
        return;
      }

      // Get the directory to save the file
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${book.bookName}.pdf';

      // Check if file already exists
      if (await checkIfFileExists(filePath)) {
        Get.snackbar('Info', '${book.bookName} is already downloaded');
        await addDownloadBook(book);
        return;
      }

      isDownloading.value = true;
      downloadProgress.value = 0.0;

      // Make HTTP request to download the PDF
      final request = http.Request('GET', Uri.parse(book.pdfUrl));
      final response = await request.send();

      if (response.statusCode == 200) {
        final totalBytes = response.contentLength ?? 0;
        List<int> bytes = [];
        int receivedBytes = 0;

        // Listen to the stream and update progress
        await response.stream.listen(
          (List<int> chunk) {
            bytes.addAll(chunk);
            receivedBytes += chunk.length;
            if (totalBytes > 0) {
              downloadProgress.value = receivedBytes / totalBytes;
            }
          },
          onDone: () async {
            // Save the file
            final file = File(filePath);
            await file.writeAsBytes(bytes);

            // Add to download list
            await addDownloadBook(book);

            isDownloading.value = false;
            downloadProgress.value = 1.0;
            Get.snackbar('Success', '${book.bookName} downloaded successfully');
          },
          onError: (e) {
            isDownloading.value = false;
            throw Exception('Download failed: $e');
          },
          cancelOnError: true,
        ).asFuture();
      } else {
        isDownloading.value = false;
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      isDownloading.value = false;
      downloadProgress.value = 0.0;
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
