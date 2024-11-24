import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_primary_button.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_update/view/user_store_update_page.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_update/widget/store_deletion_widget.dart';

class StoreDetailsTab extends StatelessWidget {
  const StoreDetailsTab({
    super.key,
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
          child: SingleChildScrollView(
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
                const SizedBox(height: 20),
                AppSecondaryButton(
                  height: 40,
                  onPressed: () {
                    context.pushNamed(
                      UserStoreUpdatePage.routeName,
                      extra: store.id,
                    );
                  },
                  title: "Update Store",
                ),
                const SizedBox(height: 16),
                StoreDeletionWidget(storeId: store.id),
              ],
            ),
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
