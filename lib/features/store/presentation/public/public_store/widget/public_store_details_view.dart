import 'package:app_ui/app_ui.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/presentation/public/public_store/widget/public_store_details_tab.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_fetch/widget/store_advertisement_tab.dart';
import 'package:nova_wheels/features/store/shared/widget/verification_chip.dart';
import 'package:shared/shared.dart';

class GeneralStoreDetails extends StatelessWidget {
  final StoreEntity store;

  const GeneralStoreDetails({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    logE('UserStoreDetails ${store.id}');

    return AppScaffold(
      safeArea: true,
      body: DefaultTabController(
        length: 3,
        child: CustomScrollView(
          slivers: [
            _StoreAppBar(store: store),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverTabBarDelegate(
                _buildTabBarSection(),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  StoreAdvertisementsTab(store: store),
                  PublicStoreDetailsTab(store: store),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TabBar _buildTabBarSection() {
    return TabBar(
      labelColor: Colors.black,
      indicatorColor: Colors.blue,
      tabs: [
        Tab(text: 'Advertisements'),
        // Tab(text: 'Dashboard'),
        Tab(text: 'Store Details'),
      ],
    );
  }
}

class _StoreAppBar extends StatelessWidget {
  const _StoreAppBar({
    required this.store,
  });

  final StoreEntity store;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(store.name),
      floating: false,
      expandedHeight: 350,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        stretchModes: [StretchMode.zoomBackground],
        titlePadding: const EdgeInsets.only(left: 16, bottom: 0),
        background: _ProfileAndCoverSpace(store: store),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _ProfileAndCoverSpace extends StatelessWidget {
  const _ProfileAndCoverSpace({
    required this.store,
  });

  final StoreEntity store;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ImageAttachmentThumbnail(
            height: 250,
            width: double.infinity,
            imageUrl: store.coverImage ?? '',
          ),
          Positioned(
            left: 10,
            top: 190,
            child: DottedBorder(
              borderType: BorderType.Circle,
              borderPadding: const EdgeInsets.all(1),
              color: Colors.grey.shade50,
              strokeWidth: 2,
              stackFit: StackFit.loose,
              dashPattern: [1, 0],
              child: ClipOval(
                clipBehavior: Clip.antiAlias,
                child: ImageAttachmentThumbnail(
                  height: 120,
                  width: 120,
                  imageUrl: store.profilePicture ?? '',
                ),
              ),
            ),
          )
              .animate()
              .rotate(
                  delay: NumDurationExtension(2100).microseconds,
                  duration: NumDurationExtension(500).microseconds)
              .scale(delay: NumDurationExtension(400).microseconds)
              .slide(delay: NumDurationExtension(500).microseconds),
          Positioned(
            right: 10,
            top: 270,
            child: SlimVerificationLabel(isVerified: store.isVerified),
          ),
          Positioned(
            left: 150,
            top: 264,
            child: SizedBox(
              width: 170,
              child: Text(
                store.name,
                style: context.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
