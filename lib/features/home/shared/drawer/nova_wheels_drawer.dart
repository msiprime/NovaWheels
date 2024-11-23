import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/sign_out_button.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/nova_wheels_ai/view/ai_prompt_screen.dart';

class NovaWheelsDrawer extends StatelessWidget {
  const NovaWheelsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'John Doe',
                  style: context.titleMedium?.copyWith(color: Colors.white),
                ),
                Text(
                  'johndoe@example.com',
                  style: context.bodySmall?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    // Handle navigation to Home
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.directions_car),
                  title: const Text('Vehicles'),
                  onTap: () {
                    // Navigate to vehicles screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.store),
                  title: const Text('My Store'),
                  onTap: () {
                    context.pushNamed(Routes.userStores);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.support),
                  title: const Text('Support'),
                  onTap: () {
                    // Navigate to support screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.chat),
                  title: const Text('Ask Nova Wheels AI'),
                  onTap: () {
                    context.pushNamed(AiPromptScreen.routeName);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    context.pushNamed(Routes.settings);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Help'),
                  onTap: () {
                    // Navigate to help screen
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SignOutButton(),
          ),
        ],
      ),
    );
  }
}
