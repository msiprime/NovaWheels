import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SmallAdvertisementCard extends StatelessWidget {
  const SmallAdvertisementCard({
    super.key,
    required this.title,
    required this.coverPhoto,
    this.isForRent = false,
    this.isForSale = false,
    this.rentPrice,
    this.salePrice,
  });

  final String title;
  final String coverPhoto;
  final bool isForRent;
  final bool isForSale;
  final String? rentPrice;
  final String? salePrice;

  @override
  Widget build(BuildContext context) {
    final tags = [
      if (isForRent) 'For Rent',
      if (isForSale) 'For Sale',
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.theme.colorScheme.surface, // Background color
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Photo
          Stack(
            children: [
              ImageAttachmentThumbnail(
                borderRadius: BorderRadius.zero,
                imageUrl: coverPhoto,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Wrap(
                  spacing: 4,
                  children: tags
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryDarkBlue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            tag,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),

          // Title and Price
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                const Gap(4),
                Text(
                  _buildPriceText(),
                  style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.primaryColor),
                  overflow: TextOverflow.ellipsis,
                  textScaler: const TextScaler.linear(1),
                ),
              ],
            ),
          ),

          // User Info
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Row(
              children: [
                ImageAttachmentThumbnail(
                  borderRadius: BorderRadius.circular(5.6),
                  imageUrl: coverPhoto,
                  width: 26,
                  height: 26,
                  fit: BoxFit.cover,
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
            ),
          ),
        ],
      ),
    );
  }

  String _buildPriceText() {
    final prices = [
      if (isForRent && rentPrice != null) 'Rent: \$${rentPrice!}',
      if (isForSale && salePrice != null) 'Sale: \$${salePrice!}',
    ];
    return prices.join(' | ');
  }
}
