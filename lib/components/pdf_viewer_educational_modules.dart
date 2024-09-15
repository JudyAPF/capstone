import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PDFViewerScreen extends StatefulWidget {
  final String pdfPath;
  final String title;

  const PDFViewerScreen({super.key, required this.pdfPath, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? localFilePath;

  @override
  void initState() {
    super.initState();
    loadPDF();
  }

  Future<void> loadPDF() async {
    try {
      final ByteData data = await rootBundle.load(widget.pdfPath);
      final Directory tempDir = await getTemporaryDirectory();
      final File tempFile = File('${tempDir.path}/temp.pdf');
      await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
      setState(() {
        localFilePath = tempFile.path;
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error while loading the PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: localFilePath != null
          ? PDFView(
              filePath: localFilePath,
              onRender: (pages) {
                // ignore: avoid_print
                print('Rendered PDF with $pages pages.');
              },
              onError: (error) {
                // ignore: avoid_print
                print('Error while loading the PDF: $error');
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
