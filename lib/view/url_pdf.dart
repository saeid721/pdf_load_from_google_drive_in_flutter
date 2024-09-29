import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../controller/pdf_controller.dart';
import 'widget/colors.dart';

class UrlPdf extends StatelessWidget {
  const UrlPdf({super.key});

  @override
  Widget build(BuildContext context) {
    final PdfController pdfController = Get.find<PdfController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: ColorRes.primaryColor),
        centerTitle: true,
        title: const Text(
          'Pdf View',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: ColorRes.primaryColor,
          ),
        ),
      ),
      body: Obx(() {
        return SfPdfViewer.network(
          pdfController.pdfUrl.value,
          onDocumentLoadFailed: (details) {
            const Center(child: Text('Failed to load PDF'));
          },
          canShowScrollHead: true,
          canShowScrollStatus: true,
        );
      }),
    );
  }
}
