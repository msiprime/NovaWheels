import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImageButton extends StatefulWidget {
  final Function(List<XFile>) onTap;
  final List<XFile> listOfImage;

  const AddImageButton(
      {super.key, required this.onTap, required this.listOfImage});

  @override
  State<AddImageButton> createState() => _AddImageButtonState();
}

class _AddImageButtonState extends State<AddImageButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.listOfImage.length == 5
                  ? Icons.edit_outlined
                  : Icons.add_a_photo_outlined,
              color: Colors.grey,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() async {
    List<XFile> newList = List<XFile>.from(widget.listOfImage);
    newList.addAll(await ImagePicker().pickMultiImage());
    if (newList.length > 5) {
      newList = newList.reversed.toList().sublist(0, 5);
    }
    widget.onTap(newList);
  }
}
