import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/core/routes/routes.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: NovaWheelsAppBar(
          title: 'Store',
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            Tappable.faded(
              fadeStrength: FadeStrength.lg,
              borderRadius: 8,
              backgroundColor: context.theme.primaryColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Text('Create your store here',
                    style: context.theme.textTheme.bodyLarge
                        ?.copyWith(color: context.reversedAdaptiveColor)),
              ),
              onTap: () {
                context.goNamed(Routes.createStore);
              },
            ),
          ],
        ));
  }
}
