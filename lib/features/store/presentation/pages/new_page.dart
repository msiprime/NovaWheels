import 'package:flutter/material.dart';
import 'package:nova_wheels/features/store/presentation/widgets/all_store_widget.dart';
import 'package:nova_wheels/features/store/presentation/widgets/user_store_widget.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: UserStoresWidget(),
    );
  }
}

class NewPage2 extends StatelessWidget {
  const NewPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: AllStoresWidget(),
    );
  }
}
