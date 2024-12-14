import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:nova_wheels/features/profile/presentation/extension/date_time_extension.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/presentation/vehicle_request_for_store/view/requestor_profile_widget.dart';
import 'package:url_launcher/url_launcher.dart'; // Import for launching URLs

class PublicStoreDetailsTab extends StatelessWidget {
  const PublicStoreDetailsTab({
    super.key,
    required this.store,
  });

  final StoreEntity store;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store Header
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderTile(
                        context, 'Created At', store.createdAt!.mDY),
                    _buildHeaderTile(context, 'Address', store.address ?? ''),
                    _buildHeaderTile(context, 'Phone', store.phoneNumber ?? ''),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Social Links Section
            if (store.hasSocialLinks) ...[
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Social Links',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildSocialLink(context, 'Website', store.website),
                      _buildSocialLink(context, 'Email', store.email),
                      _buildSocialLink(context, 'Instagram', store.instagram),
                      _buildSocialLink(context, 'Facebook', store.facebook),
                      _buildSocialLink(context, 'Twitter', store.twitter),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Description Section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: _buildSection(
                  context,
                  title: 'Description',
                  content: store.description ?? 'No description available.',
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Owner Section
            const Divider(thickness: 1),
            RequesterProfileWidget(
              profileId: store.ownerId ?? '',
              text: 'Owned By:',
            ),
            5.gap,
          ],
        ),
      ),
    );
  }

  // Helper function to build header tiles
  Widget _buildHeaderTile(BuildContext context, String title, String value) {
    return ListTile(
      title: Text(title,
          style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
      subtitle: Text(value, style: context.titleMedium),
      contentPadding: EdgeInsets.zero, // Remove ListTile padding
      dense: true, // Reduce spacing
    );
  }

  // Helper function to build social links with launch functionality
  Widget _buildSocialLink(BuildContext context, String label, String? link) {
    if (link == null || link.isEmpty) return const SizedBox.shrink();

    return InkWell(
      onTap: () async {
        final url = Uri.parse(link);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          // Handle error if the URL can't be launched
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch $link')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Text(
              '$label: ',
              style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              link,
              style: context.titleMedium?.copyWith(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build sections (description, contact info)
  Widget _buildSection(BuildContext context,
      {required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: context.titleMedium,
        ),
      ],
    );
  }
}

// ... (StoreDetailsCard remains the same)
