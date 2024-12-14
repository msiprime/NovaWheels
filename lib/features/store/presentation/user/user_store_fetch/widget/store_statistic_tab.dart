import 'package:flutter/material.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/presentation/vehicle_request_for_store/view/store_dashboard.dart';

class StoreDashboardTab extends StatelessWidget {
  const StoreDashboardTab({
    super.key,
    required this.store,
  });

  final StoreEntity store;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StoreDashboardPage(
          storeId: store.id,
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
