import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_primary_button.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/store/domain/use_cases/delete_store_usecase.dart';
import 'package:nova_wheels/features/store/domain/use_cases/update_store_usecase.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_update/bloc/update_store_bloc.dart';

class StoreDeletionWidget extends StatelessWidget {
  const StoreDeletionWidget({
    super.key,
    required this.storeId,
  });

  final String storeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateStoreBloc(
        updateStoreUseCase: sl.call<UpdateStoreUseCase>(),
        deleteStoreUseCase: sl.call<DeleteStoreUseCase>(),
      ),
      child: StoreDeletionButton(storeId: storeId),
    );
  }
}

class StoreDeletionButton extends StatelessWidget {
  const StoreDeletionButton({super.key, required this.storeId});

  final String storeId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateStoreBloc, UpdateStoreState>(
      listener: (context, state) {
        if (state is DeleteStoreSuccess) {
          context.pushReplacementNamed(Routes.userStores, extra: storeId);
        }
      },
      builder: (context, state) {
        return AppPrimaryButton(
            height: 40,
            isLoading: state is DeleteStoreLoading,
            onPressed: () {
              context.confirmAction(
                yesText: 'Delete',
                noText: 'Cancel',
                fn: () {
                  context
                      .read<UpdateStoreBloc>()
                      .add(DeleteStorePressed(storeId: storeId));
                },
                title: 'Confirm Deletion',
                content:
                    'Are you sure you want to delete this store? This action cannot be undone.',
              );
            },
            title: 'Delete Store');
      },
    );
  }
}
