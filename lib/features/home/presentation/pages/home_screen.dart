import 'package:flutter/material.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/sign_out_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignOutButton(),
            //Title
          ],
        ),
      ),
    );
  }
}
