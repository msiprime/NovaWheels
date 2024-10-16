import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/store/presentation/pages/new_page.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: NovaWheelsAppBar(
          title: 'Store',
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              Text('My Stores', style: context.theme.textTheme.bodyLarge),
              const SizedBox(
                height: 16,
              ),
              FilledButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewPage(),
                        ));
                  },
                  child: Text("Go to another freaking page")),
              FilledButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewPage2(),
                        ));
                  },
                  child: Text("Go to another freaking page 2")),
              const SizedBox(
                height: 16,
              ),
              Tappable.faded(
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
            ],
          ),
        ));
  }
}
