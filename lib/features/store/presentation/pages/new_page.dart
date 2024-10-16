import 'package:flutter/material.dart';
import 'package:nova_wheels/features/store/presentation/pages/store_screen.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: MyStoresWidget(),
    );
  }
}
