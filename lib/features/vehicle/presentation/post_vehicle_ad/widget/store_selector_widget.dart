import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_fetch/bloc/user_store_fetch_bloc.dart';

class StoreSelectorWidget extends StatelessWidget {
  final Function(String? storeId) onSelected;

  const StoreSelectorWidget({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserStoreFetchBloc(
        fetchUserStoreUseCase: sl.get(),
        fetchUserStoreByIdUseCase: sl.get(),
      )..add(UserStoreFetched()),
      child: StoreSelectorView(onSelected: onSelected),
    );
  }
}

class StoreSelectorView extends StatefulWidget {
  final Function(String? storeId) onSelected;

  const StoreSelectorView({super.key, required this.onSelected});

  @override
  State<StoreSelectorView> createState() => _StoreSelectorViewState();
}

class _StoreSelectorViewState extends State<StoreSelectorView> {
  String? _selectedStoreId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserStoreFetchBloc, UserStoreFetchState>(
      builder: (context, state) {
        if (state is UserStoreFetchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserStoreFetchSuccess) {
          final stores = state.stores;

          if (stores.isEmpty) {
            return const Center(
              child: Text(
                "No stores available. Please create a store first.",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Select a Store to post your vehicle',
                      style: context.titleMedium,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        context
                            .read<UserStoreFetchBloc>()
                            .add(UserStoreFetched());
                      },
                      icon: const Icon(Icons.refresh)),
                ],
              ),
              10.gap,
              SizedBox(
                height: 150,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // Single row
                    childAspectRatio: 1.2, // Adjust width/height of cards
                    mainAxisSpacing: 12, // Spacing between items
                  ),
                  itemCount: stores.length,
                  itemBuilder: (context, index) {
                    final store = stores[index];
                    final isSelected = store.id == _selectedStoreId;

                    return Tappable.scaled(
                      scaleStrength: ScaleStrength.xxxs,
                      onTap: () {
                        setState(() {
                          _selectedStoreId = isSelected ? null : store.id;
                        });
                        widget.onSelected(_selectedStoreId);
                      },
                      child: Card(
                        elevation: isSelected ? 8 : 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue[50] : Colors.white,
                            border: isSelected
                                ? Border.all(color: Colors.blue, width: 2)
                                : null,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: store.profilePicture ?? '',
                                // Provide a default or empty string if null
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  radius: 25,
                                  backgroundImage: imageProvider,
                                ),
                                placeholder: (context, url) => const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                  radius: 25,
                                  child: Icon(Icons.store, size: 30),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: Text(
                                  store.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is UserStoreFetchFailure) {
          return Center(
            child: Text(
              "Failed to fetch stores: ${state.errorMessage}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
