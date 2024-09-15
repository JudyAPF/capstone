
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibenture/models/text_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class EditImageProvider extends ChangeNotifier {
  XFile? file;
  String? selectedImage = '';

  List<TextInfo> texts = [];

  addText(TextInfo text) {
    texts.add(text);
    notifyListeners();
  }

  removeAllTexts() {
    texts.clear();
    notifyListeners();
  }

  int currentIndex = 0;

  setCurrentIndex(BuildContext context, index) {
    currentIndex = index;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Selected Text: ${texts[index].text}',
          style: TextStyle(
            fontSize: 16.0.sp,
          ),
        ),
        duration: const Duration(seconds: 1),
      ),
    );

    notifyListeners();
  }

  changeTextColor(Color color) {
    texts[currentIndex].color = color;
    notifyListeners();
  }

  void increaseFontSize() {
    if (texts[currentIndex].fontSize < 50) texts[currentIndex].fontSize += 2;

    notifyListeners();
  }

  decreaseFontSize() {
    if (texts[currentIndex].fontSize > 2) texts[currentIndex].fontSize -= 2;
    notifyListeners();
  }

  alignLeft() {
    texts[currentIndex].textAlign = TextAlign.left;
    notifyListeners();
  }

  alignCenter() {
    texts[currentIndex].textAlign = TextAlign.center;
    notifyListeners();
  }

  alignRight() {
    texts[currentIndex].textAlign = TextAlign.right;
    notifyListeners();
  }

  changeFontWeight() {
    if (texts[currentIndex].fontWeight == FontWeight.normal) {
      texts[currentIndex].fontWeight = FontWeight.bold;
    } else {
      texts[currentIndex].fontWeight = FontWeight.normal;
    }
    notifyListeners();
  }

  changeFontStyle() {
    if (texts[currentIndex].fontStyle == FontStyle.normal) {
      texts[currentIndex].fontStyle = FontStyle.italic;
    } else {
      texts[currentIndex].fontStyle = FontStyle.normal;
    }
    notifyListeners();
  }

  addLinesToText() {
    if (texts[currentIndex].text.contains('\n')) {
      texts[currentIndex].text = texts[currentIndex].text.replaceAll('\n', ' ');
    } else {
      texts[currentIndex].text = texts[currentIndex].text.replaceAll(' ', '\n');
    }
    notifyListeners();
  }

  removeText(BuildContext context, index) {
    currentIndex = index;

    texts.removeAt(currentIndex);

    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Text Removed',
        text: 'Text removed successfully!');
    notifyListeners();
  }
}
