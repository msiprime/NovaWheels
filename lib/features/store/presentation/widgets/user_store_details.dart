import 'package:app_ui/app_ui.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/presentation/widgets/small_advertisement_card.dart';
import 'package:nova_wheels/features/store/presentation/widgets/verification_chip.dart';
import 'package:nova_wheels/features/vehicle/presentation/blocs/vehicle_bloc.dart';

class UserStoreDetails extends StatelessWidget {
  final StoreEntity store;

  const UserStoreDetails({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeArea: true,
      body: DefaultTabController(
        length: 3,
        child: CustomScrollView(
          slivers: [
            StoreAppBar(store: store),
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
                  _StoreAdvertisementsTab(store: store),
                  // Tab 2: Statistics
                  _StoreStatisticsTab(store: store),
                  // Tab 3: Store Details
                  _StoreDetailsTab(store: store),
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
        Tab(text: 'Statistics'),
        Tab(text: 'Store Details'),
      ],
    );
  }
}

class StoreAppBar extends StatelessWidget {
  const StoreAppBar({
    super.key,
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

class _StoreAdvertisementsTab extends StatelessWidget {
  const _StoreAdvertisementsTab({
    required this.store,
  });

  final StoreEntity store;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Container(
                  height: 300,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  color: Colors.blueGrey[100 * ((index % 8) + 1)],
                  child: Center(child: Text('Advertisement $index')),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StoreStatisticsTab extends StatelessWidget {
  const _StoreStatisticsTab({
    required this.store,
  });

  final StoreEntity store;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Summary',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                _buildStatisticRow('Total Cars:', '50'),
                _buildStatisticRow('Cars for Rent:', '20'),
                _buildStatisticRow('Cars for Sale:', '30'),
                _buildStatisticRow('Services Available:', '5'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _StoreDetailsTab extends StatelessWidget {
  const _StoreDetailsTab({
    required this.store,
  });

  final StoreEntity store;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(
                context,
                title: 'Store Owner',
                value: store.ownerId ?? 'Unknown',
              ),
              const Divider(thickness: 1),
              const SizedBox(height: 16),
              _buildSection(
                context,
                title: 'Description',
                content: store.description ?? 'No description available.',
              ),
              const SizedBox(height: 16),
              _buildSection(
                context,
                title: 'Contact Information',
                content:
                    store.phoneNumber ?? 'No contact information available.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context,
      {required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
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

class UserStoreAdvertisement extends StatelessWidget {
  const UserStoreAdvertisement({
    super.key,
    required this.storeId,
  });

  final String storeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl.get<VehicleBloc>()..add(VehicleByStoreFetched(storeId: storeId)),
      child: AppScaffold(
        body: BlocBuilder<VehicleBloc, VehicleState>(
          builder: (context, state) {
            return switch (state) {
              VehicleInitial() =>
                const Center(child: CircularProgressIndicator()),
              VehicleLoading() =>
                const Center(child: CircularProgressIndicator()),
              VehicleError() => Center(child: Text('message')),
              VehicleLoaded() => SmallAdvertisementCard(
                  title: state.vehicles.first.model ?? '',
                  coverPhoto: state.vehicles.first.images?.coverPhoto ?? '',
                  price: state.vehicles.first.price.toString(),
                ),
            };
          },
        ),
      ),
    );
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
                  value: store.createdAt.timeZoneOffset.toString(),
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

class _NameAndDescription extends StatelessWidget {
  const _NameAndDescription({
    required this.store,
  });

  final StoreEntity store;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            store.name,
            style: context.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.theme.primaryColor.withOpacity(0.8),
            ),
          ),
          Text(
            store.description ?? '',
            style: context.titleMedium,
          ),
          const Gap(10),
          const Divider(),
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
        ],
      ),
    );
  }
}
