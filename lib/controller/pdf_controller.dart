import 'package:get/get.dart';

class PdfController extends GetxController {
  var pdfUrl = ''.obs;

  void setPdfUrl(String url) {
    pdfUrl.value = url;
  }
}
