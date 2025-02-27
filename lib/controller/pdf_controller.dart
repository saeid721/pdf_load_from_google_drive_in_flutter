import 'package:get/get.dart';
import 'search_controller.dart';
import 'bookmark_controller.dart';
import 'download_controller.dart';

class PdfController extends GetxController {
  var pdfUrl = ''.obs;
  late BookmarkController bookmarkController;
  late DownloadController downloadController;
  late PdfSearchController searchController;

  @override
  void onInit() {
    super.onInit();

    // Initialize if not already done elsewhere
    if (!Get.isRegistered<BookmarkController>()) {
      Get.put(BookmarkController());
    }
    if (!Get.isRegistered<DownloadController>()) {
      Get.put(DownloadController());
    }
    if (!Get.isRegistered<PdfSearchController>()) {
      Get.put(PdfSearchController());
    }

    bookmarkController = Get.find<BookmarkController>();
    downloadController = Get.find<DownloadController>();
    searchController = Get.find<PdfSearchController>();
  }

  void setPdfUrl(String url) {
    pdfUrl.value = url;
    bookmarkController.setPdfUrl(url);
    downloadController.setPdfUrl(url);
    searchController.resetSearch();
  }
}