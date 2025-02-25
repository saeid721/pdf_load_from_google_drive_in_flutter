import 'package:get/get.dart';

class PdfSearchController extends GetxController {
  var isSearching = false.obs;
  var currentPage = 1.obs;
  var totalPages = 0.obs;
  var searchQuery = ''.obs;
  var searchResults = <int>[].obs;
  var currentSearchIndex = 0.obs;

  void setCurrentPage(int page) {
    currentPage.value = page;
  }

  void setTotalPages(int pages) {
    totalPages.value = pages;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void toggleSearching(bool value) {
    isSearching.value = value;
  }

  void resetSearch() {
    isSearching.value = false;
    searchQuery.value = '';
    searchResults.clear();
    currentSearchIndex.value = 0;
  }
}