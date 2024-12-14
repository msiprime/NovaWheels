import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/store/data/data_sources/store_datasource_impl.dart';
import 'package:nova_wheels/features/store/data/repositories/store_repo_impl.dart';
import 'package:nova_wheels/features/store/presentation/vehicle_request_for_store/bloc/vehicle_request_for_store_cubit.dart';
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
      listener: (context, state) {},
      builder: (context, state) {
        if (state is VehicleRequestForStoreLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is VehicleRequestForStoreError) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is VehicleRequestForStoreSuccess) {
          final requests = state.requests;

          if (requests.isEmpty) {
            return const Center(
              child: Text("No vehicle requests found."),
            );
          }

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return _buildRequestCard(request);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildRequestCard(VehicleBuyRentRequestEntity request) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Request Type: ${request.requestType}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("Status: ${request.status}"),
            Text("Contact: ${request.mobileNumber}"),
            if (request.email.isNotEmpty) Text("Email: ${request.email}"),
            if (request.secondMobileNumber != null)
              Text("Alt Contact: ${request.secondMobileNumber}"),
            if (request.additionalDetails != null)
              Text("Details: ${request.additionalDetails}"),
            const SizedBox(height: 8),
            Text(
              "Requested on: ${request.requestDate}",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Handle approve request
                  },
                  child: const Text(
                    "Approve",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle reject request
                  },
                  child: const Text(
                    "Reject",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
