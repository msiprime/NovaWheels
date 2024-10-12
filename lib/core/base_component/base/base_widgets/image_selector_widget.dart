import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nova_wheels/core/datasource/core_datasource.dart';
import 'package:nova_wheels/shared/values/app_values.dart';

import 'app_spacer.dart';
import 'image_grid_widget.dart';

class ImageSelectionWidget extends StatefulWidget {
  final String? hintText;
  final Function(List<String> listOfImageUrl) onImageSelected;

  const ImageSelectionWidget({
    super.key,
    this.hintText,
    required this.onImageSelected,
  });

  @override
  ImageSelectionWidgetState createState() => ImageSelectionWidgetState();
}

class ImageSelectionWidgetState extends State<ImageSelectionWidget> {
  final ValueNotifier<bool> uploading = ValueNotifier(false);
  List<String> listOfImageUrl = [];

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ValueListenableBuilder<bool>(
      valueListenable: uploading,
      builder: (context, isUploading, child) {
        return Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _handleTap,
              child: DottedBorder(
                color: themeData.colorScheme.primary,
                borderType: BorderType.RRect,
                radius: const Radius.circular(AppValues.halfPadding),
                dashPattern: const [6],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppValues.halfPadding),
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeData.canvasColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 20,
                          offset: Offset(0, -2),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: isUploading
                        ? const Center(child: CircularProgressIndicator())
                        : _buildImageAndImagePathSection(
                            context, listOfImageUrl),
                  ),
                ),
              ),
            ),
            const AppSpacer(
              height: AppValues.margin,
            ),
            ImageGridWidget(
              imageUrls: listOfImageUrl,
              onDelete: _deleteImage,
            )
          ],
        );
      },
    );
  }

  Widget _buildImageAndImagePathSection(
      BuildContext context, List<String> listOfImageUrl) {
    final themeData = Theme.of(context);
    return Icon(
      Icons.add,
      size: 17.45,
      color: themeData.colorScheme.surface,
    );
  }

  void _handleTap() async {
    if (listOfImageUrl.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You can only upload one image."),
        ),
      );
      return;
    }
    final file = await ImagePicker()
        .pickImage(imageQuality: 10, source: ImageSource.gallery);
    if (file == null) return;
    uploading.value = true;
    String imageUrl = await CoreDataSource.uploadStoreProfileImageToSupabase(
      File(file.path), // or 'cover' depending on your context
    );
    if (imageUrl.isNotEmpty) {
      listOfImageUrl.add(imageUrl);
      widget.onImageSelected(listOfImageUrl);
    }
    uploading.value = false;
  }

  void _deleteImage(String imageUrl) async {
    await CoreDataSource.deleteImageFromSupabase();
    setState(() {
      listOfImageUrl.remove(imageUrl);
    });
    widget.onImageSelected(listOfImageUrl);
  }
}
