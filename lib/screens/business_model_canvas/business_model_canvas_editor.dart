import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibenture/provider/edit_image_provider.dart';
import 'package:ibenture/screens/business_model_canvas/edit_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BusinessModelCanvasEditor extends StatelessWidget {
  const BusinessModelCanvasEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditImageProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFF311A72),
        centerTitle: true,
        title: const Text(
          'Business Model Canvas Editor',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: GestureDetector(
            onTap: () async {
              provider.file =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (provider.file == null) return;
              provider.selectedImage = provider.file?.path;
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EditImageScreen(),
                ),
              );
            },
            child: Opacity(
              opacity: 0.5,
              child: Image.asset('assets/images/upload_file.png', width: 150.w, height: 150.h,))),
      ),
    );
  }
}
