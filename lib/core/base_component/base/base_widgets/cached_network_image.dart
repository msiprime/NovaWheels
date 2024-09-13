import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CachedNetworkImage extends StatelessWidget {
  final String imageUrl;

  const CachedNetworkImage({
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: precacheImage(NetworkImage(imageUrl), context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // just return Circular Progress Bar if u want
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.withOpacity(0.1),
            ),
            height: 200,
          )
              .animate(
                onPlay: (controller) => controller.repeat(reverse: true),
              )
              .shimmer(duration: const Duration(seconds: 1));
        } else if (snapshot.hasError) {
          return const Icon(Icons.error);
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              errorBuilder: (context, error, stackTrace) => const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("⚠ Image url fetching error!!"),
              ),
              imageUrl,
              key: ValueKey(imageUrl),
              fit: BoxFit.cover,
            ),
          ).animate(delay: 100.ms).scaleXY();
        }
      },
    );
  }
}
