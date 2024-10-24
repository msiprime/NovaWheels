import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SmallAdvertisementCard extends StatelessWidget {
  const SmallAdvertisementCard({
    super.key,
    required this.title,
    required this.price,
    required this.coverPhoto,
  });

  final String title;
  final String price;
  final String coverPhoto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      height: 218,
      decoration: BoxDecoration(
        color: const Color(0xFFf2f2f7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(
              coverPhoto,
              height: 128,
              width: 128,
              fit: BoxFit.cover,
            ),
          ),
          // const VSpace(AppValues.extraSmallPadding),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textScaler: const TextScaler.linear(1),
                ),
                // const AppSpacer(height: 4),
                Text(
                  price,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textScaler: const TextScaler.linear(1),
                ),
                // const AppSpacer(height: 4),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.2),
                      child: Image.network(
                        coverPhoto,
                        width: 26,
                        height: 26,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dummy User",
                            style: context.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textScaler: const TextScaler.linear(1),
                          ),
                          Text(
                            'Rating 4.5',
                            style: context.textTheme.labelSmall
                                ?.copyWith(color: Colors.deepOrange),
                            overflow: TextOverflow.ellipsis,
                            textScaler: const TextScaler.linear(1),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
