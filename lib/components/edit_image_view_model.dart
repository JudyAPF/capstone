import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ibenture/models/text_info.dart';
import 'package:ibenture/provider/edit_image_provider.dart';
import 'package:ibenture/screens/business_model_canvas/edit_image.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;

abstract class EditImageViewModel extends State<EditImageScreen> {
  TextEditingController textController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  final GlobalKey stackKey = GlobalKey();

  // New method to save the Stack as a PDF file
  Future<void> saveAsPDF(BuildContext context) async {
    try {
      // Capture the Stack as an image
      RenderRepaintBoundary boundary =
          stackKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(
          pixelRatio: 3.0); // Higher pixel ratio for better quality
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Create PDF document
      final pdf = pw.Document();
      final pdfImage = pw.MemoryImage(pngBytes);

      // Add the captured image to the PDF
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(pdfImage, fit: pw.BoxFit.cover),
            ); // Center the image on the PDF page
          },
        ),
      );

      // Save PDF to temporary directory
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/BusinessModelCanvas.pdf");
      await file.writeAsBytes(await pdf.save());

      // Open the generated PDF
      OpenFile.open(file.path);
    } catch (e) {
      // ignore: avoid_print
      print("Error saving PDF: $e");
    }
  }

  addNewText(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final centerX = screenSize.width / 2;
    final centerY = screenSize.height / 2;

    EditImageProvider provider =
        Provider.of<EditImageProvider>(context, listen: false);

    setState(() {
      provider.texts.add(TextInfo(
        text: textController.text,
        left: centerX - 50,
        top: centerY - 50,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        fontSize: 20,
        textAlign: TextAlign.left,
      ));
      Navigator.of(context).pop();
    });
  }

  addNewDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add Text'),
            content: TextField(
              controller: textController,
              maxLines: 5,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.edit),
                filled: true,
                hintText: 'Your text here',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF311A72),
                  elevation: 5,
                ),
                onPressed: () {
                  addNewText(context);
                },
                child: const Text('Add Text',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ],
          );
        });
  }
}
