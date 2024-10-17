import 'package:app_ui/app_ui.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
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
      appBar: NovaWheelsAppBar(
        title: store.name,
      ),
      safeArea: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _ProfileAndCoverSpace(store: store),
          const Gap(20),
          _NameAndDescription(store: store),
          const Gap(10),
          DefaultTabController(
            length: 2,
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    labelColor: context.theme.primaryColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: context.theme.primaryColor,
                    indicatorWeight: 3,
                    tabs: const [
                      Tab(text: 'Advertisements'),
                      Tab(text: 'Store Info'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        UserStoreAdvertisement(storeId: store.id),
                        StoreDetailsCard(store: store),
                      ],
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
