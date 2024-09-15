// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ibenture/components/edit_image_view_model.dart';
import 'package:ibenture/models/text_info.dart';
import 'package:ibenture/provider/edit_image_provider.dart';
import 'package:provider/provider.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({super.key});

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditImageProvider>(context, listen: false);

    return Scaffold(
      appBar: _buildAppBar(provider),
      body: SafeArea(
          child: RepaintBoundary(
            key: stackKey, // Wrap the Stack with RepaintBoundary
            child: Stack(
              children: [
                _selectedImage,
                for (int i = 0; i < provider.texts.length; i++)
                  ResizableWidget(
                    textInfo: provider.texts[i],
                    i: i,
                  ),
                creatorText.text.isNotEmpty
                    ? Positioned(
                        left: 0,
                        bottom: 0,
                        child: Text(
                          creatorText.text,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          )),
      floatingActionButton: _addText,
    );
  }

  AppBar _buildAppBar(EditImageProvider provider) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            IconButton(
              icon: const Icon(Icons.picture_as_pdf, color: Colors.black),
              onPressed: () => saveAsPDF(context),
              tooltip: 'Save PDF',
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.black),
              onPressed: () {
                provider.increaseFontSize();
                setState(() {});
              },
              tooltip: 'Increase font size',
            ),
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.black),
              onPressed: () {
                provider.decreaseFontSize();
                setState(() {});
              },
              tooltip: 'Decrease font size',
            ),
            IconButton(
              icon: const Icon(Icons.format_align_left, color: Colors.black),
              onPressed: () {
                provider.alignLeft();
                setState(() {});
              },
              tooltip: 'Align Left',
            ),
            IconButton(
              icon: const Icon(Icons.format_align_center, color: Colors.black),
              onPressed: () {
                provider.alignCenter();
                setState(() {});
              },
              tooltip: 'Align Center',
            ),
            IconButton(
              icon: const Icon(Icons.format_align_right, color: Colors.black),
              onPressed: () {
                provider.alignRight();
                setState(() {});
              },
              tooltip: 'Align Right',
            ),
            IconButton(
              icon: const Icon(Icons.format_bold, color: Colors.black),
              onPressed: () {
                provider.changeFontWeight();
                setState(() {});
              },
              tooltip: 'Bold',
            ),
            IconButton(
              icon: const Icon(Icons.format_italic, color: Colors.black),
              onPressed: () {
                provider.changeFontStyle();
                setState(() {});
              },
              tooltip: 'Italic',
            ),
            IconButton(
              icon: const Icon(Icons.space_bar, color: Colors.black),
              onPressed: () {
                provider.addLinesToText();
                setState(() {});
              },
              tooltip: 'Add New Line',
            ),
            Gap(10.w),
            Tooltip(
              message: 'Black',
              child: GestureDetector(
                onTap: () {
                  provider.changeTextColor(Colors.black);
                  setState(() {});
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.black,
                ),
              ),
            ),
            Gap(10.w),
            Tooltip(
              message: 'Yellow',
              child: GestureDetector(
                onTap: () {
                  provider.changeTextColor(Colors.yellow);
                  setState(() {});
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.yellow,
                ),
              ),
            ),
            Gap(10.w),
            Tooltip(
              message: 'Blue',
              child: GestureDetector(
                onTap: () {
                  provider.changeTextColor(Colors.blue);
                  setState(() {});
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
            Gap(10.w),
            Tooltip(
              message: 'Green',
              child: GestureDetector(
                onTap: () {
                  provider.changeTextColor(Colors.green);
                  setState(() {});
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.green,
                ),
              ),
            ),
            Gap(10.w),
            Tooltip(
              message: 'Purple',
              child: GestureDetector(
                onTap: () {
                  provider.changeTextColor(Colors.purple);
                  setState(() {});
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.purple,
                ),
              ),
            ),
            Gap(10.w),
            Tooltip(
              message: 'Red',
              child: GestureDetector(
                onTap: () {
                  provider.changeTextColor(Colors.red);
                  setState(() {});
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            Gap(10.w),
            Tooltip(
              message: 'Orange',
              child: GestureDetector(
                onTap: () {
                  provider.changeTextColor(Colors.orange);
                  setState(() {});
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.orange,
                ),
              ),
            ),
            Gap(10.w),
            Tooltip(
              message: 'Turquoise',
              child: GestureDetector(
                onTap: () {
                  provider.changeTextColor(const Color(0xff2ecec2));
                  setState(() {});
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xff2ecec2),
                ),
              ),
            ),
            Gap(10.w),
            Tooltip(
              message: 'Indigo',
              child: GestureDetector(
                onTap: () {
                  provider.changeTextColor(const Color(0xff4b0082));
                  setState(() {});
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xff4b0082),
                ),
              ),
            ),
            Gap(10.w),
            Tooltip(
              message: 'Pink',
              child: GestureDetector(
                onTap: () {
                  provider.changeTextColor(Colors.pink);
                  setState(() {});
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.pink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _selectedImage => Center(
        child: Consumer<EditImageProvider>(builder: (context, provider, child) {
          return Image.file(
            File(provider.selectedImage!),
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
          );
        }),
      );

  Widget get _addText => FloatingActionButton(
        onPressed: () {
          addNewDialog(context);
          textController.clear();
        },
        backgroundColor: Colors.white,
        tooltip: 'Add Text',
        child: const Icon(
          Icons.edit,
          color: Color(0xFF311A72),
        ),
      );
}

// ignore: must_be_immutable
class ResizableWidget extends StatefulWidget {
  final TextInfo textInfo;
  int i;

  ResizableWidget({
    super.key,
    required this.textInfo,
    required this.i,
  });

  @override
  _ResizableWidgetState createState() => _ResizableWidgetState();
}

class _ResizableWidgetState extends State<ResizableWidget> {
  late double width;
  late double height;
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    width = 100;
    height = 100;
  }

  void toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.textInfo.left,
      top: widget.textInfo.top,
      child: GestureDetector(
        onTap: () {
          toggleEditMode();
          final provider =
              Provider.of<EditImageProvider>(context, listen: false);
          provider.setCurrentIndex(context, widget.i);
        },
        onLongPress: () {
          final provider =
              Provider.of<EditImageProvider>(context, listen: false);
          provider.removeText(context, widget.i);
        },
        onPanUpdate: (details) {
          setState(() {
            widget.textInfo.left += details.delta.dx;
            widget.textInfo.top += details.delta.dy;
          });
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: isEditMode
                  ? BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    )
                  : null,
              width: width,
              height: height,
              child: Text(
                widget.textInfo.text,
                style: TextStyle(
                  color: widget.textInfo.color,
                  fontWeight: widget.textInfo.fontWeight,
                  fontStyle: widget.textInfo.fontStyle,
                  fontSize: widget.textInfo.fontSize,
                ),
                textAlign: widget.textInfo.textAlign,
              ),
            ),
            if (isEditMode) ...[
              Positioned(
                right: -5,
                bottom: -5,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      width += details.delta.dx;
                      height += details.delta.dy;
                    });
                  },
                  child: SizedBox(
                    width: 15,
                    height: 15,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -5,
                top: -5,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      width += details.delta.dx;
                      height -= details.delta.dy;
                    });
                  },
                  child: SizedBox(
                    width: 15,
                    height: 15,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -5,
                bottom: -5,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      width -= details.delta.dx;
                      height += details.delta.dy;
                    });
                  },
                  child: SizedBox(
                    width: 15,
                    height: 15,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -5,
                top: -5,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      width -= details.delta.dx;
                      height -= details.delta.dy;
                    });
                  },
                  child: SizedBox(
                    width: 15,
                    height: 15,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
