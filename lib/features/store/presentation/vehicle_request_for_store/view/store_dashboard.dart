import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/profile/presentation/extension/date_time_extension.dart';
import 'package:nova_wheels/features/store/data/data_sources/store_datasource_impl.dart';
import 'package:nova_wheels/features/store/data/repositories/store_repo_impl.dart';
import 'package:nova_wheels/features/store/presentation/vehicle_request_for_store/bloc/vehicle_request_for_store_cubit.dart';
import 'package:nova_wheels/features/store/presentation/vehicle_request_for_store/view/requestor_profile_widget.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_buy_rent_request_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StoreDashboardPage extends StatelessWidget {
  final String storeId;

  const StoreDashboardPage({
    super.key,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VehicleRequestForStoreCubit>(
      create: (context) => VehicleRequestForStoreCubit(
        StoreRepoImpl(
          storeDataSource: StoreDataSourceImpl(
            supabaseClient: Supabase.instance.client,
          ),
        ),
      ),
      child: StoreDashboardView(
        storeId: storeId,
      ),
    );
  }
}

class StoreDashboardView extends StatefulWidget {
  final String storeId;

  const StoreDashboardView({super.key, required this.storeId});

  @override
  State<StoreDashboardView> createState() => _StoreDashboardViewState();
}

class _StoreDashboardViewState extends State<StoreDashboardView> {
  @override
  void initState() {
    context.read<VehicleRequestForStoreCubit>().fetchRequests(widget.storeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VehicleRequestForStoreCubit,
        VehicleRequestForStoreState>(
      listener: (context, state) {
        if (state is VehicleRequestForStoreError) {
          context.showSnackBar(
            state.errorMessage,
            color: Colors.red,
          );
        }
        if (state is VehicleRequestUpdateStatusSuccess) {
          context
              .read<VehicleRequestForStoreCubit>()
              .fetchRequests(widget.storeId);
          context.showSnackBar(
            "Request Updated Successfully",
            color: Colors.green,
          );
        }
      },
      builder: (context, state) {
        if (state is VehicleRequestForStoreLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is VehicleRequestForStoreSuccess) {
          final requests = state.requests;

          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<VehicleRequestForStoreCubit>()
                  .fetchRequests(widget.storeId);
            },
            child: ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return VehicleBuyRentRequestCard(request: request);
              },
            ),
          );
        }
        if (state is VehicleRequestForStoreError) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class VehicleBuyRentRequestCard extends StatelessWidget {
  const VehicleBuyRentRequestCard({super.key, required this.request});

  final VehicleBuyRentRequestEntity request;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 5, // Softer shadow for modern look
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15), // Slightly larger rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row with Request Type and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Request: ${request.requestType}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.blueAccent,
                  ),
                ),
                Text(
                  DateTime.parse(request.requestDate).mDYhms,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            const Divider(height: 20), // Divider for separation
            // Details Section
            _buildDetailRow("Status:", request.status),
            _buildDetailRow("Contact:", request.mobileNumber),
            if (request.email.isNotEmpty)
              _buildDetailRow("Email:", request.email),
            if (request.secondMobileNumber != null)
              _buildDetailRow("Alt Contact:", request.secondMobileNumber!),
            if (request.additionalDetails != null)
              _buildDetailRow("Details:", request.additionalDetails!),
            const Divider(height: 10),
            // Requested By Section
            RequesterProfileWidget(
              profileId: request.userId,
            ),
            const SizedBox(height: 15),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  context,
                  "Reject",
                  Colors.orange,
                  () => context
                      .read<VehicleRequestForStoreCubit>()
                      .updateRequestStatus(
                          requestId: request.id ?? '', status: 'rejected'),
                ),
                _buildActionButton(
                  context,
                  "Approve",
                  Colors.green,
                  () => context
                      .read<VehicleRequestForStoreCubit>()
                      .updateRequestStatus(
                          requestId: request.id ?? '', status: 'approved'),
                ),
                _buildActionButton(
                  context,
                  "Delete",
                  Colors.red,
                  () => context
                      .read<VehicleRequestForStoreCubit>()
                      .deleteRequest(
                          storeId: request.storeId,
                          requestId: request.id ?? ''),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$label ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Rounded buttons for smooth look
        ),
      ),
      child: Text(label),
    );
  }
}
