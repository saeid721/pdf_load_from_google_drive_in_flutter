import 'package:get/get.dart';
import 'search_controller.dart';
import 'bookmark_controller.dart';
import 'download_controller.dart';

class PdfController extends GetxController {
  String pdfUrl = '';
  late BookmarkController bookmarkController;
  late DownloadController downloadController;
  late PdfSearchController searchController;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
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
    pdfUrl = url;
    bookmarkController.setPdfUrl(url);
    downloadController.setPdfUrl(url);
    searchController.resetSearch();
  }

  Future<void> fetchData(Function(bool) onLoadingChanged) async {
    isLoading = true;
    onLoadingChanged(true);
    await Future.delayed(const Duration(seconds: 3));
    isLoading = false;
    onLoadingChanged(false);
  }
}
