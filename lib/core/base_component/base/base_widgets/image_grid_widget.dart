import 'package:flutter/material.dart';

class ImageGridWidget extends StatelessWidget {
  final List<String> imageUrls;
  final Function(String imageUrl) onDelete;

  const ImageGridWidget(
      {super.key, required this.imageUrls, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8, // Horizontal space between images
      runSpacing: 8, // Vertical space between images
      children: imageUrls.map((url) => _buildImageItem(url)).toList(),
    );
  }

  Widget _buildImageItem(String url) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            url,
            width: 75, // Set width as per your requirement
            height: 75, // Set height as per your requirement
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => onDelete(url),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.delete,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
