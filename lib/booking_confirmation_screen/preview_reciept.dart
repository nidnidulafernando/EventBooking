import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../reusable_components/custom_app_bar.dart';

class PDFViewPage extends StatelessWidget {
  final String pdfPath;

  const PDFViewPage({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Event Receipt'),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}
