import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/store/presentation/blocs/fetch_store_bloc/fetch_store_bloc.dart';
import 'package:nova_wheels/features/store/presentation/widgets/my_store_widget.dart';

class ManageOwnedStoreScreen extends StatelessWidget {
  const ManageOwnedStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: NovaWheelsAppBar(
        title: 'Manage Your Store',
      ),
      safeArea: true,
      body: Column(
        children: [
          MyStoreWidget(type: FetchStoreType.userStores),
          Center(
            child: Tappable.faded(
              throttle: false,
              throttleDuration: Duration(seconds: 5),
              fadeStrength: FadeStrength.md,
              borderRadius: 8,
              backgroundColor: context.theme.primaryColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Text('Create your store here',
                    style: context.theme.textTheme.bodyLarge
                        ?.copyWith(color: context.reversedAdaptiveColor)),
              ),
              onTap: () async {
                context.goNamed(Routes.createStore);
              },
            ),
          ),
        ],
      ),
    );
  }
}
