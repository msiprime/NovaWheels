import 'package:app_ui/app_ui.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_fetch/bloc/user_store_fetch_bloc.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_fetch/widget/store_advertisement_tab.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_fetch/widget/store_details_tab.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_fetch/widget/store_statistic_tab.dart';
import 'package:nova_wheels/features/store/shared/widget/verification_chip.dart';

class UserStoreDetails extends StatelessWidget {
  final StoreEntity store;

  const UserStoreDetails({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserStoreFetchBloc(
          fetchUserStoreUseCase: sl.call(),
          fetchUserStoreByIdUseCase: sl.call())
        ..add(UserStoreByIdFetched(store.id)),
      child: BlocBuilder<UserStoreFetchBloc, UserStoreFetchState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<UserStoreFetchBloc>()
                  .add(UserStoreByIdFetched(store.id));
            },
            child: switch (state) {
              UserStoreFetchInitial() =>
                const Center(child: CircularProgressIndicator()),
              UserStoreFetchLoading() =>
                const Center(child: CircularProgressIndicator()),
              UserStoreFetchFailure() => Center(child: Text('message')),
              UserStoreFetchSuccess success => AppScaffold(
                  safeArea: true,
                  body: DefaultTabController(
                    length: 3,
                    child: CustomScrollView(
                      slivers: [
                        _StoreAppBar(store: success.stores.first),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _SliverTabBarDelegate(
                            _buildTabBarSection(),
                          ),
                        ),
                        SliverFillRemaining(
                          child: TabBarView(
                            children: [
                              // Tab 1: Advertisements
                              StoreAdvertisementsTab(
                                  store: success.stores.first),
                              // Tab 2: Statistics
                              StoreStatisticsTab(store: success.stores.first),
                              // Tab 3: Store Details
                              StoreDetailsTab(store: success.stores.first),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            },
          );
        },
      ),
    );
  }

  TabBar _buildTabBarSection() {
    return TabBar(
      labelColor: Colors.black,
      indicatorColor: Colors.blue,
      tabs: [
        Tab(text: 'Advertisements'),
        Tab(text: 'Statistics'),
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

class StoreDetailsCard extends StatelessWidget {
  final StoreEntity store;

  const StoreDetailsCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          shadowColor: Colors.black26,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(
                  label: 'Address',
                  value: store.address ?? 'Not provided',
                  icon: Icons.location_on,
                  context: context,
                ),
                _buildDetailRow(
                  label: 'Phone',
                  value: store.phoneNumber ?? 'Not provided',
                  icon: Icons.phone,
                  context: context,
                ),
                _buildDetailRow(
                  label: 'Email',
                  value: store.email ?? 'Not provided',
                  icon: Icons.email,
                  context: context,
                ),
                _buildDetailRow(
                  label: 'Created At',
                  value:
                      store.createdAt?.timeZoneOffset.toString() ?? 'Unknown',
                  icon: Icons.calendar_today,
                  context: context,
                ),
                _buildDetailRow(
                  label: 'Facebook',
                  value: store.facebook ?? 'Not linked',
                  icon: Icons.facebook,
                  context: context,
                ),
                _buildDetailRow(
                  label: 'Instagram',
                  value: store.instagram ?? 'Not linked',
                  icon: Icons.camera_alt,
                  context: context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    required IconData icon,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: context.theme.primaryColor.withOpacity(0.8),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '$label: ',
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.theme.primaryColor,
                ),
                children: [
                  TextSpan(
                    text: value,
                    style: context.titleMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
              .rotate(delay: 2100.ms, duration: 500.ms)
              .scale(delay: 400.ms)
              .slide(delay: 500.ms),
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
