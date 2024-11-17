import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/features/store/domain/use_cases/delete_store_usecase.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_update/bloc/update_store_bloc.dart';

class UserStoreUpdatePage extends StatelessWidget {
  static const String routeName = 'user-store-update';
  const UserStoreUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateStoreBloc(
        deleteStoreUseCase: sl.call<DeleteStoreUseCase>(),
      ),
      child: UpdateStoreView(),
    );
  }
}

class UpdateStoreView extends StatelessWidget {
  const UpdateStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: SizedBox(),
    );
  }
}
