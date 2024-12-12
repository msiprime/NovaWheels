import 'package:app_ui/app_ui.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

//ignore_for_file: public_member_api_docs
class AppCarouselSlider extends StatelessWidget {
  AppCarouselSlider({
    required this.imageUrls,
    required this.height,
    super.key,
    this.radius = 12.0,
    this.aspectRatio = 1.0,
    this.indicatorSize = 6.0,
    this.selectedIndicatorSize = 8.0,
    this.autoPlay = true,
    this.enlargeCenterPage = true,
    this.activeIndicatorColor = Colors.white,
    this.inactiveIndicatorColor = Colors.grey,
    this.bottomRadiusEnabled = true,
    this.scale = 1.0,
  });

  final double radius;
  final List<String> imageUrls;
  final double aspectRatio;
  final double indicatorSize;
  final double selectedIndicatorSize;
  final bool autoPlay;
  final bool enlargeCenterPage;
  final Color activeIndicatorColor;
  final Color inactiveIndicatorColor;
  final double height;
  final double scale;
  final bool bottomRadiusEnabled;

  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.image_not_supported_outlined,
                color: Colors.grey,
                size: 40,
              ),
              Text(
                'No images available',
                style: context.titleMedium,
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: height,
          width: double.infinity,
          child: CarouselSlider.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index, realIndex) {
              return ClipRRect(
                borderRadius: !bottomRadiusEnabled
                    ? BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        topRight: Radius.circular(radius),
                      )
                    : BorderRadius.all(Radius.circular(radius)),
                child: RepaintBoundary(
                  child: ImageAttachmentThumbnail(
                    height: height,
                    scale: scale,
                    imageUrl: imageUrls[index],
                    borderRadius: !bottomRadiusEnabled
                        ? BorderRadius.only(
                            topLeft: Radius.circular(radius),
                            topRight: Radius.circular(radius),
                          )
                        : BorderRadius.all(Radius.circular(radius)),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              autoPlayAnimationDuration: const Duration(milliseconds: 500),
              autoPlayCurve: Curves.ease,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              viewportFraction: 1,
              autoPlay: autoPlay,
              enlargeCenterPage: enlargeCenterPage,
              aspectRatio: aspectRatio,
              onPageChanged: (index, reason) {
                _currentIndexNotifier.value = index;
              },
            ),
          ),
        ),
        Positioned(
          top: height - 30,
          child: ValueListenableBuilder<int>(
            valueListenable: _currentIndexNotifier,
            builder: (context, currentIndex, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(imageUrls.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: currentIndex == index
                        ? selectedIndicatorSize
                        : indicatorSize,
                    height: currentIndex == index
                        ? selectedIndicatorSize
                        : indicatorSize,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index
                          ? activeIndicatorColor
                          : inactiveIndicatorColor,
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
